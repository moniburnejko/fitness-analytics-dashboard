# looker studio
this folder contains all documentation and configuration files for the **looker studio bi dashboard**  
developed as the visualization layer of the *fitness analytics etl + bi* project.  

it provides technical details on dashboard structure, calculated fields, tooltips, color system,  
and data integration from the validated power query output (`fitness_data_validation.xlsx`).


## folder structure
| file | description |
|------|--------------|
| [`report-overview.md`](report-overview.md) | detailed description of dashboard pages, layout, charts, and interactions |
| [`calculated-fields.md`](calculated-fields.md) | list of calculated fields created directly in looker studio (formulas, logic, and purpose) |
| [`tooltips-catalog.md`](tooltips-catalog.md) | full catalog of all hover and custom tooltips used in the dashboard |
| [`color-system.md`](color-system.md) | color palette reference defining main, intensity, and semantic colors |


## data integration
- the dashboard connects to a **single validated dataset**:  
  [`/data/sample/fitness_data_validation_sample.xlsx`](../../data/sample/fitness_data_validation_sample.xlsx)  
  (generated after full etl + validation pipeline)
- all charts use the global filter `Valid Data`, while selected metrics additionally apply the `Complete Data` filter
- source fields originate from:
  - **etl layer** → [`fitness_data_final.pq`](../../etl/queries/fitness_data_final.pq)
  - **validation layer** → [`fitness_data_validation.pq`](../../validation/queries/fitness_data_validation.pq)

## design & interactivity
- consistent **dark ui** color scheme (see [`color-system.md`](color-system.md))  
- cross-filtering enabled globally: selecting one chart dynamically filters others  
- global report-level filters: `Month`, `Workout Type`, and `Reset Filter` button  
- interactive features include:
  - optional metrics
  - drill-down hierarchy 
  - gauge charts for qualitative KPIs 
  - custom analytical tooltips with additional contextual explanations and insights
  - hover tooltips for default metric breakdowns  

## dashboard pages
| page | description |
|------|--------------|
| **performance panel** | high-level overview of total workouts, trends, and activity structure |
| **workout analytics** | detailed comparison of workout types, durations, and performance relationships |
| **health & recovery** | analysis of sleep, recovery, and resting heart rate trends |

see detailed walkthrough: [`report-overview.md`](report-overview.md)

## tooltip coverage summary
the dashboard includes both **hover tooltips** and **custom analytical tooltips**  
to enhance interpretability and guide users through insights.

| dashboard section | hover tooltips | custom tooltips | total |
|--------------------|----------------|-----------------|--------|
| **performance panel** | 4 | 3 | 7 |
| **workout analytics** | 3 | 3 | 6 |
| **health & recovery** | 2 | 5 | 7 |
| **total** | **9** | **11** | **20** |

see full tooltip definitions: [`tooltips-catalog.md`](tooltips-catalog.md)

## calculated metrics
- all dashboard metrics are computed dynamically in looker studio  
- logic is documented in [`calculated-fields.md`](calculated-fields.md)
- kpis are summarized again in [`/docs/kpi-definitions.md`](../../docs/kpi-definitions.md)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
