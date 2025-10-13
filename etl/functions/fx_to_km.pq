// function: fx_to_km
// purpose: standardize distance measures (km, m, mi) into kilometers; automatically converts miles using a fixed factor of 1.609
// notes: used in activity tracking data
// author: monika burnejko | 2025

let
    fx_to_km=(
        x as nullable any,
        optional default_unit as nullable text   // "km" (default), supports "m", "mi"
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

                // protect units to avoid splitting "mi" into "m"+"i"
                p0=Text.Replace(w2,"mi","#MI#"),
                p1=Text.Replace(p0,"km","#KM#"),

                // add spacing around bare 'm'
                m_spaced=Text.Replace(p1,"m"," m "),

                // restore protected units
                r0=Text.Replace(m_spaced,"#KM#"," km "),
                r1=Text.Replace(r0,"#MI#"," mi "),

                // collapse whitespace & tokenize
                tokens=List.Select(Text.Split(Text.Combine(Text.SplitAny(r1," #(tab)#(cr)#(lf)")," "), " "), each _<>""),

                // simple decimal parser
                to_num=(z as text) as nullable number =>
                    let standardized=Text.Replace(Text.Replace(z,",",".")," ","")
                    in try Number.From(standardized) otherwise null,

                n=List.Count(tokens),
                idxs=if n=0 then {} else {0..n-1},
                def_unit=if default_unit=null then "km" else Text.Lower(default_unit),

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
                                    else if u="mi" then v*1.609
                                    else if def_unit="km" then v
                                    else if def_unit="m" then v/1000
                                    else if def_unit="mi" then v*1.609
                                    else v
                            in km)
                    in List.Sum(List.RemoveNulls(vals)),

                // fallback for plain number (no explicit unit)
                plain=try Number.From(Text.Replace(Text.Replace(s,",",".")," ","")) otherwise null,
                fallback=
                    if plain=null then null
                    else if def_unit="km" then plain
                    else if def_unit="m" then plain/1000
                    else if def_unit="mi" then plain*1.609
                    else plain,

                // choose best
                final=if sum_km<>null and sum_km<>0 then sum_km else fallback
            in final
    in
        result
in
    fx_to_km
