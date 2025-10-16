# docs
this folder contains the **project documentation layer** for the fitness analytics etl + bi repository.  
it includes high-level overviews, technical descriptions, and metadata supporting the etl, validation, and bi dashboard components.

## purpose
the `/docs` directory centralizes all descriptive and reference materials used throughout the project:
- summarizes the **etl and validation** workflows  
- defines **data structures and kpi logic**  
- provides **business and analytical context** for the bi visualization  
- documents the **dashboard structure, interactions, and metrics** through `dashboard-summary.md`  

## folder contents
| file | description |
|------|--------------|
| [`etl-summary.md`](etl-summary.md) | summary of the power query etl and validation process |
| [`dashboard-summary.md`](dashboard-summary.md) | overview of the looker studio dashboard structure, metrics, and interactions |
| [`data-dictionary.md`](data-dictionary.md) | column-level metadata with descriptions and data types |
| [`kpi-definitions.md`](kpi-definitions.md) | concise list of all kpis (etl + looker studio) with logic references |
| [`project-overview.md`](project-overview.md) | full analytical and technical overview of the project scope, goals, and workflow |

## recommended reading order
for the best understanding of the project’s flow, review the documentation in this order:
1. **[`project-overview.md`](project-overview.md)** - introduces project context and objectives   
2. **[`etl-summary.md`](etl-summary.md)** - explains data transformation and validation workflow  
3. **[`dashboard-summary.md`](dashboard-summary.md)** – describes dashboard logic, visuals, and interactivity  
4. **[`data-dictionary.md`](data-dictionary.md)** - provides full column-level reference  
5. **[`kpi-definitions.md`](kpi-definitions.md)** - lists and defines key performance indicators used throughout the project  

this order reflects the logical data lifecycle:  
📥 data → ⚙️ transformation → ✅ validation → 📊 visualization  

## related folders
| folder | description |
|---------|--------------|
| [`/etl`](../etl) | power query etl pipeline and function documentation |
| [`/validation`](../validation) | validation logic, rule tables, and data quality framework |
| [`/bi`](../bi) | looker studio dashboard structure, assets, and supporting documentation |
| [`/data`](../data) | sample input and output datasets |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
