# contributing guide
this repository documents a complete power query etl and validation pipeline  
used in the *fitness analytics etl + bi* project.  

contributions, suggestions, and feedback are welcome - especially regarding query optimization, function improvements, or documentation clarity.

## project structure
- `/etl` - all transformation logic (functions, queries, documentation)  
- `/validation` - rule-based validation framework  
- `/data` - sample inputs and outputs  
- `/docs` - technical and analytical documentation  

## naming conventions
- use snake_case for all columns, functions, and queries  
- each query must start with a comment block:  
  `// query: name`, `// source: file/sheet`, `// purpose: description`, `// author: monikaburnejko | 2025`  
- prefer consistent step names (e.g. `clean`, `date_fixed`, `deduped`, `joined_base`)  

## guidelines
1. avoid unnecessary table.buffer - only when needed for join stability  
2. keep transformations modular and comment major steps  
3. use `fx_` prefix for custom m functions  
4. ensure queries refresh without manual path changes  
5. validate new datasets before adding them to the main model  

## testing
before pushing or opening a pr:
- refresh all queries to confirm no step errors  
- compare row counts and null counts with previous versions  
- verify that validation summary output remains consistent  

## communication
-	questions and ideas are always welcome!
  -	open a discussion via issues or contact the author directly: 
    - 📧 [monikaburnejko@gmail.com](mailto:monikaburnejko@gmail.com)  
    - 💼 [linkedin](https://www.linkedin.com/in/monika-burnejko-9301a1357)  

📅 last updated: october 2025
👩‍💻 author: Monika Burnejko
