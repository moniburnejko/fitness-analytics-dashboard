# kpi definitions
this document consolidates all kpi and metric definitions used across the *fitness analytics etl + bi* project.  
it includes both **etl-level (power query)** calculations and **bi-level (looker studio)** aggregations.  
the goal is to ensure transparency, reproducibility, and consistency between data transformation and reporting layers.

## power query kpis
these metrics are calculated during the etl phase (see: [`/etl/queries/fitness_data_final.pq`](../etl/queries/fitness_data_final.pq))  
they serve as base inputs for dashboard-level visualizations.

| metric | definition | purpose |
|---------|-------------|----------|
| `calories_per_minute` | `calories_burned / workout_duration_min` | measures workout efficiency |
| `steps_goal_pct` | `(steps / 10000) * 100` | % of daily step goal achieved |
| `steps_goal_achieved_flag` | `TRUE` if `steps_goal_pct >= 100`, else `FALSE` | goal achievement indicator |
| `sleep_duration_group` | `"Short(<6h)"`, `"Optimal(6–8h)"`, `"Long(>8h)"` | classifies sleep duration |
| `average_hr_imputed_flag` | `TRUE` if `average_hr` replaced by median_hr | data completeness check |
| `workout_intensity` | `"High"` if `average_hr ≥ 140`, `"Medium"` if `≥110`, else `"Low"` | workout load category |
| `sleep_previous_night` | `sleep_hours` from previous date | used for correlation analysis |
| `data_validation_flag` | `"Valid"`, `"Check"`, `"Invalid"`, `"NoData"` | result of validation layer |
| `data_completeness` | `"Complete"` or `"Incomplete"` | overall record completeness flag |

## looker studio kpis
these metrics are calculated dynamically in the dashboard layer  
(see: [`/bi/looker-studio/calculated_fields.md`](../bi/looker-studio/calculated_fields.md)).

| kpi name | formula / definition | page | description |
|-----------|----------------------|--------|--------------|
| **total workouts** | `COUNT(workout_type)` (filtered by Complete data) | performance panel | total number of recorded workouts |
| **workout consistency (%)** | `100 * COUNT_DISTINCT(IF(LENGTH(TRIM(workout_type)) > 0, date)) / COUNT_DISTINCT(date)` | performance panel | % of active days containing workouts |
| **most active day** | `MAX(active_minutes)` grouped by day of week | performance panel | weekday with highest activity level |
| **average sleep hours** | `AVG(sleep_hours)` | performance panel | mean sleep duration over selected period |
| **average daily steps** | `AVG(steps)` | performance panel | average step count per day |
| **record burn (kcal)** | `MAX(calories_burned)` | workout analytics | highest calorie burn in a single session |
| **average session length (min)** | `AVG(workout_duration_min)` | workout analytics | average workout time per session |
| **average calories per minute** | `AVG(calories_per_minute)` | workout analytics | average efficiency rate |
| **average resting hr** | `AVG(resting_hr)` | health & recovery | baseline heart rate level |
| **sleep quality (%)** | `% of "Optimal(6–8h)" days` | health & recovery | sleep consistency measure |
| **move quality (%)** | `AVG(steps_goal_pct)` | health & recovery | average goal achievement across period |

## data validation kpis
these indicators summarize dataset integrity and quality  
(see: [`/validation/queries/validation_summary.pq`](../validation/queries/validation_summary.pq)).

| metric | definition | description |
|---------|-------------|--------------|
| `has_error` | any rule marked `ERROR` returns `TRUE` | data record contains invalid value |
| `has_warn` | any rule marked `WARN` returns `TRUE` | data record needs manual review |
| `data_validation_flag` | classification: `Valid`, `Check`, `Invalid`, `NoData` | overall record status |
| `data_completeness` | classification: `Complete` or `Incomplete` | high-level data readiness measure |

## usage notes
- all kpis are evaluated after applying the **“Valid Data” filter** in looker studio.  
- only *complete* records (as per `data_completeness`) are used in aggregations that rely on core metrics.  
- metric naming conventions differ between layers:  
  - **etl layer:** `snake_case`  
  - **bi layer:** `title case` with units (e.g., `Average Resting HR (bpm)`).  
- consistent validation ensures comparability between time periods and pages.

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
