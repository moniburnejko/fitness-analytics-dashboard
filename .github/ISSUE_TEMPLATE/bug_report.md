---
name: 🐛 bug report
about: report a bug or error in the etl, validation, or dashboard logic
title: "[BUG] short description of the issue"
labels: ["bug", "triage"]
---

## summary
clearly describe what went wrong.

**example:**
- fx_to_km converts miles incorrectly for small values
- validation_summary fails with Expression.Error on null lists

## steps to reproduce
list the exact steps that trigger the issue:
1. open `/etl/queries/fitness_data_final.pq`
2. apply function `fx_to_km` on `distance_km` column  
3. observe incorrect conversion results

## expected behavior
describe what should have happened.

**example:** 
- distance should be converted from miles to km using factor 1.609

## actual behavior
describe what actually happens, including error messages if any.  

**example:**
- 7.39 mi → 0.01 km (incorrect)
- 1.87 mi → 0 (incorrect)

## environment
- **operating system** 
- **excel / power query version**
- **related file(s)** (eg. `/etl/functions/fx_to_km.pq`, `/etl/queries/fitness_data_final.pq`)

## additional context
add screenshots, logs, or notes if relevant.  
*(optional but appreciated)*

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
