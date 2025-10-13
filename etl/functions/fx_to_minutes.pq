let
    fx_to_minutes=(
        x as nullable any,
        optional default_unit as nullable text // default "min", supports "h"
    ) as nullable number =>
    let
        // quick exit
        result=
            if x=null then null else
            let
                // normalize text
                raw=Text.From(x),
                t0=Text.Trim(Text.Clean(raw)),
                nbsp=Character.FromNumber(160),
                t1=Text.Replace(t0,Text.From(nbsp)," "),
                s=Text.Lower(t1),

                // hh:mm[:ss] -> minutes
                parse_hms=(u as text) as nullable number =>
                    if not Text.Contains(u,":") then null else
                    let
                        parts=Text.Split(u,":"),
                        n=List.Count(parts),
                        to_num=(z as text) as nullable number => try Number.From(Text.Replace(z,",",".")) otherwise null,
                        nums=List.Transform(parts,each to_num(_)),
                        valid=List.AllTrue(List.Transform(nums,each _<>null)),
                        minutes=if not valid then null else if n=2 then nums{0}*60+nums{1} else if n=3 then nums{0}*60+nums{1}+(nums{2}/60) else null
                    in minutes,
                from_hms=parse_hms(s),

                // normalize to only 'h' and 'min'
                u0=Text.Replace(s," m"," min "),
                u1=if Text.EndsWith(u0,"m") then Text.Start(u0,Text.Length(u0)-1)&" min" else u0,
                u2=Text.Replace(u1,"h"," h "),
                u3=Text.Replace(u2,"min"," min "),
                tokens=List.Select(Text.Split(Text.Combine(Text.SplitAny(u3," #(tab)#(cr)#(lf)")," "), " "), each _<>""),

                // parse number+unit pairs
                to_num=(z as text) as nullable number => try Number.From(Text.Replace(z,",",".")) otherwise null,
                cnt=List.Count(tokens),
                sum_pairs=
                    let
                        idxs={0..cnt-1},
                        vals=List.Transform(idxs,(i)=>
                            let
                                t=tokens{i},
                                n=to_num(t),
                                u=if i+1<cnt then tokens{i+1} else null,
                                v=if n=null then null else if u="h" then n*60 else if u="min" then n else n
                            in v)
                    in List.Sum(List.RemoveNulls(vals)),

                // fallback raw number with default unit
                def_unit=if default_unit=null then "min" else Text.Lower(default_unit),
                plain=try Number.From(Text.Replace(s,",",".")) otherwise null,
                fallback=if plain=null then null else if def_unit="h" then plain*60 else plain,

                // choose
                final=if from_hms<>null then from_hms else if sum_pairs<>null and sum_pairs<>0 then sum_pairs else fallback
            in final
    in
        result
in
    fx_to_minutes