# data dictionary

| column name | data type | description | example values | derived from |
|--------------|------------|--------------|----------------|---------------|
| **date** | date | iso format date (yyyy-mm-dd) | `2024-03-12` | all tables (joined) + `calendar scaffold` (`list.dates`) |
| **day_of_week_name** | text | abbreviated english name of the weekday | `mon`, `tue`, `wed` | derived from `date` |
| **day_of_week_number** | integer | iso weekday number (1 = monday) | `1`, `7` | derived from `date` |
| **month_name** | text | english month name | `march`, `july` | derived from `date` |
| **month_number** | integer | month number (1–12) | `3`, `7` | derived from `date` |
| **month_start_date** | date | first date of the corresponding month | `2024-03-01` | derived from `date` |
| **quarter_name** | text | quarter label of the year | `q1`, `q2` | derived from `date` |
| **workout_type** | text | name of the performed workout | `running`, `hiit`, `yoga` | `workoutlogs → fx_text + canonical mapping` |
| **workout_intensity** | text | categorization of workout effort based on `average_hr` | `low`, `medium`, `high` | derived from `average_hr` |
| **workout_duration_min** | integer | duration of the workout in minutes | `45`, `90`, `null` | `workoutlogs → fx_to_minutes` |
| **calories_burned** | integer | total calories burned during workout | `420`, `750` | `workoutlogs → fx_number` |
| **calories_per_minute** | decimal | calories burned per minute | `9.33`, `5.25` | derived: `calories_burned / workout_duration_min` |
| **average_hr** | integer | average heart rate during the workout | `135`, `null` | `heartratedata → fx_number` and `median_hr` (via join and imputation logic) |
| **max_hr** | integer | maximum heart rate recorded | `185` | `heartratedata → fx_number` |
| **resting_hr** | integer | average resting heart rate for the day | `58`, `62` | `heartratedata → fx_number` |
| **active_minutes** | integer | total number of active minutes recorded | `74`, `null` | `activitytracking → fx_to_minutes` |
| **distance_km** | decimal | total distance covered (in kilometers) | `5.24`, `12.0`, `null` | `activitytracking → fx_to_km` |
| **steps** | integer | total daily step count | `10567`, `7200`, `null` | `activitytracking → clean_steps` |
| **steps_goal_pct** | decimal | step goal completion in percentage (goal = 10,000) | `87.5`, `105.3` | derived from `steps` |
| **steps_goal_achieved_flag** | boolean | indicates if the daily step goal (10k) was reached | `true`, `false` | derived from `steps_goal_pct >= 100` |
| **sleep_hours** | decimal | total sleep duration in hours | `6.8`, `7.5`, `null` | `sleepmonitoring → fx_to_hours` |
| **sleep_duration_group** | text | sleep classification by duration | `short(<6h)`, `optimal(6–8h)`, `long(>8h)` | derived from `sleep_hours` |
| **sleep_previous_night** | decimal | hours of sleep recorded on the previous day | `7.2`, `null` | calculated in power query using a self-join shifted by one day (`previous-day lookup`) |
| **average_hr_imputed_flag** | boolean | marks records where missing `average_hr` was replaced with the median per workout type | `true`, `false` | derived from `median_hr` join |
| **rule_*** | boolean/nullable | individual validation rule results (`true`=passed, `false`=failed, `null`=not applicable) | `rule_range_avg_hr_70_150 = true` | `validation_rules` table |
| **has_error** | boolean | `true` if any validation rule with severity `error` failed | `true`, `false` | aggregated from rule columns |
| **has_warn** | boolean | `true` if any validation rule with severity `warn` failed | `true`, `false` | aggregated from rule columns |
| **required_nonnull_count** | integer | number of required validation rules returning non-null results | `6`, `9` | derived from rule evaluation logic |
| **missing_required_count** | integer | number of required rules that returned `null` (missing data) | `0`, `2` | derived from rule evaluation logic |
| **data_validation_flag** | text | global data validation outcome | `valid`, `check`, `invalid`, `nodata` | based on rule aggregation results |
| **data_completeness** | text | indicates whether all key columns contain valid data | `complete`, `incomplete` | based on presence of core metrics (date, workout, sleep, hr, steps) |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
