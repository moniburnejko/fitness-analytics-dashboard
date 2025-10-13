// query: workoutlogs
// source: fitness_data_2024_raw.xlsx [sheet: workoutlogs]
// purpose: clean and normalize per-workout records (date, type, duration, calories) and remove duplicates
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monika burnejko | 2025

let
    // source & headers
    source = Excel.Workbook(File.Contents("data/raw/fitness_data_2024_raw.xlsx"), null, true),
    nav=source{[Item="WorkoutLogs",Kind="Sheet"]}[Data],
    headers=Table.PromoteHeaders(nav,[PromoteAllScalars=true]),

    // generic cleaning: trims text cells + snake_case headers
    clean=fx_clean(headers),

    // date parsing
    date_fixed=Table.TransformColumns(clean,{{"date",each try fx_date(_) otherwise null,type date}}),

    // workout type normalization
    normalize_type=(t as nullable text) as nullable text =>
        let
            base=if t=null then null else fx_text(t,"lower"),
            stripped=if base=null then null else Text.Replace(base," session",""),
            simple=if stripped=null then null else Text.Combine(List.Select(Text.SplitAny(stripped," "),each _<>"")," "),
            mapped_rec=[
                walking="Walking",walk="Walking",
                running="Running",run="Running",
                cycling="Cycling",bike="Cycling",
                swimming="Swimming",swim="Swimming",
                yoga="Yoga",
                hiit="HIIT",
                strength="Strength",gym="Strength",#"strength training"="Strength",
                tennis="Tennis"
            ],
            mapped=if simple=null then null else Record.FieldOrDefault(mapped_rec,simple,null),
            fallback=if mapped<>null then mapped else if simple<>null then Text.Proper(simple) else null,
            final=if Text.Lower(fallback??"")="hiit" then "HIIT" else fallback
        in final,

    type_fixed=Table.TransformColumns(date_fixed,{{"workout_type",each try normalize_type(_) otherwise null,type text}}),

    // duration → minutes
    duration_fixed=Table.TransformColumns(type_fixed,{{"workout_duration_min",each try fx_to_minutes(_) otherwise null,type number}}),

    // calories → number
    calories_fixed=Table.TransformColumns(duration_fixed,{{"calories_burned",each try fx_number(_) otherwise null,type number}}),

    // nullify duration & calories when workout_type is blank
    with_adj_cols= Table.AddColumn(Table.AddColumn(calories_fixed,
        "workout_duration_min_adj",
            each if fx_null_or_blank([workout_type]) then null else [workout_duration_min],
            type nullable number),
        "calories_burned_adj",
            each if fx_null_or_blank([workout_type]) then null else [calories_burned],
            type nullable number),

    removed_old=Table.RemoveColumns(with_adj_cols,{"workout_duration_min","calories_burned"}),
    renamed_adj=Table.RenameColumns(removed_old,{{"workout_duration_min_adj","workout_duration_min"},{"calories_burned_adj","calories_burned"}}),

    // final types + full-row dedup
    casted=Table.TransformColumnTypes(renamed_adj,{{"workout_duration_min",Int64.Type},{"calories_burned",Int64.Type}},"en-US"),
    deduped=Table.Distinct(casted)
in
    deduped