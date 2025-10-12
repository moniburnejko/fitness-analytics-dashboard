# sample data
this folder contains two representative sample files (25 records each) used to illustrate the data cleaning, transformation, and validation process.

## included files
| file | description |
|------|--------------|
| **`fitness_data_raw_sample.xlsx`** | raw source data split across 4 sheets (`workoutlogs`, `activitytracking`, `sleepmonitoring`, `heartratedata`). each sheet contains examples of messy, inconsistent, and incomplete records collected from different fitness trackers |
| **`fitness_data_validation_sample.xlsx`** | unified and validated dataset after full etl processing. all transformations and data quality checks have been applied. contains a single sheet named `fitness_data_validation` with final standardized columns |

## data quality issues (raw sample)
the `fitness_data_raw_sample.xlsx` file intentionally contains messy and inconsistent records,  
used to demonstrate the data cleaning and validation process during etl

| issue type | example | impact | resolution in etl |
|-------------|----------|---------|-------------------|
| inconsistent date formats | `12/03/24`, `2024-03-12`, excel serial `45377` | parsing errors, wrong chronological order | standardized with `fx_date` |
| missing days in time series | no entry for `2024-02-14`, `2024-02-15` | broken temporal analysis, inaccurate streak or consistency calculations | rebuilt continuous calendar (`list.dates`) to ensure full 2024 coverage |
| mixed numeric formats | `7.5`, `7,5`, `7 500`, `"~420"` | type conversion errors | normalized with `fx_number` |
| mixed duration units | `1:30`, `90m`, `"6.5h"` | wrong time aggregation | converted using `fx_to_minutes` and `fx_to_hours` |
| mixed distance units | `5km`, `3.2 mi`, `400m` | incorrect distance totals | unified via `fx_to_km` |
| missing or mis-typed activity names | `hiit session`, `yoga`, blank rows | duplicates and orphaned metrics | cleaned and standardized via `fx_text` and canonical mapping |
| duplicated entries | two identical `workoutlogs` rows | inflated daily totals | removed using `table.distinct` |
| null or incomplete hr data | `average_hr = null`, `max_hr = 200` | skewed training intensity classification | replaced with per-type median via `median_hr` table |

## key differences between versions
| aspect | raw sample | validation sample |
|---------|-------------|-------------------|
| **structure** | four fragmented tables with inconsistent schema | one consolidated table (`fitness_data_validation`) |
| **formatting** | mixed date/time formats, numeric strings, and text noise | standardized types: `date`, `number`, `text`, and `logical` |
| **duplicates** | includes duplicate or overlapping entries | fully deduplicated and chronologically aligned |
| **missing data** | frequent nulls, blanks, and inconsistent metrics | imputed values and rule-based validation flags |
| **quality checks** | none | includes `data_validation_flag`, `data_completeness`, and rule results (`rule_*` columns) |

## data columns (validation sample)
| column | type | description |
|---------|------|-------------|
| `date` | date | observation date |
| `day_of_week_name` | text | day of week abbreviation (e.g. *mon*, *tue*) |
| `day_of_week_number` | number | numeric order of the day within the week (1 = monday) |
| `month_name` | text | month name (e.g. *january*) |
| `month_number` | number | month number (1-12) |
| `month_start_date` | date | first calendar day of the corresponding month |
| `quarter_name` | text | quarter label (e.g. *q1*, *q2*, *q3*, *q4*) |
| `workout_type` | text | normalized activity type (*running*, *hiit*, *cycling*, etc.) |
| `workout_intensity` | text | derived training intensity (*low*, *medium*, *high*) based on average heart rate |
| `workout_duration_min` | number | duration of the workout in minutes |
| `calories_burned` | number | total calories burned during workout |
| `calories_per_minute` | number | calculated intensity metric - calories burned per minute |
| `average_hr` | number | average heart rate during workout |
| `max_hr` | number | maximum recorded heart rate |
| `resting_hr` | number | resting heart rate value for the day |
| `active_minutes` | number | total minutes of active movement |
| `distance_km` | number | total distance covered (in kilometers) |
| `steps` | number | step count recorded for the day |
| `steps_goal_pct` | number | percentage of 10k-step daily goal reached |
| `steps_goal_achieved_flag` | logical | `true` if daily step goal (≥100%) achieved |
| `sleep_hours` | number | duration of sleep (in hours) |
| `sleep_duration_group` | text | sleep duration category: `short (<6h)`, `optimal (6–8h)`, `long (>8h)` |
| `sleep_previous_night` | number | hours of sleep recorded the previous night |

## validation & quality columns
| column | type | description |
|---------|------|-------------|
| `average_hr_imputed_flag` | logical | indicates whether the average heart rate value was imputed using median by workout type (`true` = replaced, `false` = original). |
| `rule_*` | logical / nullable | one column per validation rule defined in `validation_rules`. returns: `true` if rule passed, `false` if broken, `null` if not applicable (missing data). |
| `broken_rules` | list | contains the names of all broken rules (e.g., `["rule_range_max_hr_110_195", "rule_req_sleep_not_null"]`). |
| `has_error` | logical | `true` if any broken rule is classified as **error** severity. |
| `has_warn` | logical | `true` if any broken rule is classified as **warn** severity. |
| `required_nonnull_count` | number | number of required validation rules that returned a non-null result. |
| `missing_required_rules` | list | names of required rules that returned `null` (missing or incomplete data). |
| `missing_required_count` | number | number of required rules that returned `null` (missing or incomplete data). |
| `data_validation_flag` | text | overall validation outcome:<br>• `valid` – all checks passed<br>• `check` – warnings detected<br>• `invalid` – at least one error<br>• `nodata` – missing all required values. |
| `data_completeness` | text | indicates whether all essential data fields are present:<br>• `complete` – all key fields are populated<br>• `incomplete` – one or more critical values missing. |

## etl & validation overview
- the full etl pipeline is documented in the [`/etl`](../etl) folder  
  - includes: `etl_pipeline.md`, `etl_walkthrough.md`, and function definitions in [`/etl/functions`](../etl/functions)  
- core transformation functions:  
  - `fx_clean` - text and header normalization  
  - `fx_date`, `fx_number`, `fx_to_minutes`, `fx_to_hours`, `fx_to_km` - data type standardization  
  - `fx_text`, `fx_null_or_blank` - text and null handling  
- data validation logic is defined in the [`/validation`](../validation) folder  
  - includes: `validation_rules.md`, `validation_walkthrough.md`, `validation_summary.md`, and helper functions in [`/validation/functions`](../validation/functions)  
- validation rules are applied via `fitness_data_validation`  
- each rule produces `rule_*` columns, combined into aggregated flags:  
  - `has_error`, `has_warn`, and `data_validation_flag`

## data license
all data in this folder is synthetically generated and contains no personal or real-world information.  
it is shared under the mit license for educational and portfolio use.

*for more information about the complete pipeline, see:*  
[`/etl`](../etl) - transformations and data cleaning  
[`/validation`](../validation) - rule-based validation and quality checks  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
