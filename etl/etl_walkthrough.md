# etl walkthrough
this document provides a detailed, step-by-step explanation of the power query etl (extract-transform-load) process used in the **fitness analytics etl + bi** project.  
it covers each transformation query, its logic, and how the final dataset `fitness_data_final` is constructed before validation and bi reporting.

## overview
the etl process transforms raw, fragmented fitness tracking data into a structured and analytics-ready dataset.  
it begins with four source sheets from one file — [`fitness_data_2024_raw.xlsx`](../data/sample/fitness_data_raw_sample.xlsx) - and ends with a clean, validated table that integrates workouts, activity, sleep, and heart rate metrics.

the final output, `fitness_data_final`, is then passed to the validation stage (`/validation`), where data quality checks are performed before visualization in looker studio.

## transformations by query
> for full m-code scripts, see [`/etl/queries`](./queries))

### 1. workoutlogs
- **source:** `workoutlogs` sheet from `fitness_data_2024_raw.xlsx`  
- **purpose:** cleans and standardizes all workout data.  
- **key operations:**
  - cleans headers and trims text using `fx_clean`
  - parses `date` using `fx_date`  
  - normalizes `workout_type` via custom text mapping (e.g., `hiit`, `cycling`, `running`)  
  - converts `workout_duration_min` to minutes via `fx_to_minutes`  
  - standardizes `calories_burned` with `fx_number`  
  - replaces nulls when no valid `workout_type` is available  
  - casts final numeric columns and removes duplicates
- **output:** cleaned, standardized workout data ready for merging.

### 2. activitytracking
- **source:** `activitytracking` sheet  
- **purpose:** prepares step, distance, and active time metrics.  
- **key operations:**
  - cleans headers and text via `fx_clean`  
  - parses `date` with `fx_date`  
  - standardizes `steps` using `fx_number` with `allow_k = true` (supports e.g., `7.8K`)  
  - converts `distance_km` with `fx_to_km` (handles `m`, `km`, `mi`)  
  - transforms `active_minutes` using `fx_to_minutes`  
  - sorts and deduplicates by date  
- **output:** daily step and activity metrics standardized to consistent units.

### 3. sleepmonitoring
- **source:** `sleepmonitoring` sheet  
- **purpose:** cleans and standardizes sleep duration records.  
- **key operations:**
  - cleans headers and trims text via `fx_clean`  
  - parses `date` with `fx_date`  
  - converts `sleep_hours` to hours via `fx_to_hours` (handles `1:30`, `90m`, etc.)  
  - sorts and deduplicates by date
- **output:** clean, daily sleep data in consistent hourly format.

### 4. heartratedata
- **source:** `heartratedata` sheet  
- **purpose:** prepares heart rate statistics and aggregates duplicates.  
- **key operations:**
  - cleans headers via `fx_clean`  
  - parses `date` with `fx_date`  
  - converts `average_hr`, `max_hr`, and `resting_hr` via `fx_number`  
  - groups by `date` and aggregates:  
    - `average_hr` → rounded mean  
    - `max_hr` → maximum  
    - `resting_hr` → rounded mean  
  - sorts chronologically  
- **output:** daily heart rate statistics, one record per date.

### 5. fitness_data_base
- **purpose:** merges all cleaned datasets into one unified base table.  
- **key operations:**
  - joins `workoutlogs`, `activitytracking`, `heartratedata`, and `sleepmonitoring` by `date` using nested joins  
  - keeps all workouts (one-to-many) while merging daily data  
  - ensures that only rows with real workout data are retained for days containing any workout  
  - enforces consistent data types for all key columns  
  - removes intermediate flags  
- **output:** integrated base table combining all metrics for each workout or rest day.

### 6. median_hr
- **purpose:** computes median heart rate per workout type for imputation.  
- **key operations:**
  - groups `fitness_data_base` by `workout_type`  
  - calculates median `average_hr` across all valid records  
  - rounds result to nearest integer  
- **output:** lookup table for missing heart rate imputation.

### 7. fitness_data_final
- **purpose:** builds the complete daily dataset, integrating all metrics and derived columns.  
- **key operations:**
  - **calendar generation** – creates a continuous daily range for 2024  
  - **join with base** – merges the calendar with `fitness_data_base`  
  - **median imputation** – fills null `average_hr` using `median_hr` per workout type  
  - **derived metrics:**  
     - `calories_per_minute` = calories ÷ duration  
     - `workout_intensity` based on `average_hr` thresholds  
     - `sleep_duration_group` = `short`, `optimal`, `long`  
     - `steps_goal_pct` and `steps_goal_achieved_flag`  
     - `sleep_previous_night` via date offset lookup  
  - **temporal grouping:** adds month, quarter, and weekday columns  
  - **final casting and reordering**
- **output:**  
`fitness_data_final` – complete daily dataset combining all health metrics, ready for validation and dashboard use.

## key transformation logic
| stage | description | main functions |
|--------|--------------|----------------|
| **cleaning** | removes nulls, trims text, normalizes headers | `fx_clean`, `fx_text`, `fx_null_or_blank` |
| **parsing** | converts raw text to structured date/number/time formats | `fx_date`, `fx_number`, `fx_to_minutes`, `fx_to_hours`, `fx_to_km` |
| **merging** | joins related sources by date with nested joins | built-in joins + `Table.ExpandTableColumn` |
| **aggregation** | computes medians, averages, and grouped stats | `Table.Group`, `List.Median`, `List.Average` |
| **enrichment** | adds derived metrics and calendar attributes | `Date.*` and custom expressions |

## output tables
| table | description |
|--------|-------------|
| **fitness_data_base** | merged and standardized intermediate dataset combining all sources. |
| **median_hr** | lookup table for heart rate imputation by workout type. |
| **fitness_data_final** | final enriched dataset used for validation and bi reporting. |

sample outputs available in [`/data/sample/fitness_data_validation_sample.xlsx`](../data/sample/fitness_data_validation_sample.xlsx).

## related documentation
- [**etl pipeline overview**](./etl_pipeline.md)  
- [**etl queries**](./queries)  
- [**etl functions**](./functions)  
- [**validation walkthrough**](../validation/validation_walkthrough.md)

## notes
- buffering is applied only when needed for stable joins.  
- etl flow is modular and can be extended to additional sources or metrics.  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
