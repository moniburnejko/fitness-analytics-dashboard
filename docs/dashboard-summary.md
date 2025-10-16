# dashboard summary
this document provides a structured overview of the **fitness analytics dashboard** built in **looker studio**, based on the validated dataset `fitness_data_validation.xlsx`.  
the dashboard visualizes trends in activity, training, sleep, and recovery, enabling both high-level and detailed analysis of fitness performance and balance.

## overview
the dashboard connects cleaned and validated data from the etl pipeline with interactive bi visualizations.  
it consists of three analytical sections (pages):
1. **performance panel** - overview of daily activity, structure, and consistency  
2. **workout analytics** - detailed performance insights by workout type and intensity  
3. **health & recovery** - analysis of rest quality, recovery balance, and long-term well-being  

each page uses cross-filtering, optional metrics, and unified data-quality filters (`valid data`, `complete data`) for reliability.

## data source
| file | origin | description |
|------|---------|-------------|
| `fitness_data_validation.xlsx` | `/data/output/` | final validated dataset after power query etl + validation pipeline |
| source queries | `/etl/queries/` | contain calculated columns (e.g., `calories_per_minute`, `steps_goal_pct`, `sleep_duration_group`) |
| validation layer | `/validation/` | adds completeness, validation, and flag fields (`data_validation_flag`, `data_completeness`) |

the dashboard uses this single unified dataset as its source; no blending with external data occurs.

## structure
| page | main visuals | purpose |
|------|---------------|----------|
| **performance panel** | kpis, line & bar charts, donut charts | summarize activity volume, trends, and workout structure |
| **workout analytics** | bar, area & scatter charts | analyze workout performance and heart rate patterns by type and intensity |
| **health & recovery** | gauges, gantt chart, heatmap, scatter chart | explore sleep, recovery quality, and their relation to physical performance |

detailed chart logic and configuration are documented in:  
[`/bi/looker-studio/report-overview.md`](../bi/looker-studio/report-overview.md)

## key calculated metrics
| category | examples | source |
|-----------|-----------|---------|
| **activity** | `total workout minutes`, `steps goal %`, `most active day` | power query & looker studio |
| **performance** | `average calories per minute`, `record burn (max calories burned)` | looker studio |
| **recovery** | `sleep quality`, `move quality`, `average resting hr` | looker studio |
| **data quality** | `data_validation_flag`, `data_completeness` | power query |

full definitions are listed in:  
[`/bi/looker-studio/calculated-fields.md`](../bi/looker-studio/calculated-fields.md)  
and summarized in [`/docs/kpi-definitions.md`](kpi-definitions.md)

## interactivity & usability
the dashboard supports:
- **cross-filtering** across all charts  
- **optional metrics** (switching between different performance measures) 
- **drill-down navigation** (e.g., quarter → month → day of week in timeline charts)  
- **hover tooltips** with contextual metrics  
- **descriptive tooltips** for analytics insights and legend explanations  
- **report-level filters**:  
  - `month`  
  - `workout type`  
  - `reset` button  
  - `valid data` (global)  
  - `complete data` (used selectively on key charts)

tooltip details are documented in:  
[`/bi/looker-studio/tooltips-catalog.md`](../bi/looker-studio/tooltips-catalog.md)

## color system
the dashboard follows a consistent dark-themed design and uses semantic color mapping defined in:  
[`/bi/looker-studio/color-system.md`](../bi/looker-studio/color-system.md)

**main colors**
- primary blue (`#4CC9F0`) – highlights & charts  
- energy pink (`#F15BB5`) – intensity / alerts  
- success green (`#00C896`) – optimal results  
- calm violet (`#B388EB`) – recovery metrics  
- neutral gray (`#9D9D9D`) – secondary details  

**semantic mapping**
- by workout type (HIIT, running, yoga, etc.)  
- by workout intensity (high, medium, low)  
- by recovery state (workout, recovery, rest)  

## output
| output | format | description |
|---------|---------|-------------|
| **interactive dashboard** | Looker Studio | three-page visual analytics interface |
| **screenshots** | `/bi/assets/` | static preview images of key dashboard views |
| **documentation files** | `/bi/looker-studio/` | metadata, chart logic, color system, and calculated metrics |

## related documentation
| file | description |
|------|--------------|
| [`etl-summary.md`](etl-summary.md) | overview of the etl and validation workflow |
| [`validation-walkthrough.md`](../validation/validation-walkthrough.md) | rule logic and validation framework |
| [`report-overview.md`](../bi/looker-studio/report-overview.md) | detailed chart-by-chart documentation |
| [`color-system.md`](../bi/looker-studio/color-system.md) | looker studio color mapping system |
| [`kpi-definitions.md`](kpi-definitions.md) | full kpi catalog across etl and bi |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
