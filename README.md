# Fitness Analytics Dashboard - Power Query ETL & Looker Studio BI

An end-to-end fitness analytics project that cleans messy multi-sheet Excel data with **Power Query (M)** and visualizes performance, recovery, and sleep patterns in **Looker Studio** with full cross-filtering, drill-downs, and optional metrics.

## 📂 Project Structure
```
```

## 🧭 Project Goals
- Build a reliable, analysis-ready fitness dataset from heterogeneous Excel sheets
- Standardize inconsistent formats (dates, units, text casing, "K" notations) and remove duplicates
- Enrich data with a full calendar, HR imputations, and analysis fields
- Deliver a 3-page interactive dashboard for executives and practitioners

## 📦 Data Overview
- **Source**: Single Excel workbook with 4 sheets (synthetic data)
- **Sheets**: WorkoutLogs, ActivityTracking, SleepMonitoring, HeartRateData
- **Size**: ~400 rows per sheet (daily granularity, 2024)
- **Issues handled**: mixed date formats (6), mixed units (min/h, km/m/mi), text noise, "K" thousands, ~5% duplicate rows, ~10% null Average HR
- **Final output**: Unified star-like table `FitnessData_Clean` (27 columns) with full 2024 calendar

## 🛠️ Tech Stack
- **Power Query (M)** in Excel - ETL, custom functions, validation
- **Looker Studio** - KPI & trends, cross-filters, drill-downs, optional metrics, tooltips
- Versioning & docs - Git, GitHub
  
## 🧩 Custom M Functions (full library)
| Function     | Purpose                                           | Business Impact |
|--------------|---------------------------------------------------|-----------------|
| `fxClean`    | Trim, normalize spacing, standardize text case    | Ensures data consistency and reliable joins |
| `fxText`     | Safe text coercion & null-aware operations        | Unifies categorical values like Workout Type |
| `fxDate`     | Parse 8+ date formats into true Date              | Enables accurate merges and time-based grouping |
| `fxNumber`   | Converts mixed numeric formats (dots, commas, "K")   | Fixes parsing and aggregation issues |
| `fxToMinutes`| Normalize durations (e.g., 1.5 h, 70)             | Normalizes time-based fields |
| `fxToHours`  | Minutes → decimal hours for time-based charts     | Enables hour-level aggregations |
| `fxToKm`     | m/mi → km normalization                           | Allows accurate distance comparison |

## 🧪 Data Validation
- Duplicate detection (~5% rows) and removal
- HR null handling via per-type *MedianHR* imputation
- Range checks (HR 50–195, sleep 4–12h), unit sanity checks

## 🔗 Architecture (ETL)
```
Raw Excel (4 sheets)
└─ Cleaning + Standardization (fxClean, fxText, fxDate, fxNumber)
└─ Unit normalization (fxToMinutes, fxToHours, fxToKm)
└─ Join on Date + MedianHR helper + Calendar build
└─ Validation (nulls, ranges, duplicates)
└─ FitnessData_Clean (27 cols) -> Looker Studio
```

## ✨ Dashboard Highlights
- **Pages**: Executive Overview, Workout Analytics, Health & Recovery
- **Interactions**
  - Cross-filtering: selecting any chart element filters related visuals
  - Month & Workout Type selectors + Reset
  - Drill-down: Recovery Timeline by Quarter → Month → Day of Week
  - Optional metrics on Workout Type Comparison bar chart
- **Tooltips**: tooltip-driven insights and detailed metrics for user-friendly storytelling
- **Consistent Color System**: per workout type & intensity tiers (High/Medium/Low)

## 📊 Key Metrics & Fields
- Workout Consistency, Avg Workout Minutes
- Avg/Max HR (bpm), Calories per Minute
- Sleep Duration buckets (Short/Optimal/Long), Resting HR trend
- Next-day performance link: previous-night sleep → next-day calories & minutes

## 📈 Analytical Insights (sample)
- Walking & Running months drive higher steps and active minutes; HIIT yields the highest Calories/min
- Previous-night sleep 6–8h aligns with better next-day energy output, especially for HIIT/Running
- Resting HR remains stable with mild seasonality; no overtraining signal overall

## 🚀 Reproduce

## 📄 License
MIT — see `LICENSE`

## 📬 Connect
**Monika Burnejko** - Data Analyst  
📧 [monikaburnejko@gmail.com](mailto:monikaburnejko@gmail.com)  
💼 [LinkedIn](https://www.linkedin.com/in/monika-burnejko-9301a1357)  
🌐 [Portfolio](https://www.notion.so/monikaburnejko/Data-Analytics-Portfolio-2761bac67ca9807298aee038976f0085?pvs=9)

---
<p align="center">
⭐ If you found this project helpful, please consider giving it a star!
</p>`
