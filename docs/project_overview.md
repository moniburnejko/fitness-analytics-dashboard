# project overview
this document provides a complete overview of the *fitness analytics etl + bi* project - an end-to-end analytical workflow built in **power query m** and **looker studio**, focused on understanding the relationships between **physical activity, sleep, and recovery**.  
the project demonstrates advanced **data preparation**, **validation logic**, and **interactive visualization** in a unified analytical environment.

## project objectives
the main goals of the project are:
- to design a **modular power query etl pipeline** for fitness tracking data,  
- to apply **dynamic validation logic** ensuring data accuracy and completeness,  
- to create an **interactive bi dashboard** highlighting user performance and wellness patterns,  
- to maintain **transparent documentation** for every stage of the workflow.

## data sources and structure
all data originate from a synthetic dataset that simulates daily fitness logs for a full year (366 days).  
input files are stored in [`/data/sample`](../data/sample) and consist of the following sheets:

| source | description | key fields |
|---------|--------------|-------------|
| `WorkoutLogs` | session-level workout records | date, workout_type, workout_duration, calories_burned |
| `ActivityTracking` | daily activity and step data | date, steps, distance, active_minutes |
| `SleepMonitoring` | sleep duration and quality | date, sleep_hours |
| `HeartRateData` | heart rate statistics | date, average_hr, max_hr, resting_hr |

each table uses **date** as the primary key for merging.  
data intentionally include irregularities (nulls, inconsistent units, missing days) to emulate real-world scenarios.

## etl architecture
the etl pipeline (see [`/etl`](../etl)) standardizes, cleans, and enriches all data sources using **power query m**.  
the process is modular, transparent, and version-controlled.

| phase | description | output |
|--------|--------------|----------|
| **cleaning** | trims whitespace, removes empty rows, normalizes headers and casing | cleaned tables per source |
| **standardization** | parses inconsistent dates, numbers, and time formats | unified datatypes and units |
| **integration** | merges all sources by date into one dataset | `fitness_data_base` |
| **enrichment** | derives analytical fields (e.g., `calories_per_minute`, `steps_goal_pct`) | `fitness_data_final` |
| **output** | final table ready for validation and BI | `fitness_data_final` |

custom m-functions (e.g., `fx_clean`, `fx_date`, `fx_number`) ensure consistency and error resilience.

📄 detailed process: [`etl_walkthrough.md`](../etl/etl_walkthrough.md)

## validation framework
after etl completion, the dataset passes through a rule-based **validation layer** (see [`/validation`](../validation)).  
this framework ensures both **logical coherence** and **numerical plausibility** of the transformed data.

| query | role | description |
|--------|------|--------------|
| `validation_rules` | rule registry | defines rule name, type, and target column |
| `fitness_data_validation` | validation execution | applies all rules to `fitness_data_final`, adds error/warning flags |
| `validation_summary` | reporting | aggregates validation results and completeness statistics |

the result is a fully validated dataset with record-level flags:
- `has_error`, `has_warn`, `data_validation_flag`, and `data_completeness`.

📄 detailed process: [`validation_walkthrough.md`](../validation/validation_walkthrough.md)

## visualization layer
the validated dataset (`fitness_data_validation.xlsx`) serves as the data source for an interactive **looker studio dashboard**  
(see [`/bi/looker-studio`](../bi/looker-studio)).

the dashboard contains **three analytical pages**:
| page | focus | key components |
|------|--------|----------------|
| **performance panel** | global overview of user activity and trends | kpi cards, monthly trend lines, donut breakdowns |
| **workout analytics** | detailed session-level insights | type comparison, duration vs calories, heart rate zones |
| **health & recovery** | sleep and recovery balance | gauges, sleep-performance correlation, heatmaps, recovery timeline |

features:
- cross-filtering between all charts,  
- optional metrics (switching between different performance measures),  
- drill-down navigation (quarter → month → weekday),  
- tooltips and hover-based metric details,  
- global filters (`Valid Data`, `Month`, `Workout Type`, `Reset`).

📄 dashboard documentation: [`dashboard_summary.md`](./dashboard_summary.md)

## analytical insights
the dashboard answers key performance and wellness questions:

| question | insight source |
|-----------|----------------|
| how consistent are my workouts over time? | performance panel - consistency rate & monthly trend |
| which days and types of training drive the highest burn? | workout analytics - record burn & type comparison |
| how does sleep affect recovery and performance? | health & recovery - recovery timeline & sleep-performance correlation |
| when is my recovery or resting heart rate optimal? | health & recovery - resting hr trend |
| how complete and valid is the dataset? | validation summary |

## key datasets and outputs
| dataset | description |
|----------|-------------|
| `fitness_data_final` | enriched and standardized dataset (output of etl) |
| `fitness_data_validation` | validated dataset with completeness and validation columns |
| `validation_summary` | aggregated results showing error/warning counts |
| `fitness_dashboard` | looker studio visualization connected to validated dataset |

sample outputs:  
- [`fitness_data_validation_sample.xlsx`](../data/sample/fitness_data_validation_sample.xlsx)

## technologies used
| tool | purpose |
|------|----------|
| **power query (excel)** | etl and feature engineering |
| **m language** | custom transformations and validation logic |
| **looker studio** | interactive data visualization |
| **excel 365** | output review and data verification |
| **github** | version control and documentation management |

## related documentation
| file | description |
|-------|--------------|
| [`etl_summary.md`](./etl_summary.md) | combined summary of data flow and validation |
| [`kpi_definitions.md`](./kpi_definitions.md) | all kpi formulas and logic |
| [`dashboard_summary.md`](./dashboard_summary.md) | detailed walkthrough of dashboard pages |
| [`data_dictionary.md`](./data_dictionary.md) | column-level metadata |
| [`project_overview.md`](./project_overview.md) | this file - full documentation entry point |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
