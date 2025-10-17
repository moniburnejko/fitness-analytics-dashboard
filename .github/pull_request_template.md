---
name: "🔁 pull request"
about: submit your changes for review
title: "[PR] short description of changes"
labels: ["review"]
---

## summary
provide a brief summary of the purpose of this pull request.  
example: *"added fx_clean improvements and updated fitness_data_final query to handle new columns."*

## related issue
link to the related issue, if applicable.  
example: `closes #12` or `fixes #8`

## type of change
select the type of change this pr introduces:  
- [ ] new feature  
- [ ] bug fix  
- [ ] refactor / optimization  
- [ ] documentation update  
- [ ] validation logic change  
- [ ] other (please specify)

## description of changes
describe the key changes in this pull request:  
- updated `fx_*` functions  
- modified queries or logic in `/etl/queries/`  
- adjusted validation rules or thresholds  
- added or updated documentation in `/docs/`

## testing
describe how you tested your changes:  
- [ ] verified transformations in power query  
- [ ] validated data consistency in output tables  
- [ ] confirmed all dq checks pass  
- [ ] reviewed results in dashboard or excel sample  
- [ ] no regressions found in validation_summary

## checklist
before requesting a review, please confirm that:  
- [ ] code runs without errors  
- [ ] comments and headers follow project conventions  
- [ ] documentation updated if needed  
- [ ] sample data and queries remain consistent  
- [ ] no sensitive or local data committed  
- [ ] reviewer assigned  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
