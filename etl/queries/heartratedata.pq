// query: heartratedata
// source: fitness_data_2024_raw.xlsx [sheet: heartratedata]
// purpose: clean and aggregate heart rate metrics per date (average_hr, max_hr, resting_hr) using mean and max operations
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monikaburnejko | 2025

let
    // source & headers
    source = Excel.Workbook(File.Contents("data/raw/fitness_data_2024_raw.xlsx"), null, true),
    nav=source{[Item="HeartRateData",Kind="Sheet"]}[Data],
    headers=Table.PromoteHeaders(nav,[PromoteAllScalars=true]),

    // generic cleaning
    clean=fx_clean(headers),

    // date parsing
    date_fixed=Table.TransformColumns(clean,{{"date",each try fx_date(_) otherwise null,type date}}),

    // hr columns -> numbers
    hr_cols={"average_hr","max_hr","resting_hr"},
    hr_fixed=Table.TransformColumns(date_fixed, List.Transform(hr_cols,(c)=>{c,each try fx_number(_) otherwise null,type number})),

    // helpers for aggregation
    avg_round_nonnull=(tbl as table, col as text) as nullable number =>
        let vals=List.RemoveNulls(Table.Column(tbl,col))
        in if List.IsEmpty(vals) then null else Number.Round(List.Average(vals),0),

    max_nonnull=(tbl as table, col as text) as nullable number =>
        let vals=List.RemoveNulls(Table.Column(tbl,col))
        in if List.IsEmpty(vals) then null else List.Max(vals),

    // aggregate duplicates by date
    agg_by_date=Table.Group(hr_fixed,{"date"}, {
        {"average_hr",(t as table)=>avg_round_nonnull(t,"average_hr"),Int64.Type},
        {"max_hr",(t as table)=>max_nonnull(t,"max_hr"),Int64.Type},
        {"resting_hr",(t as table)=>avg_round_nonnull(t,"resting_hr"),Int64.Type}}),

    // final sort
    sorted=Table.Sort(agg_by_date,{{"date",Order.Ascending}})
in
    sorted