# assets
this folder contains all **visual and media assets** used across the *fitness analytics etl + bi* project.  
it includes dashboard screenshots, preview images, and supporting graphics for documentation and portfolio use.

## usage
assets from this folder are primarily used in:
- [`/bi/looker-studio/report-overview.md`](../looker-studio/report-overview.md) – dashboard layout and visual walkthrough  
- [`/bi/looker-studio/color-system.md`](../looker-studio/color-system.md) – color usage examples  
- [`/docs/dashboard-summary.md`](../../docs/dashboard-summary.md) – visual overview of all pages  
- repository previews and portfolio showcase (e.g., on notion or linkedin)

screenshots are exported directly from **looker studio** in png format with consistent naming and resolution.

## naming conventions
| prefix | example | meaning |
|---------|----------|----------|
| `performance-panel-` | `performance-panel-main.png` | overview and kpi section of the performance page |
| `workout-analytics-` | `workout-analytics-main.png` | visuals from the workout analytics page |
| `health-and-recovery-` | `health-and-recovery-main.png` | visuals from the health & recovery page |
| `*-filters` | `performance-panel-filters.png` | screens using global filters and cross-filtering |
| `*-tooltips` | `health-and-recovery-tooltips.png` | screens showing tooltip positions or content |
| `*-optional-metrics` | `workout-analytics-optional-metrics.png` | screens with optional metric views |
| `*-drill-down` | `| `*-drill-down` | `health-and-recovery-drill-down.png` | screens showing drill-down function |

all file names use lowercase letters and underscores for consistency with the repository style.

## technical notes
- preferred format: `.png`  
- background: dark mode (native to dashboard design)  
- images are referenced using relative paths (`![](../assets/screenshots/filename.png)`)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
