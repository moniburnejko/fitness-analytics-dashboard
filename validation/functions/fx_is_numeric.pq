// function: fx_is_numeric
// purpose: verify if a value can be safely parsed as a number
// notes: used in numeric validation rules to detect invalid formats
// author: monika burnejko | 2025

let
    fx_is_numeric=(x as any) as logical =>
    let
        n=try Number.From(x) otherwise null,
        res=n<>null
    in
        res
in
    fx_is_numeric
