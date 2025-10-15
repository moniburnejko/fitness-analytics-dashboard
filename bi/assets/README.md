# assets
this folder contains all **visual and media assets** used across the *fitness analytics etl + bi* project.  
it includes dashboard screenshots, preview images, and supporting graphics for documentation and portfolio use.

## usage
assets from this folder are primarily used in:
- [`/bi/looker_studio/report_overview.md`](../looker_studio/report_overview.md) – dashboard layout and visual walkthrough  
- [`/bi/looker_studio/color_system.md`](../looker_studio/color_system.md) – color usage examples  
- [`/docs/dashboard_summary.md`](../../docs/dashboard_summary.md) – visual overview of all pages  
- repository previews and portfolio showcase (e.g., on notion or linkedin)

screenshots are exported directly from **looker studio** in png format with consistent naming and resolution.

## naming conventions
| prefix | example | meaning |
|---------|----------|----------|
| `performance_panel_` | `performance_panel_main.png` | overview and kpi section of the performance page |
| `workout_analytics_` | `workout_analytics_main.png` | visuals from the workout analytics page |
| `health_and_recovery_` | `health_and_recovery_main.png` | visuals from the health & recovery page |
| `*_tooltips` | `health_and_recovery_tooltips.png` | screens showing tooltip positions or content |
| `*_optional_metrics` | `workout_analytics_optional_metrics.png` | screens with optional metric views |

all file names use lowercase letters and underscores for consistency with the repository style.

## technical notes
- preferred format: `.png`  
- background: dark mode (native to dashboard design)  
- recommended resolution: **1600–1920px width** for readability in markdown  
- images are referenced using relative paths (`![](../assets/screenshots/filename.png)`)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
