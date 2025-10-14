# validation
this folder contains the full power query data validation process for the **fitness analytics etl + bi** project.  
it defines and executes data quality rules applied to the final etl output (`fitness_data_final`) before dashboard visualization.

the validation process ensures completeness, consistency, and logical accuracy across all fitness metrics, producing both detailed and aggregated quality reports.

## folder structure
| path | description |
|------|--------------|
| [`validation_walkthrough.md`](validation_walkthrough.md) | detailed explanation of the validation logic, flow, and output structure |
| [`/functions`](functions) | reusable helper functions for rule evaluation and null or range checks |
| [`/queries`](queries) | main validation queries (.pq): rule definitions, validation engine, and summary aggregation |

## validation inputs
- **input dataset:** `fitness_data_final` (output from the etl pipeline)  
- **rule definitions:** [`validation_rules.pq`](queries/validation_rules.pq)  
- **sample input file:** [`/data/sample/fitness_data_raw_sample.xlsx`](../data/sample/fitness_data_raw_sample.xlsx)

## validation outputs
- **record-level dataset:** `fitness_data_validation`  
  - includes all columns from `fitness_data_final`  
  - adds `rule_*`, `broken_rules`, `has_error`, `has_warn`, `data_validation_flag`, and `data_completeness`  
- **summary dataset:** `validation_summary`  
  - aggregates validation and completeness results by category  
- **sample output file:** [`/data/sample/fitness_data_validation_sample.xlsx`](../data/sample/fitness_data_validation_sample.xlsx)

## process summary
1. **load rules and dataset** – imports rule table (`validation_rules`) and final ETL output  
2. **apply validation functions** – evaluates each record using `fx_null_or_blank`, `fx_is_between`, `fx_in_set`, and others  
3. **generate rule results** – creates logical columns (`rule_*`) per validation rule  
4. **derive flags** – computes `has_error`, `has_warn`, and `data_validation_flag`  
5. **assess completeness** – marks rows as `complete` or `incomplete` based on required fields  
6. **aggregate results** – produces the `validation_summary` table with record counts and percentages

## related documentation
- [**etl pipeline overview**](../etl/etl_pipeline.md)  
- [**etl walkthrough**](../etl/etl_walkthrough.md)  
- [**validation walkthrough**](./validation_walkthrough.md)  
- [**validation functions**](./functions)  
- [**validation queries**](./queries)

## notes
- validation logic is modular and easily extendable through new rules in `validation_rules.pq`.  
- this step is the final stage before bi visualization in looker studio.

📅 *last updated: october 2025*  
👩‍💻 *author: monika burnejko*
