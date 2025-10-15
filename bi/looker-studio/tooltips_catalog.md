# tooltips catalog
this document lists all **tooltips** configured in *looker studio* for the **fitness analytics dashboard**.  
it includes both:
- 📊 `hover tooltips` (default data pop-ups), and  
- 💡 `custom tooltip boxes` (manual insights and chart explanations)

grouped by dashboard section:  
- **performance panel**
- **workout analytics**
- **health & recovery**

## 🚀 performance panel
### workout consistency (kpi)
- 💡 custom
- 💡 ```Percentage of days with at least one workout within the selected date range. A consistency rate above 90% suggests a highly stable workout routine.```

### monthly activity trend (combo)
- 💡 custom + 📊 hover
- 💡 ```Displays the total workout minutes (bars) and average calories burned (line) per month.<br>Peaks highlight months of high effort or training frequency - typically linked to better performance trends.<br>Use filters to explore how activity changes by month or workout type.```
- 📊 month, total workout minutes (min), average calories burned (kcal)
    
### daily steps vs day of week (bar)
- 💡 custom + 📊 hover
- 💡 ```Shows the average daily step count across weekdays.<br>Useful for identifying activity habits - e.g., lower movement midweek or higher weekend walks.<br>The dashed gray line marks the 10K daily steps benchmark.```
- 📊 day of week, average steps

### workout breakdown by type (donut0
- 📊 hover
- 📊 workout count, total workout minutes (optional)
  
### workout breakdown by intensity (donut)
- 📊 hover
- 📊 workout count, total workout minutes (optional)

## 🏋️ workout analytics
### workout type comparison (bar)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊

### heart rate zones (area)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊

### workout duration vs. calories burned (scatter)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊
  
## 😴 health & recovery
### sleep quality (gauge)
- 💡 custom
- 💡 ```  ```
  
### resting hr trend (line)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊

### recovery timeline (gantt-style)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊

### sleep pattern (heatmap)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊 
  
### sleep-performance correlation (scatter)
- 💡 custom + 📊 hover
- 💡 ```  ```
- 📊
  
## notes
- all hover tooltips automatically display metric values (e.g., totals, averages, min/max).  
- 💡 custom tooltips were manually designed in looker studio to improve interpretability and storytelling.  
- consistent color mapping is applied across all charts (see [`color_system.md`](color_system.md))  
- for calculated field formulas, refer to [`calculated_fields.md`](calculated_fields.md)

📅 *last updated: october 2025*  
👩‍💻 *author: Monika Burnejko*
