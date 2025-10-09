# 📊 KPI Definitions

> **Purpose:** This document defines all Key Performance Indicators (KPIs) used across the Fitness Analytics ETL pipeline and Looker Studio dashboard.  
> Each KPI includes its calculation logic, business meaning, and technical source.

## Workout & Performance KPIs
| **KPI Name** | **Formula** | **Description** | **Business Purpose** | **Source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **Average Workout Duration** | AVG(Workout_Duration_(min)) | Mean workout time in minutes per session | Measures training consistency and workload trends | Looker Studio |
| **Longest Workout Duration** | MAX(Workout_Duration_(min)) | Longest individual workout in the selected date range | Identifies peak performance sessions | Looker Studio |
| **Top Performing Workout** | MAX(Calories_Burned) | Finds the most energy-intensive activity | Highlights the most effective workout types | Looker Studio |
| **Calories per Minute** | Calories_Burned / Workout_Duration_(min) | Average calories burned per minute of workout | Measures efficiency of energy expenditure per training | Power Query |
| **Average Calories Burned** | AVG(Calories_Burned) | Mean calories burned per workout | Evaluates workout intensity over time | Looker Studio |
| **Workout Intensity** | IF([Average_HR] >= 140 THEN "High"<br>ELSE IF [Average_HR] >= 110 THEN "Medium"<br>ELSE "Low" | Categorizes intensity based on average heart rate | Enables grouping of workouts by effort level | Power Query |
| **Workout Consistency (%)** | 100*COUNT_DISTINCT(IF(LENGTH(TRIM(Workout_Type)) > 0, Date, NULL)) / COUNT_DISTINCT(Date) | Percentage of days with a recorded workout | Indicates adherence to fitness plan | Looker Studio |

## Heart Rate KPIs
| **KPI Name** | **Formula** | **Description** | **Business Purpose** | **Source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **Average Heart Rate (HR)** | AVG(Average_HR) | Mean average HR across workouts | Tracks cardiovascular workload and adaptation | Looker Studio |
| **Max Heart Rate (HR)** | MAX(Max_HR) | Peak HR achieved during training | Indicates maximum exertion level reached | Looker Studio |
| **Resting Heart Rate** | AVG(Resting_HR) | Mean resting HR per period | Monitors long-term recovery and overall fitness | Looker Studio |
| **Average_HR_Imputed** | Boolean flag: TRUE if value imputed using MedianHR | Identifies HR values filled during ETL | Ensures data transparency in HR-based metrics | Power Query |
| **Heart Rate Zones Duration** | SUM(Workout_Duration_(min)) by Workout_Intensity | Total training time per HR intensity zone | Evaluates workload distribution across effort levels | Looker Studio |

## Sleep KPIs
| **KPI Name** | **Formula** | **Description** | **Business Purpose** | **Source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **Average Sleep Hours** | AVG(Sleep_Hours) | Mean number of hours slept per night | Evaluates recovery quality | Looker Studio |
| **Average Previous Night Sleep** | AVG(Sleep_Previous_Night) | Average sleep duration the night before each workout | Correlates sleep with next-day performance | Excel → Looker Studio |
| **Sleep Duration** | IF(Sleep_Hours < 6, "Short(<6h)") <br>ELSE IF(Sleep_Hours <= 8, "Optimal(6-8h)") <br>ELSE "Long(>8h)" | Categorizes sleep duration for distribution analysis | Enables pattern comparison across sleep quality groups | Power Query |
| **Sleep Optimal (%)** | COUNT(CASE WHEN Sleep_Duration = "Optimal" THEN 1 END) / COUNT(CASE WHEN Sleep_Duration IS NOT NULL THEN 1 END) * 100 | Percentage of nights with optimal sleep duration (6–8h) | Measures adherence to recovery standards | Looker Studio |

## Activity KPIs
| **KPI Name** | **Formula** | **Description** | **Business Purpose** | **Source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **Average Daily Steps** | AVG(Steps) | Mean daily step count | Evaluates overall physical activity level | Looker Studio |
| **Steps Goal (%)** | (Steps / 10000) * 100 | % progress toward 10K step goal | Measures adherence to daily movement target | Power Query |
| **Steps Goal Reached** | IF Steps_Goal_% >= 100 THEN true <br>ELSE false | Flag for reaching daily step goal | Identifies active vs. inactive days | Power Query |
| **Active Minutes** | AVG(Active_Minutes) | Mean active minutes per day | Monitors daily mobility engagement | Looker Studio |

## Recovery & Correlation KPIs
| **KPI Name** | **Formula** | **Description** | **Business Purpose** | **Source** |
|---------------|-------------|-----------------|----------------------|-------------|
| **Recovery Category** | CASE <br>WHEN Workout_Type IS NULL AND (Sleep_Duration = "Optimal(6-8h)" OR Sleep_Duration = "Long(>8h)") THEN "Rest" <br>WHEN (Workout Intensity = "Low" AND Sleep_Duration = "Optimal(6-8h)") THEN "Recovery" <br>WHEN Workout Intensity IN ("High", "Medium") THEN "Workout" <br>ELSE "Rest" <br>END | Classifies each day as Workout, Recovery, or Rest | Enables visualization of training balance (Gantt-style chart) | Power Query |
| **Sleep–Performance Correlation** | Scatter: X = AVG(Sleep_Previous_Night), Y = AVG(Calories_Burned) | Shows relation between sleep and next-day performance | Reveals how rest impacts energy output | Looker Studio |
| **Workout–Calories Relationship** | Scatter: X = AVG(Workout_Duration_(min)), Y = AVG(Calories_Burned) | Displays dependency between training length and calories. | Highlights efficiency of different workouts. | Looker Studio |

## Derived Context Fields
| **KPI / Field** | **Formula / Derivation** | **Purpose** |
|------------------|--------------------------|--------------|
| DayOfWeek | Date.ToText([Date], "ddd") | Enables weekday trend analysis |
| DayOfWeek_Number | Date.DayOfWeek([Date], Day.Monday)+1 | Provides numeric ordering (1–7) for correct weekday sorting |
| Month_Name | Date.MonthName([Date]) | Used for monthly aggregation |
| Month_Number | Date.Month([Date]) | Enables chronological sorting of months |
| Month_StartDate| Date.StartOfMonth([Date]) | Anchors monthly grouping to the first day of the month |
| YearMonth | Date.ToText([Date], "yyyy-MM") | Combines year and month into a single key for timeline analysis |
| Quarter | "Q" & Number.ToText(Date.QuarterOfYear([Date])) | Used for quarterly drill-down |
| Sleep_Previous_Night | Excel: OFFSET on Sleep_Hours | Enables lag-based correlation analysis |
| Calories_per_Minute | Calories_Burned / Workout_Duration_(min) | Efficiency metric used in multiple KPIs |

📅 *Last updated: October 2025*  
👩‍💻 *Author: Monika Burnejko*
