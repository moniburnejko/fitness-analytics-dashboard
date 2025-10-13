# etl walkthrough
this document provides a step-by-step transformation guide for the etl pipeline. it follows the flow from raw excel sheets through cleaning, normalization, merging, imputation, and feature enrichment to the final dataset used by bi. validation is covered separately (see `/validation/validation_walkthrough.md`).

## input sources
- single excel file: `fitness_data_2024_raw.xlsx`  
  worksheets: `workoutlogs`, `activitytracking`, `sleepmonitoring`, `heartratedata`  
  sample raw extract: `/data/sample/fitness_data_raw_sample.xlsx`

## common cleaning and standardization
- **headers & cells:** `fx_clean` trims text cells, removes empty rows, and converts headers to lowercase snake_case (e.g., `Workout Duration (min)` → `workout_duration_min`).
- **dates:** `fx_date` handles typed values, excel serials, iso-like formats; culture-priority default `{"en-GB","en-US","pl-PL"}`.
- **numbers:** `fx_number` normalizes whitespace, accepts `.`/`,` as decimal, supports `k` and `%` (opt-in), cleans fuzzy tokens (like `~`, `≈`).
- **text:** `fx_text` collapses whitespace and standardizes punctuation; casing control via parameter.
- **units/time:** `fx_to_minutes`, `fx_to_hours`, `fx_to_km` convert mixed textual inputs to canonical numeric values.

## transformations by query
detailed explanations of each transformation step below correspond directly to the m queries stored in  
[`/etl/queries`](./queries) - each file includes a header comment with its purpose and source mapping.

### 1) workoutlogs
**goal:** produce clean per-workout records with normalized types.  
**key steps:**
1. source + headers → `fx_clean`
2. `date` → `fx_date`
3. `workout_type` → `fx_text("lower")`, remove `" session"`, collapse spaces, map to canonical labels (e.g., `walk`→`Walking`, `hiit`→`HIIT`)
4. `workout_duration_min` → `fx_to_minutes`
5. `calories_burned` → `fx_number`
6. if `workout_type` is blank → nullify duration & calories (avoid fake entries)
7. cast numeric columns (`Int64` where appropriate), `Table.Distinct` for full-row duplicates
**outputs:** one row per workout with consistent types and labels.

### 2) activitytracking
**goal:** normalize daily activity.  
**key steps:**
1. clean + `fx_date`  
2. `steps` → `fx_number(_, true, false)` (k-suffix enabled; integers via `RoundDown`)  
3. `distance_km` → `fx_to_km(_, "km")`, round(2)  
4. `active_minutes` → `fx_to_minutes` → `RoundDown`  
5. cast types; sort + `Table.Distinct` by `date`  
**outputs:** one row per date with daily steps, distance_km, active_minutes.

### 3) sleepmonitoring
**goal:** normalize daily sleep.  
**key steps:**
1. clean + `fx_date`  
2. `sleep_hours` → `fx_to_hours`, round(1)  
3. cast types; sort + `Table.Distinct` by `date`
**outputs:** one row per date with `sleep_hours`.

### 4) heartratedata
**goal:** consolidate daily heart rate metrics.  
**key steps:**
1. clean + `fx_date`  
2. parse `average_hr`, `max_hr`, `resting_hr` via `fx_number`  
3. `Table.Group` by `date`:  
   - `average_hr`: rounded average of non-null values  
   - `max_hr`: maximum of non-null values  
   - `resting_hr`: rounded average of non-null values  
4. sort by date
**outputs:** one row per date with consolidated hr metrics.

### 5) fitness_data_base
**goal:** merge daily measures with workouts while avoiding duplicate empty rows on workout days.  
**key steps:**
1. `NestedJoin` by `date` to attach activity, hr, sleep to workouts (expand only needed cols; do not expand right-side `date`)  
2. find dates that have any nonblank `workout_type` → create list `dates_with_workout`  
3. add `has_workout` flag (`List.Contains(dates_with_workout, [date])`)  
4. filter:  
   - if `has_workout = true` → keep only rows with nonblank `workout_type`  
   - else → keep all rows  
5. cast final types
**outputs:** daily-level table preserving workouts where they exist and full daily rows where they do not.

### 6) median_hr
**goal:** compute per-type median for hr imputation.  
**key steps:**
1. select `workout_type`, `average_hr`  
2. filter out blanks and nulls  
3. group by `workout_type`, compute `List.Median(average_hr)`  
4. round to integer (`Int64`)
**outputs:** lookup table `{workout_type → median_hr}`.

### 7) fitness_data_final
**goal:** final enriched dataset.
<br>**key steps:**
1. generate 2024 calendar and left join to `fitness_data_base` (preserves multi-workout days)  
2. left join `median_hr` by `workout_type`; impute `average_hr` → `median_hr`  
3. add `average_hr_imputed_flag` (`true` if imputed from median)  
4. drop temp cols, rename `median_hr` → `average_hr`  
5. derived metrics:  
   - `calories_per_minute` = calories_burned / workout_duration_min (null-safe, round 2)  
   - `workout_intensity` from `average_hr`: thresholds 140 (high), 110 (medium), else low  
   - `sleep_duration_group`: `<6h`, `6–8h`, `>8h`  
   - `steps_goal_pct` = steps / 10,000 × 100; `steps_goal_achieved_flag` (≥ 100%)  
   - `sleep_previous_night`: index + shifted list  
6. temporal attributes: month name/number/start, day-of-week name/number (monday=1), quarter  
7. final casting with `"en-US"` culture and column order
**outputs:** single, analytics-ready fact table

## final dataset structure (selected columns)
- keys & calendar: `date`, `day_of_week_name`, `day_of_week_number`, `month_name`, `month_number`, `month_start_date`, `quarter_name`  
- workouts: `workout_type`, `workout_duration_min`, `calories_burned`, `calories_per_minute`, `workout_intensity`  
- heart rate: `average_hr`, `average_hr_imputed_flag`, `max_hr`, `resting_hr`  
- activity: `active_minutes`, `distance_km`, `steps`, `steps_goal_pct`, `steps_goal_achieved_flag`  
- sleep: `sleep_hours`, `sleep_duration_group`, `sleep_previous_night`

## validation
after `fitness_data_final`, validation rules are applied to produce detailed results and a summary. samples are illustrated in `/data/sample/fitness_data_validation_sample.xlsx`. details live in `/validation/`:
- functions: `fx_null_or_blank`, `fx_is_numeric`, `fx_is_between`, `fx_in_set`, `fx_list_broken`
- `validation_rules` (configurable rules per field)
- `fitness_data_validation` (row-level rule outcomes)
- `validation_summary` (aggregated results)
<br>see: [`validation_walkthrough.md`](validation_walkthrough.md).


📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
