# etl queries
this folder contains all power query m scripts (.pq) used in the etl pipeline.  
each file represents a transformation stage within the data flow - from raw input sheets to the final analytics-ready dataset.

## contents
| query file | description |
|-------------|--------------|
| `workoutlogs.pq` | cleans and standardizes per-workout data (type, duration, calories) |
| `activitytracking.pq` | normalizes daily activity data (steps, distance_km, active_minutes) |
| `sleepmonitoring.pq` | converts mixed sleep duration formats into numeric hours |
| `heartratedata.pq` | aggregates heart rate metrics per date (average, max, resting) |
| `fitness_data_base.pq` | merges all sources by date and applies per-day filtering logic |
| `median_hr.pq` | computes median average_hr per workout_type for imputation |
| `fitness_data_final.pq` | builds the final dataset with hr imputation, derived metrics, and temporal grouping |

## documentation links
- **etl pipeline overview:** [`/etl_pipeline.md`](../../etl_pipeline.md)  
  → high-level architecture, data flow diagram, and transformation dependencies
- **etl walkthrough:** [`/etl_walkthrough.md`](../../etl_walkthrough.md)  
  → step-by-step transformation logic with explanations for each query

## notes
- sample input file: `/data/sample/fitness_data_raw_sample.xlsx`  
- sample validated output: `/data/sample/fitness_data_validation_sample.xlsx`  
- validation logic is documented separately under `/validation/`

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
