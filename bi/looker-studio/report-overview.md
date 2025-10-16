# report overview
this document provides a detailed overview of the **fitness analytics dashboard** built in **looker studio**.  
the dashboard visualizes key health and activity metrics derived from the validated dataset `fitness_data_validation.xlsx` produced through the power query etl and validation pipeline.

## executive summary
the fitness analytics dashboard provides a comprehensive view of physical activity, workout habits, and recovery balance over time.  
it integrates multiple wellness dimensions - **activity consistency, workout intensity, sleep duration, and recovery quality** - into an interactive, dark-themed bi environment.

the dashboard serves as both:
- an **analytical tool** that identifies trends, correlations, and performance gaps, and  
- a **motivational tracker** highlighting personal progress and achievements   

it consists of three main analytical panels:
1. `performance panel` – high-level overview of workouts, activity, and intensity distribution  
2. `workout analytics` – detailed comparison of training types, durations, and efficiency  
3. `health & recovery` - correlation between rest, sleep, and workout performance  

the dashboard uses **automated data quality filters** (`valid data`, `complete data`) to ensure only verified records feed the visuals.  
cross-filtering, optional metrics, and tooltip-driven explanations allow for **multi-angle exploration** and intuitive storytelling of fitness performance.

## dashboard specifications
| section | description |
|----------|--------------|
| **data source** | validated excel dataset [`fitness_data_validation.xlsx`](../../data/sample/fitness_data_validation_sample.xlsx) |
| **data pipeline** | processed through power query etl + validation workflow |
| **tool** | looker studio |
| **visuals** | scorecards, line & bar charts, donut charts, scatter charts, area charts, gauges, heatmaps |
| **filters** | month, workout type, reset, valid data (report level), complete data (specific) |
| **theme** | dark mode using semantic color palette defined in [`color-system.md`](color-system.md) |
| **interactivity** | cross-filtering, drill-down, hover metrics, optional metrics, and tooltips |
| **report pages** | performance panel, workout analytics, health & recovery |

📎 related documentation:  
- [`color-system.md`](color-system.md) - visual identity and semantic color palette  
- [`calculated-fields.md`](calculated-fields.md) - field calculations and logic definitions  
- [`tooltips-catalog.md`](tooltips-catalog.md) - full list of analytical tooltips  
- [`../../docs/dashboard-summary.md`](../../docs/dashboard-summary.md) - overall bi documentation summary

## 🚀 performance panel
the **performance panel** acts as the dashboard’s main landing page, summarizing overall activity, workout frequency, and intensity structure.  
it provides a quick but data-rich snapshot of performance trends and consistency across the analyzed period.

the layout is structured into three main areas:
1. **summary kpi cards** - global indicators of activity and recovery consistency  
2. **activity & trend section** – monthly activity trend & daily steps vs day of week - visual overview of monthly activity and daily step distribution  
3. **intensity & workout structure** – workout breakdown by type and intensity - donut charts showing the share of workouts by type and intensity  

### 1. summary kpi section
**visual type:** `scorecards`               
**filters:** `valid data` (report level), `complete data` (specific for selected cards)

| kpi | description | calculation / notes |
|------|--------------|--------------------|
| **total workouts** | total number of recorded workouts | `COUNT(workout_type)` - each workout instance counted individually |
| **workout consistency** | ratio of active days to total days | `100 * COUNT_DISTINCT(IF(LENGTH(TRIM(workout_type)) > 0, date, NULL)) / COUNT_DISTINCT(date)` |
| **most active day** | weekday with highest total active minutes | `DAY_OF_WEEK with MAX(SUM(active_minutes))` |
| **average sleep hours** | mean sleep duration across all valid days | `AVG(sleep_hours)` |
| **average daily steps** | average steps per day | `AVG(steps)` |

### 2. monthly activity trend
**type:** `combo chart` (columns + line)
   
**metrics:** `total workout minutes` (column), `average calories burned` (line)
  
**reasoning:**  
dual-axis layout effectively represents energy expenditure (trend over time) alongside total duration.  
this combination highlights intensity and endurance patterns - key for assessing progressive overload or burnout.
  
**filters:** `valid data` (report-level), `complete data` (chart-level)

### 3. daily steps vs day of week
**type:** `bar chart (vertical)`
  
