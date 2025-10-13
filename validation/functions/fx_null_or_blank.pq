// function: fx_null_or_blank
// author: monika burnjko | 2025

let
    // checks if a given value is null, empty string, or whitespace-only text
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
