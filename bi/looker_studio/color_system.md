# color system
this document defines the **visual color system** used in the looker studio dashboard for the *fitness analytics etl + bi* project.  
the palette ensures consistent visual semantics across metrics, charts, and kpi cards - supporting quick interpretation and accessibility.

## overview
the dashboard uses a **dark theme** designed for high contrast and clarity in data-rich visualizations.  
all colors are defined as css-like variables for reproducibility across tools.

## main colors
| variable | hex | usage |
|-----------|-----|-------|
| `primary-blue` | `#4CC9F0` | primary charts, highlights, and buttons |
| `energy-pink` | `#F15BB5` | alerts, high intensity, attention |
| `success-green` | `#00C896` | success, completed goals |
| `calm-violet` | `#B388EB` | recovery, relaxation metrics |
| `neutral-gray` | `#9D9D9D` | secondary elements, borders |

## intensity scale
| variable | hex | meaning |
|-----------|-----|----------|
| `intensity-high` | `#F15BB5` | strong activity or stress |
| `intensity-medium` | `#F7B801` | medium intensity |
| `intensity-low` | `#90F1EF` | low effort, calm states |

## backgrounds
| variable | hex | usage |
|-----------|-----|-------|
| `bg-primary` | `#121212` | main dashboard background |
| `bg-secondary` | `#1E1E1E` | cards, panels, widgets |
| `bg-accent` | `#252525` | hover or emphasis zones |

## text colors
| variable | hex | usage |
|-----------|-----|-------|
| `text-primary` | `#EAEAEA` | main text and values |
| `text-secondary` | `#B0B0B0` | labels and subtext |
| `text-muted` | `#7A7A7A` | inactive or helper text |

## semantic colors
### workout types
| type | color | hex |
|------|--------|-----|
| HIIT | energy pink | `#F15BB5` |
| Running | warm yellow | `#F7B801` |
| Cycling | bright blue | `#4CC9F0` |
| Walking | fresh green | `#00C896` |
| Yoga | soft violet | `#B388EB` |
| Swimming | aqua cyan | `#00B4D8` |
| Strength | magenta red | `#EF476F` |
| Tennis | light amber | `#FFD166` |

## examples in dashboard
| section | file | description |
|----------|-------|-------------|
| **Performance Overview (main view)** | [`performance_overview_main.png`](../assets/screenshots/performance_overview_main.png) | applies `primary-blue` for main charts and `energy-pink` for contrast lines; uses full *semantic workout type palette* in the **Workout Breakdown by Type** chart and *intensity scale* (high/medium/low) in the **Workout Breakdown by Intensity** donut |
| **Workout Analytics (main view)** | [`workout_analytics_main.png`](../assets/screenshots/workout_analytics_main.png) | showcases *semantic colors by workout type* across **Workout Type Comparison** and **Workout Duration vs Calories Burned**, and applies the *intensity scale* in the **Heart Rate Zones** area chart |
| **Workout Analytics (optional metric)** | [`workout_analytics_optional.png`](../assets/screenshots/workout_analytics_optional.png) | shows `primary-blue` for highlights and buttons |
| **Health & Recovery (main view)** | [`health&recovery_main.png`](../assets/screenshots/health&recovery_main.png) | displays the *intensity scale* on **Sleep Pattern Heatmap** and **Sleep Optimal / Steps Goal** gauges; in **Recovery Timeline**, applies color segmentation - `energy-pink` (Workout), `primary-blue` (Recovery), `calm-violet` (Rest) |


## notes
- all colors were tested for contrast and accessibility on dark backgrounds  
- the palette supports visual grouping and intensity-based storytelling  
- consistent color mapping across pages ensures intuitive user experience  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
