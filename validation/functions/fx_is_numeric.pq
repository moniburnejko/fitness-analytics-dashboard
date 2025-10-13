// function: fx_is_numeric
// author: monika burnejko | 2025

let
    // validates if a value can be safely interpreted as a number (after cleaning separators); ignores nulls
    fx_is_numeric=(x as any) as logical =>
    let
        n=try Number.From(x) otherwise null,
        res=n<>null
    in
        res
in
    fx_is_numeric
