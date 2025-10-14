---
name: ✨ feature request
about: suggest a new feature or improvement for etl, validation, or dashboard components
title: "[FEATURE] short description of your idea"
labels: ["enhancement"]
---

## summary
describe the feature or improvement you’d like to propose.  
<br>**example:**  
- add fx_to_steps_km conversion to standardize pedometer inputs 
- include data quality score in validation_summary

## motivation
why is this feature important or useful?  
<br>**example:**  
- helps detect low-activity days automatically in the validation layer

## possible implementation
how could this feature be added or built?  
*(optional - rough ideas are fine)*  
<br>**example:**  
- create a new column `activity_score` using weighted metrics  
- integrate fx_is_between thresholds to define score tiers

## related files or queries
list affected modules or files (if known):
- `/etl/functions/fx_to_km.pq`
- `/validation/queries/validation_summary.pq`

## additional context
add references, screenshots, or examples (optional)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