**metric:** `average daily steps`

**reasoning:**
reference line: dashed gray line marking the 10K daily steps benchmark - the commonly recommended daily goal.                          
weekday-level analysis helps reveal routine-based activity imbalances.              

**filters:** `valid data` (report-level)

### 4. workout breakdown by type
**type:** `donut chart`
  
**metrics:** default: `workout count`, optional: `total workout minutes`

**reasoning:**  
categorical donut visual supports quick understanding of training diversity.  
the optional metric toggle enhances analysis depth without overwhelming the layout.

**color logic:** `semantic workout type palette`

**filters:** `valid data` (report-level), `complete data` (chart-level)

### 5. workout breakdown by intensity
**type:** `donut chart` 

**metrics:** default: `workout count`, optional: `total workout minutes`

**reasoning:**  
visualizes distribution of training effort across **high / medium / low** categories.  
ideal for identifying long-term training balance.

**color logic:** `intensity color scale`
- high → #F15BB5 *(energy pink)*
- medium → #F7B801 *(warm yellow)*
- low → #4CC9F0 *(primary blue)*

**filters:** `valid data` (report-level), `complete data` (chart-level)

### 6. interactivity & tooltips
- **cross-filtering:** selecting any element dynamically filters the rest of the dashboard  
- **optional metrics:** toggle between *count* and *duration* on donut charts  
- **hover tooltips:** provide contextual metrics (e.g., average, % share, total)  
- **custom tooltips:** some charts include additional explanation cards for interpretation guidance

### 7. purpose & interpretation
the performance panel enables quick assessment of:
- overall workload and training frequency  
- activity rhythm and daily habits  
- workout distribution by type and intensity  
- sleep and activity balance indicators  

it answers the question:  
> how active, consistent, and balanced was the user over time?

## 🏋️ workout analytics
the **workout analytics** page provides an in-depth analysis of training types, durations, heart rate metrics, and overall workout efficiency.  
it focuses on understanding the **intensity, structure, and performance outcomes** of different workouts, while maintaining visual clarity and interactivity.

the layout includes:
1. **summary kpi cards** - highlight top performance and overall effort  
2. **type-based comparisons** – evaluate workout categories and intensity zones  
3. **efficiency analysis** – heart rate zones & workout duration vs calories burned - explore how workout duration and calories burned interact  

### 1. summary kpi section
**visual type:** `scorecards`  
**filters:** `valid data` (report-level)

| kpi | description | calculation / notes |
|------|--------------|----------------|
| **record burn** | highest calories burned in a single workout | `MAX(calories_burned)` |
| **average session** | mean workout duration | `AVG(workout_duration_min)` |
| **longest session** | maximum workout duration | `MAX(workout_duration_min)` |

### 2. workout type comparison
**type:** `bar chart (vertical)`

**metrics:** default: `average calories per minute`, optional: `total calories burned`, `average workout minutes`, `total workout minutes`, `average hr`, `max hr`
  
**reasoning:**  
vertical bars with a zero baseline give a clear, categorical comparison across workout types.                   
the metric selector lets the user evaluate the same category set under different performance lenses (efficiency, load, duration, heart rate), without changing the layout.

**color logic:** `semantic workout type palette`

**filters:** `valid data` (report-level), `complete data` (chart-level), optional metric switch available directly on chart

### 3. heart rate zones
**type:** `area chart (stacked)`

**metrics:** `workout intensity category` (*low, medium, high*), `total workout hours`

**reasoning:**  
area chart clearly shows how total workout time is distributed across intensity groups each month.               
it emphasizes both trend and proportion of low, medium, and high intensity training loads over time.              
using hours instead of workout count gives a better representation of total training volume.    

**color logic:** `intensity color scale`
- high → #F15BB5 *(energy pink)*
- medium → #F7B801 *(warm yellow)*
- low → #4CC9F0 *(primary blue)*
  
**filters:** `valid data` (report-level)

### 4. workout duration vs calories burned
**type:** `bubble (scatter) chart`

**metrics:** x-axis: `total workout minutes`, y-axis: `calories burned`, bubble size: `average HR`, bubble color: `workout type`

