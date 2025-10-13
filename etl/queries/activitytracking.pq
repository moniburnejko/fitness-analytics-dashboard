// query: activitytracking
// source: fitness_data_2024_raw.xlsx [sheet: activitytracking]
// purpose: standardize daily activity data (steps, distance_km, active_minutes), normalize numeric formats, and deduplicate by date
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monika burnejko | 2025

let
    // source & headers
    source = Excel.Workbook(File.Contents("data/raw/fitness_data_2024_raw.xlsx"), null, true),
    nav=source{[Item="ActivityTracking",Kind="Sheet"]}[Data],
    headers=Table.PromoteHeaders(nav,[PromoteAllScalars=true]),

    // generic cleaning
    clean=fx_clean(headers),

    // date parsing
    date_fixed=Table.TransformColumns(clean,{{"date",each try fx_date(_) otherwise null,type date}}),

    // steps: integers, supports "7.8K","12 345","12,345", nbsp etc. (allow_k=true)
    steps_fixed=Table.TransformColumns(date_fixed,{{"steps",each try Number.RoundDown(fx_number(_,true,false)) otherwise null}}),

    // distance: to km, rounded to 2 decimals
    distance_km_fixed=Table.TransformColumns(steps_fixed,{{"distance_km",each try Number.Round(fx_to_km(_,"km"),2) otherwise null}}),

    // active minutes: normalize to integer minutes
    active_min_fixed=Table.TransformColumns(distance_km_fixed,{{"active_minutes",each try Number.RoundDown(fx_to_minutes(_)) otherwise null}}),

    // one place for final types
    casted=Table.TransformColumnTypes(
        active_min_fixed,
        {{"date",type date},{"steps",Int64.Type},{"distance_km",type number},{"active_minutes",Int64.Type}},
        "en-US"),

    // sort & unique per date (keeps first occurrence)
    sorted=Table.Sort(casted,{{"date",Order.Ascending}}),
    deduped=Table.Distinct(sorted,{"date"})
in
    deduped