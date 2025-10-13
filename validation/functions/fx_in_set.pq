// function: fx_in_set
// purpose: verify if a given text value exists within an allowed set of values
// notes: used for categorical validation (e.g., workout_type domain)
// author: monika burnejko | 2025

let
    fx_in_set=(val as any, allowed as list) as nullable logical =>
    let
        isBlank=fx_null_or_blank(val),
        v=if isBlank then null else Text.From(val),
        res=if v=null then null else List.Contains(List.Transform(allowed, each Text.From(_)), v)
    in
        res
in
    fx_in_set
