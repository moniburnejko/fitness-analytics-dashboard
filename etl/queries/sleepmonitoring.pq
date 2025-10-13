// query: sleepmonitoring
// source: fitness_data_2024_raw.xlsx [sheet: sleepmonitoring]
// purpose: clean and normalize daily sleep records by converting mixed duration formats to numeric hours and sorting by date
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monikaburnejko | 2025

let
    // source & headers
    source = Excel.Workbook(File.Contents("data/raw/fitness_data_2024_raw.xlsx"), null, true),
    nav=source{[Item="SleepMonitoring",Kind="Sheet"]}[Data],
    headers=Table.PromoteHeaders(nav,[PromoteAllScalars=true]),

    // generic cleaning
    clean=fx_clean(headers),

    // date parsing
    date_fixed=Table.TransformColumns(clean,{{"date",each try fx_date(_) otherwise null,type date}}),

    // sleep to hours (rounded to 1 decimal)
    sleep_hours_fixed=Table.TransformColumns(date_fixed,{{"sleep_hours",each try Number.Round(fx_to_hours(_),1) otherwise null}}),

    // final types
    casted=Table.TransformColumnTypes(sleep_hours_fixed,{{"date",type date},{"sleep_hours",type number}},"en-US"),

    // sort & unique per date (keeps first occurrence)
    sorted=Table.Sort(casted,{{"date",Order.Ascending}}),
    deduped=Table.Distinct(sorted,{"date"})
in
    deduped