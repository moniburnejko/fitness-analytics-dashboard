let
    // returns true if the text value exists within a predefined list of allowed values; returns null when val is null
    fx_in_set=(val as any, allowed as list) as nullable logical =>
    let
        isBlank=fx_null_or_blank(val),
        v=if isBlank then null else Text.From(val),
        res=if v=null then null else List.Contains(List.Transform(allowed, each Text.From(_)), v)
    in
        res
in
    fx_in_set