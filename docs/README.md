# docs
this folder contains the **project documentation layer** for the fitness analytics etl + bi repository.  
it includes high-level overviews, technical descriptions, and metadata supporting the etl, validation, and bi dashboard components.

## purpose
the `/docs` directory centralizes all descriptive and reference materials used throughout the project:
- summarizes the etl and validation workflows  
- defines data structures and kpi logic  
- provides business and analytical context for bi visualization  

## folder contents
| file | description |
|------|--------------|
| [`etl_summary.md`](etl_summary.md) | concise overview of the full etl + validation process and its outputs |
| [`data_dictionary.md`](data_dictionary.md) | detailed description of each dataset column, including validation fields |
| [`kpi_definitions.md`](kpi_definitions.md) | formal definitions and calculation logic for all metrics used in the dashboard |
| [`project_overview.md`](project_overview.md) | general introduction and project background for portfolio or presentation use |

## recommended reading order
for the best understanding of the project’s flow, review the documentation in this order:
1. **[`project_overview.md`](project_overview.md)** - introduction to project goals, scope, and business context  
2. **[`etl_summary.md`](etl_summary.md)** - overview of the end-to-end etl and validation workflow  
3. **[`data_dictionary.md`](data_dictionary.md)** - detailed definitions of all dataset columns and validation flags  
4. **[`kpi_definitions.md`](kpi_definitions.md)** - explanation of calculated metrics used in the bi dashboard  

this order reflects the logical data lifecycle:  
📥 data → ⚙️ transformation → ✅ validation → 📊 visualization  

## related folders
| folder | description |
|---------|--------------|
| [`/etl`](../etl) | full power query etl pipeline and transformation functions |
| [`/validation`](../validation) | validation logic, rules, and summary outputs |
| [`/bi`](../bi) | looker studio dashboard configuration |
| [`/data`](../data) | sample input and output datasets |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
