let
    fx_to_km=(
        x as nullable any,
        optional default_unit as nullable text,   // "km" (default), supports "m","mi"
        optional mile_factor as nullable number   // default 1.609
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

                // normalize unit words -> km/m/mi
                w0=Text.Replace(Text.Replace(Text.Replace(Text.Replace(Text.Replace(s,"kilometres","km"),"kilometers","km"),"kilometre","km"),"kilometer","km"),"kms","km"),
                w1=Text.Replace(Text.Replace(Text.Replace(Text.Replace(w0,"metres","m"),"meters","m"),"metre","m"),"meter","m"),
                w2=Text.Replace(Text.Replace(w1,"miles","mi"),"mile","mi"),

                // protect "mi" before handling bare "m"
                p0=Text.Replace(w2," mi "," ~mi~ "),
                p1=if Text.EndsWith(p0," mi") then Text.Start(p0,Text.Length(p0)-3)&" ~mi~" else p0,

                // add spacing around units
                u0=Text.Replace(p1,"km"," km "),
                u1=Text.Replace(u0,"~mi~"," mi "),
                u2=Text.Replace(u1," m"," m "),
                u3=if Text.EndsWith(u2,"m") then Text.Start(u2,Text.Length(u2)-1)&" m" else u2,

                // collapse whitespace & tokenize
                tokens=List.Select(Text.Split(Text.Combine(Text.SplitAny(u3," #(tab)#(cr)#(lf)")," "), " "), each _<>""),

                // helpers
                to_num=(z as text) as nullable number => try Number.From(Text.Replace(z,",",".")) otherwise null,
                n=List.Count(tokens),
                idxs=if n=0 then {} else {0..n-1},
                def_unit=if default_unit=null then "km" else Text.Lower(default_unit),
                mi_fac=if mile_factor=null then 1.609 else mile_factor,

                // parse <number> [unit?] -> accumulate km
                sum_km=
                    let
                        vals=List.Transform(idxs,(i)=>
                            let
                                t=tokens{i},
                                v=to_num(t),
                                u=if i+1<n then tokens{i+1} else null,
                                km=
                                    if v=null then null
                                    else if u="km" then v
                                    else if u="m" then v/1000
                                    else if u="mi" then v*mi_fac
                                    else if def_unit="km" then v
                                    else if def_unit="m" then v/1000
                                    else if def_unit="mi" then v*mi_fac
                                    else v
                            in km)
                    in List.Sum(List.RemoveNulls(vals)),

                // fallback for plain number
                plain=try Number.From(Text.Replace(s,",",".")) otherwise null,
                fallback=if plain=null then null else if def_unit="km" then plain else if def_unit="m" then plain/1000 else if def_unit="mi" then plain*mi_fac else plain,

                // choose best
                final=if sum_km<>null and sum_km<>0 then sum_km else fallback
            in final
    in
        result
in
    fx_to_km