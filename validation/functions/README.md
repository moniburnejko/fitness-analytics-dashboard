# validation functions
this folder contains custom power query (m language) functions used for data validation and quality checks within the etl process.  

## fx_null_or_blank
**purpose:** checks whether a value is null, empty, or contains only whitespace.  
**main actions:**
- returns `true` if the input is `null`, `""`, or text consisting only of spaces  
- returns `false` otherwise  
**use case:** quick data completeness checks and identifying missing text values before transformation

## fx_is_numeric
**purpose:** verifies whether a given value can be safely interpreted as a number.  
**main actions:**
- supports both numeric and numeric-like text inputs (e.g., `"12.3"`, `"1,200"`)  
- returns `true` for valid numeric values and `false` for invalid or mixed-format strings  
**use case:** detecting invalid numeric fields before conversion or aggregation

## fx_is_between
**purpose:** validates whether a numeric value falls within a specified range.  
**main actions:**
- accepts parameters `min` and `max` (inclusive boundaries)  
- returns `true` if the value is within range, otherwise `false`  
**use case:** checking logical consistency (e.g., heart rate, sleep hours, steps count) against valid thresholds

## fx_in_set
**purpose:** checks whether a value belongs to a defined list or category set.  
**main actions:**
- compares the value (case-insensitive by default) to a reference list  
- returns `true` if found, `false` otherwise  
**use case:** validating categorical fields such as workout types or activity sources

## fx_list_broken
**purpose:** identifies invalid or unexpected items within a list compared to a reference list.  
**main actions:**
- returns a list of values that are **not** present in the reference set  
- supports text and numeric comparisons  
**use case:** spotting incorrect labels, typos, or unmapped categories in dimension columns

## general notes
- all validation functions return boolean or list outputs compatible with conditional columns or summary reports.  
- can be used directly in power query transformations or combined in rule-based validation tables.  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko
