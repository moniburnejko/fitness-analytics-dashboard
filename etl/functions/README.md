# etl functions
this folder contains a collection of reusable power query (m language) functions used across etl pipelines.  
each function includes in-code comments describing the key transformation steps and logic.  

## fx_clean
**purpose:** cleans and standardizes raw tables before processing.  
**main actions:**
- removes fully empty rows  
- trims whitespace in all text cells  
- converts column names to lowercase snake_case  
- appends units or parenthesis content (e.g., `Workout Duration (min)` → `workout_duration_min`)

## fx_text
**purpose:** cleans and normalizes text fields.  
**main actions:**
- removes control characters, tabs, and extra spaces  
- replaces non-breaking spaces (nbsp) with normal spaces  
- standardizes punctuation (e.g., “–” and “—” → “-”)  
- supports casing options: `"lower"`, `"upper"`, `"proper"` (default), or `"none"`

## fx_number
**purpose:** safely converts text to numeric values
**main actions:**
- trims, cleans, and standardizes decimal/thousands separators  
- removes fuzzy tokens like `≈`, `~`
- supports suffixes: `K` (e.g., `7.8K` → `7800`) and `%` (`85%` → `0.85` if enabled)  
- accepts both dots and commas as decimal separators  
- handles non-breaking spaces and inline formatting noise

## fx_date
**purpose:** parses various date formats into valid date values.  
**main actions:**
- detects and converts excel serial numbers (1–599999)  
- supports iso-like and datetime formats  
- normalizes separators (`.`, `/` → `-`)  
- supports multiple cultures (default: `{"en-GB","en-US","pl-PL"}`)  
- automatically converts datetime and datetimezone types

## fx_to_minutes
**purpose:** converts time strings or values to total minutes.  
**main actions:**
- supports `hh:mm` and `hh:mm:ss` formats  
- parses expressions like `1h30min`, `90min`, or `1,5h`  
- optional `default_unit` parameter (`"min"` default, supports `"h"`)

## fx_to_hours
**purpose:** converts time strings or values to total hours.  
**main actions:**
- supports `hh:mm` and `hh:mm:ss` formats  
- parses `1h30m`, `90min`, or `1,5h`  
- optional `default_unit` parameter (`"h"` default, supports `"min"`)

## fx_to_km
**purpose:** converts distance strings or values to kilometers.  
**main actions:**
- supports `km`, `m`, and `mi` units  
- parses combined values like `1km 300m`  
- optional parameters:  
  - `default_unit` (`"km"` default, supports `"m"`, `"mi"`)  
  - `mile_factor` (default `1.609`)

## general notes
- each function includes inline comments explaining the purpose of each step.  
- functions are designed to be modular and composable within staging or transformation queries.  
- safe defaults prevent unexpected type errors or null propagation.

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
