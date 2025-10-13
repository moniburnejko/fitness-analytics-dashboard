// function: fx_list_broken
// author: monika burnejko | 2025

let
    // collects the names of all validation rules that evaluate to false, ignores nulls
    fx_list_broken=(row as record) as list =>
    let
        names=Record.FieldNames(row),
        ruleNames=List.Select(names, each Text.StartsWith(_, "rule_")),
        broken=List.Select(ruleNames, each Record.Field(row, _) = false)
    in
        broken
in
    fx_list_broken
