// function: fx_list_broken
// purpose: aggregate validation results into a delimited string of rule names that failed for a given record
// notes: used to generate field-level validation output summaries
// author: monika burnejko | 2025

let
    fx_list_broken=(row as record) as list =>
    let
        names=Record.FieldNames(row),
        ruleNames=List.Select(names, each Text.StartsWith(_, "rule_")),
        broken=List.Select(ruleNames, each Record.Field(row, _) = false)
    in
        broken
in
    fx_list_broken
