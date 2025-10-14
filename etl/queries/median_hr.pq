// query: median_hr
// source: fitness_data_base
// purpose: calculate median average_hr per workout_type to support imputation in fitness_data_final
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monika burnejko | 2025

let
    // source
    source=fitness_data_base,

    // keep only required columns
    keep_cols=Table.SelectColumns(source,{"workout_type","average_hr"},MissingField.UseNull),

    // filter out blank types and null hr
    filtered=Table.SelectRows(keep_cols,
        each not fx_null_or_blank([workout_type]) and [average_hr]<>null),

    // median per workout_type
    median_tbl=Table.Group(filtered,{"workout_type"},
        {{"median_hr",
            (t as table) as nullable number =>
                let vals=List.RemoveNulls(Table.Column(t,"average_hr"))
                in if List.IsEmpty(vals) then null else List.Median(vals),
            type nullable number}}),

    // round to integer
    final=Table.TransformColumns(median_tbl, {{"median_hr",each if _=null then null else Number.Round(_,0),Int64.Type}})
in
    final