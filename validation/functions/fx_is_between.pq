let
    // checks if a numeric value lies within an inclusive or exclusive range; returns null if any operand is null
    fx_is_between=(val as any, lo as any, hi as any, optional inclusive as nullable logical) as nullable logical =>
    let
        inc=if inclusive=null then true else inclusive,
        n =try Number.From(val) otherwise null,
        l =try Number.From(lo)  otherwise null,
        h =try Number.From(hi)  otherwise null,
        res=
            if n=null or l=null or h=null then null
            else if inc then (n>=l and n<=h)
            else (n>l and n<h)
    in
        res
in
    fx_is_between