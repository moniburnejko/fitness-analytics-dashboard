# 📘 Data Dictionary - `fitness_data_validation`

| Column Name | Data Type | Description | Example Values | Derived From |
|--------------|------------|--------------|----------------|---------------|
| **date** | Date | ISO format date (YYYY-MM-DD) | `2024-03-12` | All tables (joined) + `calendar scaffold` (`List.Dates`) |
| **day_of_week_name** | Text | Abbreviated English name of the weekday | `Mon`, `Tue`, `Wed` | Derived from `date` |
| **day_of_week_number** | Integer | ISO weekday number (1 = Monday) | `1`, `7` | Derived from `date` |
| **month_name** | Text | English month name | `March`, `July` | Derived from `date` |
| **month_number** | Integer | Month number (1–12) | `3`, `7` | Derived from `date` |
| **month_start_date** | Date | First date of the corresponding month | `2024-03-01` | Derived from `date` |
| **quarter_name** | Text | Quarter label of the year | `Q1`, `Q2` | Derived from `date` |
| **workout_type** | Text | Name of the performed workout | `Running`, `HIIT`, `Yoga` | `WorkoutLogs → fx_text + canonical mapping` |
| **workout_intensity** | Text | Categorization of workout effort based on `average_hr` | `Low`, `Medium`, `High` | Derived from `average_hr` |
| **workout_duration_min** | Integer | Duration of the workout in minutes | `45`, `90`, `null` | `WorkoutLogs → fx_to_minutes` |
| **calories_burned** | Integer | Total calories burned during workout | `420`, `750` | `WorkoutLogs → fx_number` |
| **calories_per_minute** | Decimal | Calories burned per minute | `9.33`, `5.25` | Derived: `calories_burned / workout_duration_min` |
| **average_hr** | Integer | Average heart rate during the workout | `135`, `null` | `HeartRateData → fx_number` and `median_hr` (via join and imputation logic) |
| **max_hr** | Integer | Maximum heart rate recorded | `185` | `HeartRateData → fx_number` |
| **resting_hr** | Integer | Average resting heart rate for the day | `58`, `62` | `HeartRateData → fx_number` |
| **active_minutes** | Integer | Total number of active minutes recorded | `74`, `null` | `ActivityTracking → fx_to_minutes` |
| **distance_km** | Decimal | Total distance covered (in kilometers) | `5.24`, `12.0`, `null` | `ActivityTracking → fx_to_km` |
| **steps** | Integer | Total daily step count | `10567`, `7200`, `null` | `ActivityTracking → clean_steps` |
| **steps_goal_pct** | Decimal | Step goal completion in percentage (goal = 10,000) | `87.5`, `105.3` | Derived from `steps` |
| **steps_goal_achieved_flag** | Boolean | Indicates if the daily step goal (10k) was reached | `TRUE`, `FALSE` | Derived from `steps_goal_pct >= 100` |
| **sleep_hours** | Decimal | Total sleep duration in hours | `6.8`, `7.5`, `null` | `SleepMonitoring → fx_to_hours` |
| **sleep_duration_group** | Text | Sleep classification by duration | `Short(<6h)`, `Optimal(6–8h)`, `Long(>8h)` | Derived from `sleep_hours` |
| **sleep_previous_night** | Decimal | Hours of sleep recorded on the previous day | `7.2`, `null` | Calculated in PowerQuery using a `self-join` shifted by one day (`previous-day lookup`) |
| **average_hr_imputed_flag** | Boolean | Marks records where missing `average_hr` was replaced with the median per workout type | `TRUE`, `FALSE` | Derived from `median_hr` join |
| **rule_*** | Boolean/Nullable | Individual validation rule results (`TRUE`=passed, `FALSE`=failed, `null`=not applicable) | `rule_range_avg_hr_70_150 = TRUE` | `validation_rules` table |
| **has_error** | Boolean | `TRUE` if any validation rule with severity `ERROR` failed | `TRUE`, `FALSE` | Aggregated from rule columns |
| **has_warn** | Boolean | `TRUE` if any validation rule with severity `WARN` failed | `TRUE`, `FALSE` | Aggregated from rule columns |
| **required_nonnull_count** | Integer | Number of required validation rules returning non-null results | `6`, `9` | Derived from rule evaluation logic |
| **missing_required_count** | Integer | Number of required rules that returned `NULL` (missing data) | `0`, `2` | Derived from rule evaluation logic |
| **data_validation_flag** | Text | Global data validation outcome | `Valid`, `Check`, `Invalid`, `NoData` | Based on rule aggregation results |
| **data_completeness** | Text | Indicates whether all key columns contain valid data | `Complete`, `Incomplete` | Based on presence of core metrics (date, workout, sleep, HR, steps) |

📅 *Last updated: October 2025*  
👩‍💻 *Author: Monika Burnejko*
