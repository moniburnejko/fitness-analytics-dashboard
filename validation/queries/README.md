# validation queries
this folder contains all power query m scripts used in the data validation stage of the fitness analytics etl + bi project.  
each query applies or summarizes validation logic defined in `/validation/functions` and `/validation/validation_rules.pq`.

## contents
| file | description |
|------|--------------|
| **validation_rules.pq** | defines all validation rules applied to `fitness_data_final`, including rule type, parameters, and severity level. |
| **fitness_data_validation.pq** | applies validation logic to the dataset, generating one `rule_*` column per rule and deriving flags: `has_error`, `has_warn`, `data_validation_flag`, and `data_completeness`. |
| **validation_summary.pq** | aggregates validation and completeness results, returning total record counts and percentage shares for each category. |

## related documentation
- detailed walkthrough: [`validation_walkthrough.md`](../validation_walkthrough.md)  
- validation function reference: [`/validation/functions`](../functions)  
- related etl documentation: [`/etl/etl_pipeline.md`](../../etl/etl_pipeline.md) and [`/etl/etl_walkthrough.md`](../../etl/etl_walkthrough.md)

## notes
- sample input and output files are available in `/data/sample/`.

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
