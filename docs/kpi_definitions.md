# kpi definitions

> **purpose:** this document defines all key performance indicators (kpis) used across the fitness analytics etl pipeline and looker studio dashboard  
> each kpi includes its calculation logic, business meaning, and technical source

## workout & performance kpis
| **kpi name** | **formula** | **description** | **business purpose** | **source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **average workout duration** | avg(workout_duration_min) | mean workout time in minutes per session | measures training consistency and workload trends | looker studio |
| **longest workout duration** | max(workout_duration_min) | longest individual workout in the selected date range | identifies peak performance sessions | looker studio |
| **top performing workout** | max(calories_burned) | finds the most energy-intensive activity | highlights the most effective workout types | looker studio |
| **calories per minute** | calories_burned / workout_duration_min | average calories burned per minute of workout | measures efficiency of energy expenditure per training | power query |
| **average calories burned** | avg(calories_burned) | mean calories burned per workout | evaluates workout intensity over time | looker studio |
| **workout intensity** | if([average_hr] >= 140 then "high" else if [average_hr] >= 110 then "medium" else "low") | categorizes intensity based on average heart rate | enables grouping of workouts by effort level | power query |
| **workout consistency (%)** | 100 * count_distinct(if(length(trim(workout_type)) > 0, date, null)) / count_distinct(date) | percentage of days with a recorded workout | indicates adherence to fitness plan | looker studio |

## heart rate kpis
| **kpi name** | **formula** | **description** | **business purpose** | **source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **average heart rate (hr)** | avg(average_hr) | mean average hr across workouts | tracks cardiovascular workload and adaptation | looker studio |
| **max heart rate (hr)** | max(max_hr) | peak hr achieved during training | indicates maximum exertion level reached | looker studio |
| **resting heart rate** | avg(resting_hr) | mean resting hr per period | monitors long-term recovery and overall fitness | looker studio |
| **average_hr_imputed** | boolean flag: true if value imputed using median_hr | identifies hr values filled during etl | ensures data transparency in hr-based metrics | power query |
| **heart rate zones duration** | sum(workout_duration_min) by workout_intensity | total training time per hr intensity zone | evaluates workload distribution across effort levels | looker studio |

## sleep kpis
| **kpi name** | **formula** | **description** | **business purpose** | **source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **average sleep hours** | avg(sleep_hours) | mean number of hours slept per night | evaluates recovery quality | looker studio |
| **average previous night sleep** | avg(sleep_previous_night) | average sleep duration the night before each workout | correlates sleep with next-day performance | excel → looker studio |
| **sleep duration** | if(sleep_hours < 6, "short(<6h)") else if(sleep_hours <= 8, "optimal(6-8h)") else "long(>8h)" | categorizes sleep duration for distribution analysis | enables pattern comparison across sleep quality groups | power query |
| **sleep optimal (%)** | count(case when sleep_duration = "optimal" then 1 end) / count(case when sleep_duration is not null then 1 end) * 100 | percentage of nights with optimal sleep duration (6–8h) | measures adherence to recovery standards | looker studio |

## activity kpis
| **kpi name** | **formula** | **description** | **business purpose** | **source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **average daily steps** | avg(steps) | mean daily step count | evaluates overall physical activity level | looker studio |
| **steps goal (%)** | (steps / 10000) * 100 | % progress toward 10k step goal | measures adherence to daily movement target | power query |
| **steps goal reached** | if steps_goal_pct >= 100 then true else false | flag for reaching daily step goal | identifies active vs inactive days | power query |
| **active minutes** | avg(active_minutes) | mean active minutes per day | monitors daily mobility engagement | looker studio |

## recovery & correlation kpis
| **kpi name** | **formula** | **description** | **business purpose** | **source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **recovery category** | case when workout_type is null and (sleep_duration = "optimal(6-8h)" or sleep_duration = "long(>8h)") then "rest" when (workout_intensity = "low" and sleep_duration = "optimal(6-8h)") then "recovery" when workout_intensity in ("high", "medium") then "workout" else "rest" end | classifies each day as workout, recovery, or rest | enables visualization of training balance (gantt-style chart) | power query |
| **sleep–performance correlation** | scatter: x = avg(sleep_previous_night), y = avg(calories_burned) | shows relation between sleep and next-day performance | reveals how rest impacts energy output | looker studio |
| **workout–calories relationship** | scatter: x = avg(workout_duration_min), y = avg(calories_burned) | displays dependency between training length and calories | highlights efficiency of different workouts | looker studio |

## derived context fields
| **kpi / field** | **formula / derivation** | **purpose** |
|------------------|--------------------------|--------------|
| day_of_week | date.totext([date], "ddd") | enables weekday trend analysis |
| day_of_week_number | date.dayofweek([date], day.monday)+1 | provides numeric ordering (1–7) for correct weekday sorting |
| month_name | date.monthname([date]) | used for monthly aggregation |
| month_number | date.month([date]) | enables chronological sorting of months |
| month_start_date | date.startofmonth([date]) | anchors monthly grouping to the first day of the month |
| quarter | "q" & number.totext(date.quarterofyear([date])) | used for quarterly drill-down |
| sleep_previous_night |  | enables lag-based correlation analysis |
| calories_per_minute | calories_burned / workout_duration_min | efficiency metric used in multiple kpis |

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
