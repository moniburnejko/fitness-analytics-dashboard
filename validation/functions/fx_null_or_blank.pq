// function: fx_null_or_blank
// purpose: check whether a value is null or an empty string
// notes: used in completeness validation rules
// author: monika burnjko | 2025

let
    fx_null_or_blank=(x as any) as logical =>
    let
        res=
            if x=null then true
            else if Value.Is(x,type text) then Text.Trim(Text.From(x))=""
            else false
    in
        res
in
    fx_null_or_blank
