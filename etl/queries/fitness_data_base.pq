// query: fitness_data_base
// source: merged dataset from workoutlogs, activitytracking, sleepmonitoring, and heartratedata
// purpose: combine all daily data sources by date using nested joins and retain only relevant workout rows when applicable
// notes: sample input available in /data/sample/fitness_data_raw_sample.xlsx
// author: monika burnejko | 2025

let
    // sources
    workout=WorkoutLogs,
    activity=ActivityTracking,
    hr=HeartRateData,
    sleep=SleepMonitoring,

    // join activity by date (expand only needed cols)
    j_act=Table.NestedJoin(workout,{"date"},activity,{"date"},"act",JoinKind.LeftOuter),
    e_act=Table.ExpandTableColumn(j_act,"act",{"steps","distance_km","active_minutes"},{"steps","distance_km","active_minutes"}),

    // join heart rate by date
    j_hr=Table.NestedJoin(e_act,{"date"},hr,{"date"},"hr",JoinKind.LeftOuter),
    e_hr=Table.ExpandTableColumn(j_hr,"hr",{"average_hr","max_hr","resting_hr"},{"average_hr","max_hr","resting_hr"}),

    // join sleep by date
    j_sleep=Table.NestedJoin(e_hr,{"date"},sleep,{"date"},"slp",JoinKind.LeftOuter),
    e_sleep=Table.ExpandTableColumn(j_sleep,"slp",{"sleep_hours"},{"sleep_hours"}),

    // dates that have any nonblank workout_type
    dates_with_workout_tbl=Table.Distinct(
        Table.SelectColumns(
            Table.SelectRows(e_sleep,each not fx_null_or_blank([workout_type])),
            {"date"})),
    dates_with_workout=List.Distinct(Table.Column(dates_with_workout_tbl,"date")),

    // flag + filter
    with_has_workout=Table.AddColumn(e_sleep,"has_workout",each List.Contains(dates_with_workout,[date]),type logical),
    filtered=Table.SelectRows(with_has_workout,each if [has_workout] then not fx_null_or_blank([workout_type]) else true),

    // final types
    typed=Table.TransformColumnTypes(filtered, {
        {"date",type date},
        {"workout_duration_min",Int64.Type},
        {"calories_burned",Int64.Type},
        {"steps",Int64.Type},
        {"distance_km",type number},
        {"active_minutes",Int64.Type},
        {"average_hr",Int64.Type},
        {"max_hr",Int64.Type},
        {"resting_hr",Int64.Type},
        {"sleep_hours",type number}
        }, "en-US"),

    // cleanup
    final=Table.RemoveColumns(typed, {"has_workout"})
in
    final