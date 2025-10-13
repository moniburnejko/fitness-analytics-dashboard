# etl
this folder contains the full power query etl (extract-transform-load) pipeline for the fitness analytics project.  
it documents all data transformation stages - from raw data extraction to the analytics-ready dataset (`fitness_data_final`).

the etl process standardizes, cleans, merges, and enriches four fitness tracking sources before validation and dashboard visualization.

## folder structure
| path | description |
|------|--------------|
| [`etl_pipeline.md`](etl_pipeline.md) | high-level overview of the etl architecture, data flow, and dependencies |
| [`etl_walkthrough.md`](etl_walkthrough.md) | detailed step-by-step guide describing each transformation stage |
| [`/functions`](functions) | reusable m-language transformation functions used across queries |
| [`/queries`](queries) | main power query scripts (.pq) that implement the etl pipeline |

## data sources
- input: `fitness_data_2024_raw.xlsx` containing 4 sheets  
  - `WorkoutLogs` - per-workout data  
  - `ActivityTracking` - daily step and activity metrics  
  - `SleepMonitoring` - sleep duration and patterns  
  - `HeartRateData` - daily heart rate statistics  
- sample input file available in: [`/data/sample/fitness_data_raw_sample.xlsx`](../data/sample/fitness_data_raw_sample.xlsx)

## output
- final dataset: `fitness_data_final` - unified, validated table prepared for bi visualization  
- sample output file available in: [`/data/sample/fitness_data_validation_sample.xlsx`](../data/sample/fitness_data_validation_sample.xlsx)  
- validation rules and logic are documented separately under: [`/validation`](../validation)

## process summary
1. **source loading** - imports and promotes headers from each raw sheet  
2. **cleaning & normalization** - applies `fx_clean`, `fx_date`, `fx_number`, and `fx_text` for standardization  
3. **merging & enrichment** - joins datasets by date and calculates per-day metrics in `fitness_data_base`  
4. **aggregation** - computes medians and derived metrics in `median_hr` and `fitness_data_final`  
5. **validation (post-etl)** - executed via rules in [`/validation`](../validation), producing `fitness_data_validation` and `validation_summary`

## notes
- function-level documentation is provided in `/etl/functions/README.md`  
- validation is optional but recommended for data quality assurance before visualization

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
