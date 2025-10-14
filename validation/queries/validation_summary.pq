// query: validation_summary
// source: fitness_data_validation
// purpose: aggregate validation and completeness metrics across all records, calculating total counts and percentages for each category
// notes: relies on results generated in fitness_data_validation and rule definitions in validation_rules
// author: monika burnejko | 2025

let
    // source and total record count
    source=fitness_data_validation,
    total_rows=Table.RowCount(source),

    // helper: summarize one category column with fixed label set
    summarize_category=(tbl as table, col_name as text, categories as list, metric_label as text)=>
        let
            grouped=Table.Group(tbl,{col_name},{{"record_count",each Table.RowCount(_),Int64.Type}}),
            renamed_grouped=Table.RenameColumns(grouped,{{col_name,"category"}}),
            cat_table=Table.FromList(categories,Splitter.SplitByNothing(),{"category"}),
            joined=Table.NestedJoin(cat_table,{"category"},renamed_grouped,{"category"},"tmp",JoinKind.LeftOuter),
            expanded=Table.ExpandTableColumn(joined,"tmp",{"record_count"},{"record_count"}),
            filled=Table.ReplaceValue(expanded,null,0,Replacer.ReplaceValue,{"record_count"}),
            with_metric=Table.AddColumn(filled,"metric",each metric_label,type text)
        in
            with_metric,

    // summaries
    flag_summary=summarize_category(source,"data_validation_flag",{"Valid","Check","Invalid","NoData"},"Validation"),
    compl_summary=summarize_category(source,"data_completeness",{"Complete","Incomplete"},"Completeness"),

    // combine and percentages
    unified=Table.Combine({flag_summary,compl_summary}),
    with_pct=Table.AddColumn(unified,"percent_of_total",each if total_rows=0 then 0 else Number.Round([record_count]/total_rows*100,2),type number),

    // final formatting
    final=Table.Sort(Table.ReorderColumns(with_pct,{"metric","category","record_count","percent_of_total"}),{{"metric",Order.Ascending},{"category",Order.Ascending}})
in
    final