# tooltips catalog
this document lists all **tooltips** configured in *looker studio* for the **fitness analytics dashboard**.  
it includes both:
- 📊 hover tooltips (default data pop-ups), and  
- 💭 custom tooltip boxes (chart explanations and 💡 insights)

## 🚀 performance panel
### workout consistency (kpi)
- 💭 `custom`       
Percentage of days with at least one workout within the selected date range. <br> 💡 A consistency rate above 90% suggests a highly stable workout routine.

### monthly activity trend (combo)
- 📊 `hover`
    - month, total workout minutes, average calories burned
- 💭 `custom`       
Displays the total workout minutes (bars) and average calories burned (line) per month.<br>Use filters to explore how activity changes by month or workout type.<br>💡 Peaks highlight months of high effort or training frequency - typically linked to better performance trends.
    
### daily steps vs day of week (bar)
- 📊 `hover`
    - day of week, average steps
- 💭 `custom`        
Shows the average daily step count across weekdays.<br>The dashed gray line marks the 10K daily steps benchmark.<br>💡 Useful for identifying activity habits - e.g., lower movement midweek or higher weekend walks.

### workout breakdown by type (donut)
- 📊 `hover`
    - workout count, total workout minutes *(optional)*
  
### workout breakdown by intensity (donut)
- 📊 `hover`
    - workout count, total workout minutes *(optional)*

## 🏋️ workout analytics
### workout type comparison (bar)
- 📊 `hover`
    - average calories per minute, total calories burned *(optional)*, average workout minutes *(optional)*, total workout minutes *(optional)*, average hr *(optional)*, max hr *(optional)*
- 💭 `custom`        
Each bar shows the average value of the currently selected metric for every workout type.<br>Use the metric selector to switch between key performance indicators such as Calories Burned, Calories per Minute, Workout Duration, or Heart Rate.<br>The chart allows a direct comparison of workout intensity, efficiency, and total effort across all activity types.<br>💡 HIIT and Running typically stand out with the highest values per minute, while Yoga and Walking maintain lower, recovery-level metrics - highlighting differences in training focus and energy output.

### heart rate zones (area)
- 📊 `hover`
    - month, intensity group, total workout hours (in each group)
- 💭 `custom`       
Visualizes total workout hours across intensity zones - Low, Medium, High - aggregated by month.<br>💡 Balanced layers indicate good periodization; surges in High intensity may signal overtraining, while steady Medium levels show sustainable effort.

### workout duration vs. calories burned (scatter)
- 📊 `hover`
    -  month, workout type, average workout minutes, average calories burned, average hr
- 💭 `custom`       
Each bubble represents a monthly average for a given workout type.<br>•   X-axis → Average workout duration (min)<br>•   Y-axis → Average calories burned<br>•   Color → Workout type<br>•   Bubble size → Average heart rate (bpm)<br>💡 The upward trend shows how longer or more intense workouts lead to higher calorie burn. Dense clusters suggest efficient balance between time and effort.

  
## 😴 health & recovery
### sleep quality (gauge)
- 💭 `custom`          
Displays the percentage of days when sleep duration was within the optimal 6–8 hours range.<br>Color scale:<br>•   Pink < 50% → Insufficient recovery<br>•   Yellow 50–75% → Suboptimal consistency<br>•   Green > 75% → Optimal rest<br>💡 High stability here correlates with better overall performance and heart rate balance.
  
### resting hr trend (line)
- 📊 `hover`
    - month, average resting hr 
- 💭 `custom`        
The bold violet line shows the monthly average resting HR.<br>The thin gray line represents the 3-month moving average.<br>💡 A steady resting HR trend suggests proper recovery and cardiovascular adaptation - spikes may indicate fatigue or insufficient rest.

### recovery timeline (gantt-style)
- 💭 `custom`        
Visualizes the distribution of three recovery states:<br>•   Workout - High exertion days<br>•   Recovery - Active recovery or moderate effort<br>•   Rest - Full rest or extended sleep.<br>The drill-down function allows exploring recovery patterns across quarters, months, and days of the week for deeper temporal insights.<br>💡 A balanced distribution across quarters, months, and weekdays reflects effective periodization and recovery planning - consistent color variation indicates sustainable training cycles, while long streaks of pink or purple reveal potential overtraining or extended rest phases.

### sleep pattern (heatmap)
- 💭 `custom`         
Displays average sleep duration (in hours) by day of week and month.<br>•   Pink = Short sleep<br>•   Green = Optimal (6–8h)<br>•   Yellow = Long sleep (>8h)<br>💡 Identifies patterns - e.g. shorter sleep mid-week or longer weekend rest periods - useful for adjusting recovery planning.
  
### sleep-performance correlation (scatter)
- 📊 `hover`
    - month, workout type, previous night sleep, next day calories burned, next day workout minutes
- 💭 `custom`        
Each bubble represents the monthly average relationship between sleep duration (X) and next-day workout performance (Y).<br>•   X = Previous-night sleep hours<br>•   Y = Average next-day calories burned<br>•   Color = Workout Type<br>•   Bubble size = Average next-day workout minutes<br>💡 Longer and more consistent sleep patterns are associated with higher next-day energy output, especially for high-intensity workouts like HIIT and Running.
  
## notes
- all hover tooltips automatically display metric values (e.g., totals, averages, min/max).  
- custom tooltips were manually designed in looker studio to improve interpretability and storytelling.  
- consistent color mapping is applied across all charts (see [`color_system.md`](color_system.md))  
- for calculated field formulas, refer to [`calculated_fields.md`](calculated_fields.md)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
