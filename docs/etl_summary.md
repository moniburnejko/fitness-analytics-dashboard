# etl + validation summary
this document provides a concise overview of the **fitness analytics etl + bi** project — an end-to-end data pipeline that transforms, validates, and visualizes personal fitness data using **power query m** and **looker studio**.

## overview
the project processes 366 days of health and fitness data collected across four sources:
- `workoutlogs` – workout type, duration, calories  
- `activitytracking` – steps, distance, active minutes  
- `sleepmonitoring` – sleep duration  
- `heartratedata` – daily heart rate metrics  

sample input:  
[`/data/sample/fitness_data_raw_sample.xlsx`](data/sample/fitness_data_raw_sample.xlsx)

the etl pipeline standardizes, merges, and enriches these datasets into a unified structure for analysis and dashboard visualization.  
for a detailed description of each stage, see:  
➡️ [`etl_walkthrough.md`](etl/etl_walkthrough.md)

## etl highlights
| stage | description | key functions |
|--------|-------------|----------------|
| **cleaning** | trims whitespace, normalizes headers and text | `fx_clean`, `fx_text` |
| **standardization** | parses dates, numbers, and units into consistent formats | `fx_date`, `fx_number`, `fx_to_minutes`, `fx_to_hours`, `fx_to_km` |
| **integration** | joins all sources by date into one base table | nested joins + selective buffering |
| **enrichment** | calculates derived metrics (e.g., `calories_per_minute`, `steps_goal_pct`, `sleep_previous_night`) | custom logic |
| **final dataset** | builds full daily table with temporal grouping | `fitness_data_final` |

## validation overview
the validation layer ensures logical and numeric consistency before visualization.  
rules are defined in [`/validation/queries/validation_rules.pq`](validation/queries/validation_rules.pq) and applied automatically through reusable validation functions.  
for a complete explanation of validation logic and flow, see:  
➡️ [`validation_walkthrough.md`](validation/validation_walkthrough.md)

**core outputs:**
- `fitness_data_validation` – contains **all columns from `fitness_data_final`** plus validation-specific fields (`rule_*`, `has_error`, `has_warn`, `data_validation_flag`, etc.)  
- `validation_summary` – aggregated view of validation and completeness results with record counts and percentages  

sample output:  
[`/data/sample/fitness_data_validation_sample.xlsx`](data/sample/fitness_data_validation_sample.xlsx)

## project structure
| folder | description |
|---------|--------------|
| [`/etl`](etl) | full power query etl pipeline and transformation functions |
| [`/validation`](validation) | validation logic, rules, and helper functions |
| [`/data`](data) | input datasets and sample outputs |
| [`/bi`](bi) | looker studio dashboard configuration |
| [`/docs`](docs) | project documentation, kpi definitions, and data dictionary |

## results
- **unified dataset:** `fitness_data_final` — complete, analytics-ready table prepared for validation  
- **validated dataset:** `fitness_data_validation` — contains all columns from `fitness_data_final` plus validation outputs and flags  
- **summary report:** `validation_summary` — aggregated data quality and completeness metrics  
- **final visualization:** interactive dashboard in **looker studio**

## notes
- all power query `.pq` scripts include descriptive headers for traceability.  
- functions are modular and reusable across both etl and validation workflows.  
- complete documentation available in:  
  - [`etl_pipeline.md`](etl/etl_pipeline.md)  
  - [`etl_walkthrough.md`](etl/etl_walkthrough.md)  
  - [`validation_walkthrough.md`](validation/validation_walkthrough.md)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
