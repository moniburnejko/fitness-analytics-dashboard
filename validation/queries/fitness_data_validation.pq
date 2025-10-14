// query: fitness_data_validation
// source: fitness_data_final and validation_rules
// purpose: apply all defined validation rules to the fitness dataset, create rule_* columns, and derive error, warning, and completeness flags
// notes: output feeds both validation_summary and Looker Studio visualization layer
// author: monika burnejko | 2025

let
    // source data and validation rules
    source=fitness_data_final,
    rules_tbl=validation_rules,

    // add one rule_* column per rule (null-safe)
    add_rule_columns=
        List.Accumulate(
            Table.ToRecords(rules_tbl),
            source,
            (state as table,r as record)=>
                let
                    rule_name=r[rule_name],
                    col_name=Text.Lower(r[target_column]),
                    rule_kind=Text.Lower(r[rule_type]),
                    p1=r[param1],
                    p2=r[param2],

                    apply=(row as record)=>
                        let
                            val=if Record.HasFields(row,col_name) then try Record.Field(row,col_name) otherwise null else null,
                            res=
                                if rule_kind="not_null" then not fx_null_or_blank(val)
                                else if rule_kind="between_inc" then
                                    let n=try Number.From(val) otherwise null in if n=null then null else fx_is_between(n,p1,p2,true)
                                else if rule_kind="max_inc" then
                                    let n=try Number.From(val) otherwise null in if n=null then null else n<=Number.From(p1)
                                else if rule_kind="in_set" then
                                    if val=null then null else fx_in_set(val,p1)
                                else if rule_kind="rel_compare" then
                                    let
                                        other_col=Text.Trim(Text.From(p1)),
                                        cmp_type=Text.Upper(Text.Trim(Text.From(p2))),
                                        v1=try Number.From(val) otherwise null,
                                        v2=if Record.HasFields(row,other_col) then try Number.From(Record.Field(row,other_col)) otherwise null else null
                                    in
                                        if v1=null or v2=null then null
                                        else if cmp_type="MAX_GE" then v1>=v2 else null
                                else null
                        in
                            try res otherwise null,

                    with_col=Table.AddColumn(state,"rule_"&rule_name,each apply(_),type nullable logical)
                in
                    with_col),

    // collect broken rules (list of rule_* where value=false)
    with_broken=Table.AddColumn(add_rule_columns,"broken_rules",each try fx_list_broken(_) otherwise {},type list),

    // map severity to error/warn flags
    severity_map=Table.ToRecords(Table.SelectColumns(rules_tbl,{"rule_name","severity"})),

    with_error_flag=Table.AddColumn(with_broken,"has_error",
        each
            let br=try [broken_rules] otherwise {},
                safe=if br=null then {} else br
            in
                List.AnyTrue(List.Transform(safe,
                    (b)=>List.AnyTrue(List.Transform(severity_map,(m)=>b="rule_"&m[rule_name] and Text.Upper(m[severity])="ERROR")))), type logical),

    with_warn_flag=Table.AddColumn(with_error_flag,"has_warn",
        each
            let br=try [broken_rules] otherwise {},
                safe=if br=null then {} else br
            in
                List.AnyTrue(List.Transform(safe,
                  (b)=>List.AnyTrue(List.Transform(severity_map,(m)=>b="rule_"&m[rule_name] and Text.Upper(m[severity])="WARN")))), type logical),

    // required rules and their columns
    required_rules=Table.Column(Table.SelectRows(rules_tbl,each Text.Lower([rule_type])<>"optional"),"rule_name"),
    required_rule_cols=List.Transform(required_rules,each "rule_"&_),

    // count required rules with non-null evaluation
    with_required_nonnull_count=Table.AddColumn(with_warn_flag,"required_nonnull_count",
        each
            let row=_,
                evaluated=List.RemoveNulls(List.Transform(required_rule_cols,(f)=>if Record.HasFields(row,f) then Record.Field(row,f) else null))
            in List.Count(evaluated), Int64.Type),

    // list required rules that are missing (null)
    with_missing_required_rules=Table.AddColumn(with_required_nonnull_count,"missing_required_rules",
        each
            let row=_,
                missing=List.Select(required_rule_cols,(f)=>not Record.HasFields(row,f) or Record.Field(row,f)=null)
            in missing, type list),

    with_missing_required_count=Table.AddColumn(with_missing_required_rules,"missing_required_count",each List.Count([missing_required_rules]),Int64.Type),

    // overall validation flag
    with_validation_flag=Table.AddColumn(with_missing_required_count,"data_validation_flag",
        each
            let
                has_date=try not fx_null_or_blank([date]) otherwise false,
                any_data=
                    (try not fx_null_or_blank([workout_type]) otherwise false) or
                    (try not fx_null_or_blank([sleep_hours]) otherwise false) or
                    (try not fx_null_or_blank([average_hr]) otherwise false) or
                    (try not fx_null_or_blank([steps]) otherwise false) or
                    (try not fx_null_or_blank([calories_burned]) otherwise false) or
                    (try not fx_null_or_blank([workout_duration_min]) otherwise false)
            in
                if not has_date or not any_data then "NoData"
                else if [has_error] then "Invalid"
                else if [has_warn] then "Check"
                else "Valid",
        type text),

    // data completeness
    with_completeness=Table.AddColumn(with_validation_flag, "data_completeness",
        each
            let
                has_date=try not fx_null_or_blank([date]) otherwise false,
                domain_fields={"workout_type","sleep_hours","average_hr","steps","calories_burned","workout_duration_min"},
                all_domain_present=List.AllTrue(List.Transform(domain_fields,(f)=>let v=if Record.HasFields(_,f) then Record.Field(_,f) else null in try not fx_null_or_blank(v) otherwise false)),
                    any_required_evaluated=try [required_nonnull_count]>0 otherwise false
            in
                if has_date and all_domain_present and any_required_evaluated then "Complete" else "Incomplete",
        type text)
in
    with_completeness