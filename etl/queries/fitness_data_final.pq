// query: fitness_data_final
// source: fitness_data_base and median_hr
// purpose: create the final analytics-ready dataset with hr imputation, derived metrics (calories_per_minute, steps_goal_pct, sleep_duration_group), and temporal grouping
// notes: final output before validation stage; sample reference: /data/sample/fitness_data_validation_sample.xlsx
// author: monika burnejko | 2025

let
    // calendar: one row per day in 2024
    start_date=#date(2024,1,1),
    end_date=#date(2024,12,31),
    day_count=Duration.Days(end_date-start_date)+1,
    dates=List.Dates(start_date,day_count,#duration(1,0,0,0)),
    calendar=Table.FromList(dates,Splitter.SplitByNothing(),{"date"}),
    calendar_typed=Table.TransformColumnTypes(calendar,{{"date",type date}}),

    // sources
    base=fitness_data_base,
    med=median_hr,

    // join calendar -> base (preserves multiple workouts per day)
    j_base=Table.NestedJoin(calendar_typed,{"date"},base,{"date"},"fitness_base",JoinKind.LeftOuter),
    cols_to_expand=List.RemoveItems(Table.ColumnNames(base),{"date"}),
    e_base=Table.ExpandTableColumn(j_base,"fitness_base",cols_to_expand,cols_to_expand),

    // hr imputation via per-type median (with boolean flag)
    j_med=Table.NestedJoin(e_base,{"workout_type"},med,{"workout_type"},"med",JoinKind.LeftOuter),
    e_med=Table.ExpandTableColumn(j_med,"med",{"median_hr"},{"median_hr"}),

    add_avg_hr=Table.AddColumn(e_med,"average_hr_calc",each if [average_hr]=null then [median_hr] else [average_hr],type nullable number),
    add_avg_hr_flag=Table.AddColumn(add_avg_hr,"average_hr_imputed_flag",each [average_hr]=null and [median_hr]<>null,type logical),
    cleaned_hr=Table.RenameColumns(Table.RemoveColumns(add_avg_hr_flag,{"average_hr","median_hr"}),{{"average_hr_calc","average_hr"}}),

    // calculated columns
    with_cpm=Table.AddColumn(cleaned_hr,"calories_per_minute",
        each let c=[calories_burned], d=[workout_duration_min] in if c=null or d=null or d=0 then null else Number.Round(Number.From(c)/Number.From(d),2),
        type nullable number),

    with_intensity=Table.AddColumn(with_cpm,"workout_intensity",
        each if [average_hr]=null then null else if [average_hr]>=140 then "High" else if [average_hr]>=110 then "Medium" else "Low",type text),

    with_sleep_group=Table.AddColumn(with_intensity,"sleep_duration_group",
        each if [sleep_hours]=null then null else if [sleep_hours]>8 then "Long(>8h)" else if [sleep_hours]<6 then "Short(<6h)" else "Optimal(6-8h)",type text),

    with_steps_pct=Table.AddColumn(with_sleep_group,"steps_goal_pct",
        each if [steps]=null then null else [steps]/10000*100,type nullable number),

    with_steps_flag=Table.AddColumn(with_steps_pct,"steps_goal_achieved_flag",
        each if [steps_goal_pct]=null then null else [steps_goal_pct]>=100,type logical),

    // sleep previous night (O(n) via index + shifted list)
    sorted=Table.Sort(with_steps_flag,{{"date",Order.Ascending}}),
    indexed=Table.AddIndexColumn(sorted,"idx",0,1,Int64.Type),
    sleep_list=Table.Column(indexed,"sleep_hours"),
    prev_list=List.Combine({{null},List.RemoveLastN(sleep_list,1)}),
    with_previous=Table.AddColumn(indexed,"sleep_previous_night",(r)=>prev_list{r[idx]},type nullable number),
    removed_idx=Table.RemoveColumns(with_previous,{"idx"}),

    // temporal grouping
    with_month_name=Table.AddColumn(removed_idx,"month_name",each Date.ToText([date],"MMMM","en-US"),type text),
    with_month_number=Table.AddColumn(with_month_name,"month_number",each Date.Month([date]),Int64.Type),
    with_month_start_date=Table.AddColumn(with_month_number,"month_start_date",each #date(Date.Year([date]),Date.Month([date]),1),type date),
    with_dow_number=Table.AddColumn(with_month_start_date,"day_of_week_number",each Date.DayOfWeek([date],Day.Monday)+1,Int64.Type),
    with_dow_name=Table.AddColumn(with_dow_number,"day_of_week_name",each Date.ToText([date],"ddd","en-US"),type text),
    with_quarter_name=Table.AddColumn(with_dow_name,"quarter_name",each "Q"&Number.ToText(Date.QuarterOfYear([date])),type text),

    // final casting
    casted=Table.TransformColumnTypes(with_quarter_name,
        {
            {"workout_duration_min",Int64.Type},
            {"calories_burned",Int64.Type},
            {"calories_per_minute",type number},
            {"average_hr",Int64.Type},
            {"average_hr_imputed_flag",type logical},
            {"max_hr",Int64.Type},
            {"resting_hr",Int64.Type},
            {"active_minutes",Int64.Type},
            {"distance_km",type number},
            {"steps",Int64.Type},
            {"steps_goal_pct",type number},
            {"steps_goal_achieved_flag",type logical},
            {"sleep_hours",type number},
            {"sleep_previous_night",type number}
        }, "en-US"),

    // column order
    final=Table.ReorderColumns(casted,
        {
            "date","day_of_week_name","day_of_week_number","month_name","month_number","month_start_date","quarter_name",
            "workout_type","workout_intensity","workout_duration_min","calories_burned","calories_per_minute",
            "average_hr","average_hr_imputed_flag","max_hr","resting_hr",
            "active_minutes","distance_km","steps","steps_goal_pct","steps_goal_achieved_flag",
            "sleep_hours","sleep_duration_group","sleep_previous_night"
        },MissingField.Ignore)
in
    final