**reasoning:**  
scatter plot captures efficiency and workload relationships across workout types.  
it reveals how different activities vary in duration vs energy output and highlights outliers or inefficiencies.

**hover tooltip:** workout type, month, duration, calories, average hr

**color logic:** `semantic workout type palette`
  
**filters:** `valid data` (report-level), `complete data` (chart-level)

### 5. interactivity & tooltips
- **cross-filtering:** selecting a workout type or bubble dynamically updates all other visuals  
- **optional metrics:** average calories per minute, total calories burned, average workout duration, total workout duration, average hr, max hr for better comparison  
- **hover tooltips:** display detailed performance metrics (avg HR, duration, calories) 
- **descriptive tooltips:** some charts include additional explanation cards for interpretation guidance

### 6. purpose & interpretation
the workout analytics section enables deeper insights into:
- which workouts dominate frequency vs duration  
- how calories burned scale with workout length and intensity  
- whether heart rate and efficiency align with intended goals  

it answers the question:  
> which workouts deliver the best performance and efficiency balance?

## 😴 health & recovery  
the **health & recovery** page explores the relationship between **sleep, recovery, and workout performance**, completing the analytical narrative of the dashboard.  
it connects physical activity data with rest quality and heart rate trends to assess overall recovery balance.  

the layout includes:
1. **recovery guages** – sleep quality and move quality gauges providing an instant summary of recovery balance and goal achievement
2. **revobery trends section** – resting heart rate over time & recovery timeline - visualizing long-term recovery trends and distribution of workout, recovery, and rest days
3. **sleep & performance section** – sleep pattern heatmap & sleep-performance correlation - analyzing sleep duration regularity and its impact on next-day workout performance

### 1. recovery gauges  
#### a: sleep quality (%)  
**type:** `radial gauge`

**metric:** `(count of optimal sleep durations (6–8h) / count of all valid sleep durations) * 100`

**reasoning:**             
displays sleep balance at a glance. circular gauge visual reinforces the idea of recovery as a cyclical process.  

**ranges & color logic:**  
- < 50% → #F15BB5 *(energy pink - poor)*  
- 50–74% → #F7B801 *(warm yellow - suboptimal)*  
- ≥ 75% → #00C896 *(success green - optimal)*  

**filters:** `valid data` (report-level)

#### b: move quality (%)  
**type:** `radial gauge`

**metric:** average steps goal achievement (`AVG(steps_goal_pct)`)

**reasoning:**  
complements sleep quality, showing balance between activity level and rest recovery.  

**ranges & color logic:** same as above  

**filters:** `valid data` (report-level)

### 2. resting heart rate over time  
**type:** `line chart` with secondary 3-month moving average

**metric:** `average resting hr`, `3-month moving average`

**reasoning:**  
illustrates long-term heart rate recovery patterns.            
helps detect physiological improvements or fatigue periods across the training cycle.  

**color logic:** 
- primary trend → #B388EB *(calm violet)*,
- moving average → #9D9D9D *(neutral gray)*
    
**filters:** `valid data` (report-level)

### 3. recovery timeline  
**type:** `gantt-style stacked bar chart`

**metric:** percentage of days classified into `Workout`, `Recovery`, or `Rest`

**category logic:**
- **Workout** → high or medium intensity days  
- **Recovery** → low intensity + optimal sleep  
- **Rest** → no workout + long or optimal sleep  

**reasoning:**   
visualizes distribution of daily activity states over time.               
helps identify how training, rest, and recovery balance shift across weeks or months.  

**color logic:**  
- workout → #F15BB5 *(energy pink)*  
- recovery → #4CC9F0 *(primary blue)*  
- rest → #B388EB *(calm violet)*  

**filters:** `valid data` (report-level), supports drill-down: quarter → month → day of week

### 4. sleep pattern heatmap  
**type:** `heatmap` (matrix: weekdays × months)

**metric:** `average sleep hours`

**reasoning:**   
provides quick visual cues for sleep consistency and weekday patterns.                 
helps identify behavioral tendencies and potential recovery deficits.  

**color logic:**
- < 6h → #F15BB5 *(energy pink – short sleep)*  
- 6–8h → #00C896 *(success green – optimal)*  
- > 8h → #F7B801 *(warm yellow – long)*
 
**filters:** `valid data` (report-level)

