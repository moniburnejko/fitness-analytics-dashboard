# contributing guidelines
thank you for your interest in contributing to **fitness-analytics-etl-bi** 💙  
this project is focused on building a clean, modular etl + validation pipeline for fitness tracking data.

## how to contribute
1. fork the repository  
2. create a new branch for your feature or fix:  
   `git checkout -b feature/my-new-function`
3. commit your changes with clear, descriptive messages:  
   `git commit -m "improved fx_to_minutes conversion for edge cases"`
4. push to your fork and open a pull request  

## code style
- use lowercase `snake_case` for all functions and queries  
- include clear headers in every `.pq` file:  
```
// query: fitness_data_final  
// purpose: merge all cleaned datasets and add derived metrics  
// author: monika burnejko | 2025
```
- comments should explain the purpose of each major step (not just what it does)  
- prefer relative paths (`/data/sample/`) over absolute local paths  

## documentation
- update `/docs/etl-walkthrough.md` and `/docs/validation-walkthrough.md` if logic changes  
- ensure new functions are listed in `/etl/functions/README.md`  
- if validation rules are added or changed, reflect them in `/validation/queries/validation_rules.pq`

## pull requests
- one logical change per pull request (e.g., one new function or query update)  
- include screenshots or short descriptions of test results  
- ensure no temporary or preview files are committed  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
