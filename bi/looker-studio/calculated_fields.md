# calculated fields  
this document lists all custom fields defined directly in **looker studio**.  
fields pre-computed in the **etl/validation layer** (power query) are referenced but not redefined here.           

global filters: **valid data** (report-level).             
selective **complete data** filter is applied on: *total workouts*, *workout breakdown by type*, *workout breakdown by intensity*, *monthly activity trend*, *workout type comparison*, *workout duration vs calories burned*, *sleep-performance correlation*, *sleep pattern heatmap*.

## 🚀 performance panel 
#### 📈 kpi cards
| field name | formula | unit | notes |
|---|---|---|---|
| **Total Workouts** | `COUNT(workout_type)` | count | counts individual workout rows (multi-sessions per day are counted separately) |
| **Workout Consistency** | `100 * COUNT_DISTINCT(IF(LENGTH(TRIM(workout_type)) > 0, date, NULL)) / COUNT_DISTINCT(date)` | % | ignores empty workout types by design |
| **Most Active Day** | day_of_week_name with MAX(SUM(active_minutes))| – | most active determined by total active_minutes |
| **Average Sleep Hours** | `AVG(sleep_hours)` | h | - |
| **Average Daily Steps** | `AVG(steps)` | steps | - |

### 📊 charts
#### monthly activity trend (combo)
| field name | formula | unit | notes |
|---|---|---|---|
| **Total Workout Minutes** | `SUM(workout_duration_min)` | min | - |
| **Average Calories Burned** | `AVG(calories_burned)` | kcal | - |

#### daily steps vs day of week (bar)
| field name | formula | unit | notes |
|---|---|---|---|
| **Average Daily Steps** | `AVG(steps)` | steps | chart has reference line, marking the 10K daily steps benchmark |

### workout breakdown (donuts)
| field name | formula | unit | notes |
|---|---|---|---|
| **Workout Count (by Type/Intensity)** | `COUNT(workout_type)` | count | - |
| **Total Workout Minutes (by Type/Intensity)** | `SUM(workout_duration_min` | min | optional metric |

## 🏋️ workout analytics
#### 📈 kpi cards
| field name | formula | unit | notes |
|---|---|---|---|
| **Record Burn** | `MAX(calories_burned)` | kcal | - |
| **Average Session Length** | `AVG(workout_duration_min)` | min | – |
| **Longest Session Length** | `MAX(workout_duration_min)` | min | – |

### 📊 charts
#### workout type comparison (bar, optional metrics)
| field name | formula | unit | notes |
|---|---|---|---|
| **Average Calories per Minute** | `AVG(calories_per_minute)` | kcal/min | - |
| **Total Calories Burned** | `SUM(calories_burned)` | kcal | optional metric |
| **Average Workout Minutes** | `AVG(workout_duration_min)` | min | optional metric |
| **Total Workout Minutes** | `SUM(workout_duration_min)` | min | optional metric |
| **Average HR** | `AVG(average_hr)` | bpm | optional metric |
| **Max HR** | `MAX(max_hr)` | bpm | optional metric |

#### workout duration vs calories burned (scatter)
| field name | formula | unit | notes |
|---|---|---|---|
| **X — Average Workout Minutes** | `AVG(workout_duration_min)` | min | x-axis |
| **Y — Average Calories Burned** | `AVG(calories_burned)` | kcal | y-axis | 
| **Bubble Size — Average HR** | `AVG(average_hr)` | bpm | bubble size | 
| **Bubble Color — Workout Type** | `workout_type` | – | semantic color palette (see color_system.md) |

#### heart rate zones (area)
| field name | formula | unit | notes |
|---|---|---|---|
| **Workout Intensity** | `workout_intensity` | - | workout_intensity is a base field from etl; chart shows distribution across zones |
| **Total Workout Hours** | `SUM(workout_duration_min)/60` | h | - |

## 😴 health & recovery
#### 📈 gauges
| field name | formula | unit | notes |
|---|---|---|---|
| **Sleep Quality (%)** | `100 * COUNT(CASE WHEN sleep_duration_group = "Optimal(6-8h)" THEN 1 END) / COUNT(CASE WHEN sleep_duration_group IS NOT NULL THEN 1 END)` | % | color thresholds: <50% pink, 50–74% yellow, ≥75% green |
| **Move Quality (%)** | `AVG(steps_goal_pct)` | % | same color thresholds as above. steps_goal_pct is a base field from etl |

### 📊 charts
#### resting heart rate over time (dual line)
| field name | formula | unit | notes |
|---|---|---|---|
| **Average Resting HR** | `AVG(Resting HR)` | bpm | main line (violet) |
| **Resting HR - 3-Month Moving Avg** | `MOVING_AVG(AVG(Resting HR), 3)` | bpm | secondary line (gray) |

#### recovery timeline (gantt-style stacked bars)
| field name | formula | unit | notes |
|---|---|---|---|
| **Day Category** | logic created in looker studio: workout (high/medium intensity), recovery (low intensity + optimal sleep), rest (no workout + optimal/long sleep) | – | drill-down: quarter → month → day of week. color mapping: workout pink, recovery blue, rest violet |

#### sleep pattern (heatmap)
| field name | formula | unit | notes |
|---|---|---|---|
| **Average Sleep Hours** | `AVG(sleep_hours)` | h | color scale: <6h pink, 6–8h green, >8h yellow |

#### sleep-performance correlation (scatter)
| field name | formula | unit | notes |
|---|---|---|---|
| **X - Previous Night Sleep** | `AVG(sleep_previous_night)` | h | x-axis. sleep_previous_night is base field from etl |
| **Y - Next Day Calories Burned** | `AVG(calories_burned` | kcal | y-axis |
| **Bubble Size — Next Day Workout Minutes** | `AVG(workout_duration_min` | min | bubble size |
| **Bubble Color — Workout Type** | `workout_type` | – | semantic color palette |

## notes
- fields **not** listed here are either raw columns from the etl output or pre-calculated in power query (see: [`/etl/queries/fitness_data_final.pq`](../../etl/queries/fitness_data_final.pq)).  
- color mappings and thresholds are documented in [`color_system.md`](color_system.md).  
- tooltip texts are maintained in [`tooltips_catalog.md`](tooltips_catalog.md).  

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