### 5. sleep-pattern correlation  
**type:** `scatter (bubble) chart`

**metrics:** x-axis: `previous night sleep`, y-axis:`next day calories burned`, bubble size: `next day workout minutes`, bubble color: `workout type`

**reasoning:**   
reveals how rest duration affects workout output and effort levels.             
bubble size adds a third dimension of workout duration, while color coding highlights training type differences.  
the visualization offers a compact, multidimensional view of the **sleep–performance relationship**.  

**hover tooltip:** month, workout type, previous night sleep, next day calories burned, next day workout minutes

**color logic:** `semantic workout type palette`

**filters:** `valid data` (report-level)

### 6. interactivity & tooltips
- **cross-filtering:** selecting any element dynamically filters the rest of the visuals  
- **drill-down:** enabled in *recovery timeline* (quarter → month → day of week)  
- **hover tooltips:** display key metrics such as sleep hours, day category, or resting HR  
- **custom tooltips:** some charts include additional explanation cards for interpretation guidance
  
### 7. purpose & interpretation
the health & recovery section provides a holistic perspective on how recovery patterns influence performance outcomes.     
it connects sleep behavior and physiological data with workout intensity to highlight balance or overtraining risk.

**key insights:**
- monitors the *distribution* of workout, recovery, and rest days  
- tracks *sleep quality trends* and weekday patterns  
- correlates *resting HR variation* with overall recovery state  
- supports decisions on adjusting training load and rest periods  

it answers the question:  
> does my recovery rhythm support my performance progress?

## references
#### 1. related documentation
| file | description |
|------|--------------|
| [`calculated-fields.md`](calculated-fields.md) | contains all custom fields and logic implemented directly in looker studio (e.g., consistency rate, steps goal %, sleep quality %, etc.) |
| [`tooltips-catalog.md`](tooltips-catalog.md) | catalog of all tooltip texts used across the dashboard, grouped by page and visualization type |
| [`color-system.md`](color-system.md) | centralized definition of the dashboard color palette (main, semantic, and intensity scales) |
| [`/docs/dashboard-summary.md`](../../docs/dashboard-summary.md) | overall summary of the bi dashboard structure and analytical purpose |
| [`/etl/etl-pipeline.md`](../../etl/etl-pipeline.md) | etl architecture overview that produced the analytics-ready dataset |
| [`/validation/validation-walkthrough.md`](../../validation/validation-walkthrough.md) | detailed logic of data validation applied before visualization |

#### 2. data source
- all visuals use a single validated dataset: `fitness_data_validation.xlsx` 
- see sample: [`/data/sample/fitness_data_validation_sample.xlsx`](../../data/sample/fitness_data_validation_sample.xlsx)  
- data covers 366 days of synthetic fitness metrics across four original sources (`WorkoutLogs`, `ActivityTracking`, `HeartRateData`, `SleepMonitoring`)  
- transformations and validation executed fully in **power query (m language)**  

#### 3. color & accessibility guidelines
- color palette designed to maintain **high contrast** on dark background (#121212)  
- semantic colors indicate meaning:  
  - **enery pink (#F15BB5)** → high intensity / warning  
  - **primary blue (#4CC9F0)** → balance, neutral metrics  
  - **success green (#00C896)** → success, goal completion  
  - **calm violet (#B388EB)** → calm / recovery states  
  - **warm yellow (#F7B801)** → intermediate or extended values  
- all visual elements follow a consistent color logic across **Performance Panel**, **Workout Analytics**, and **Health & Recovery**  
- for detailed references, see: [`color-system.md`](color-system.md)

#### 4. interactivity & usability
the dashboard supports multiple interaction modes:  
- **cross-filtering** between all charts  
- **optional metrics** available mainly in workout type comparison and workout breakdown charts (toggle between different performance measures)
- **drill-down navigation** in recovery timeline (quarter → month → day of week)
- **hover tooltips** displaying contextual metrics (e.g., calories, duration, hr, sleep hours)
- **descriptive tooltips** explaining chart purpose, legend meaning, and adding brief analytics insights (💡) 
- **global filters:**
  - `workout type`
  - `month`
  - `reset` (clears all selections)
  - `valid data` (active across entire report)  
  - `complete data` (used on key charts to prevent null aggregation)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
