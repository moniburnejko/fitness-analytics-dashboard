# validation
this folder contains the data validation layer of the fitness analytics project.  
it extends the etl pipeline by applying a rule-based validation framework to the `fitness_data_final` dataset,  
ensuring data completeness, consistency, and logical accuracy before bi visualization.

## folder structure
| path | description |
|------|--------------|
| [`validation_walkthrough.md`](validation_walkthrough.md) | detailed documentation of the validation process, rule logic, and function behavior |
| [`/functions`](functions) | reusable m-language validation functions for rule execution |
| [`/queries`](queries) | main validation scripts (.pq) for rule definition, record-level results, and summary reporting |

## validation process
1. **rule definition**  
   - all rules are defined in [`validation_rules.pq`](queries/validation_rules.pq)  
   - each rule specifies:  
     - `rule_name` - unique rule identifier  
     - `target_column` - column to validate  
     - `rule_type` - validation logic type (e.g. `NotNull`, `BetweenInc`, `InSet`)  
     - `param1`, `param2` - rule parameters  
     - `severity` - `Error` or `Warn`  
2. **function execution**  
   - rules are applied using modular validation functions in [`/functions`](functions):  
     - `fx_null_or_blank` - completeness checks  
     - `fx_is_numeric` - numeric type validation  
     - `fx_is_between` - range validation  
     - `fx_in_set` - categorical membership validation  
     - `fx_list_broken` - aggregates rule violations for reporting  
3. **validation output**  
   - [`fitness_data_validation.pq`](queries/fitness_data_validation.pq) - record-level validation results  
   - [`validation_summary.pq`](queries/validation_summary.pq) - aggregated summary by rule, column, and severity  
4. **integration with etl**  
   - validation operates on `fitness_data_final` (output from `/etl/`)  
   - results are exported as `fitness_data_validation` and `validation_summary` tables  
   - sample outputs are available in:  
     [`/data/sample/fitness_data_validation_sample.xlsx`](../data/sample/fitness_data_validation_sample.xlsx)

## documentation links
- **etl pipeline overview:** [`/etl_pipeline.md`](../etl_pipeline.md)  
  → describes how validation connects to the main data flow  
- **etl walkthrough:** [`/etl_walkthrough.md`](../etl_walkthrough.md)  
  → explains transformations preceding validation  
- **validation walkthrough:** [`validation_walkthrough.md`](validation_walkthrough.md)  
  → full step-by-step logic of rule application and summary aggregation

## notes
- rules are easily extendable - add new entries to `validation_rules.pq`  
- all functions return nullable logical values (`true` / `false` / `null`)  
- validation summary helps monitor overall data quality and identify recurring issues

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
