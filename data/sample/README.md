# 🧾 Fitness Analytics Data Samples

> **Purpose:** Provide a representative subset of the dataset used in the *Fitness Analytics Dashboard* project for educational and portfolio demonstration purposes.

## Included Files
| **File** | **Description** | **Sheets / Tables** | **Rows** |
|----------|-----------------|---------------------|----------|
| `FitnessData_raw_sample.xlsx` | Original uncleaned data containing raw inputs, mixed formats, and inconsistencies | 4 sheets (WorkoutLogs, ActivityTracking, SleepMonitoring, HeartRateData) | 25 |
| `FitnessData_clean_sample.xlsx` | Cleaned and standardized version with consistent formatting and validated numeric types (no calculated fields or merges) | 4 sheets (same as above) | 25 |
| `FitnessData_final_sample.xlsx` | Fully processed analytical dataset - merged into a single fact table with calculated and derived columns | 1 sheet (`FitnessData_Clean`) | 25 |

## Stage Comparison
| **Stage** | **Description** | **Operations Performed** | **Example Improvements** |
|------------|----------------|---------------------------|---------------------------|
| **RAW** | Direct export from source tracking systems | Inconsistent date formats, unit mismatches, nulls, duplicates | `03/04/24`, `1.5 h`, `6 h 40 min`, `8400 m`, `127 bpm` |
| **CLEAN** | Post-ETL cleaning and normalization | Trimmed text, standardized units and date formats, removed duplicates | `2024-03-04`, `90 min`, `6.7 h`, `8.4 km`, `127` |
| **FINAL** | Merged analytical dataset with derived metrics | Combined all sources by `Date`, added KPIs and flags | `Calories_per_Minute`, `Workout_Intensity`, `Sleep_Previous_Night`, `Data_Validation_Flag` |

## Key Differences Between Versions
| Aspect | RAW | CLEAN | FINAL |
|--------|----------|----------|----------|
| **Sheets** | 4 separate sources | 4 cleaned sources | 1 unified dataset |
| **Join Key** | None | None | Date |
| **Null Values** | Randomly present in multiple columns | Reduced - most structural nulls cleaned | Reintroduced by calendar expansion (days without source data) and partially imputed (Average_HR only) |
| **Units** | Mixed (min/h, km/m/mi) | Fully standardized | Fully standardized |
| **Date Formats** | 6 mixed formats | Unified to ISO (YYYY-MM-DD) | ISO (YYYY-MM-DD) |
| **Text Normalization** | Inconsistent case & spacing | Trimmed, normalized case | Consistent |
| **Derived Columns** | None | None | Added (Calories_per_Minute, Workout_Intensity, Steps_Goal_%, Steps_Goal_Reached, Sleep_PreviousNight, etc.) |
| **Validation Flags** | None | None | Complete QA validation (Data_Completeness, Data_Validation_Flag) |
| **Completeness** | Partial | Partial | Full calendar coverage (365 days) with structural nulls preserved |
| **Analytical Readiness** | Low - inconsistent | Medium - clean but fragmented | High - merged, validated, and feature-enriched |

## Data Lineage Summary
**RAW → CLEAN**
- fxClean → trims, deduplicates, handles nulls
- fxDate → standardizes 6+ date formats
- fxNumber → fixes localized decimal separators
- fxToMinutes / fxToKM / fxToHours → converts inconsistent units
- fxText → normalizes case and spacing

**CLEAN → FINAL**
- Joined by Date across all tables
- Added a generated calendar covering all days of 2024
- Introduced temporal grouping fields:
  - DayOfWeek, DayofWeek_Number
  - Month_Name, Month_Number
  - Month_StartDate, YearMonth
  - Quarter
- Median HR imputation for missing values
- Added derived metrics:
  - Calories_per_Minute
  - Workout_Intensity
  - Steps_Goal_% & Steps_Goal_Reached
  - Sleep_Previous_Night
  - Data_Completeness & Validation_Flag

## Column Summary (Final Version)
| **Category** | **Column Name** | **Type** | **Description** |
|---------------|----------------|-----------|------------------|
| Date & Time | `Date`, `DayOfWeek`, `DayOfWeek_Number`, `Month_Name`, `Month_Number`, `Month_StartDate`, `YearMonth`, `Quarter`| Date/Text/Number | Daily granularity, extracted fields |
| Workout | `Workout_Type`, `Workout_Duration_(min)`, `Calories_Burned` | Text/Number | Training session details |
| Activity | `Steps`, `Distance_km`, `Active_Minutes` | Number | Movement and activity summary |
| Sleep | `Sleep_Hours` | Number| Sleep metrics for recovery analysis |
| Heart Rate | `Average_HR`, `Max_HR`, `Resting_HR` | Number | Physiological response data |
| Derived Fields | `Workout_Intensity`, `Calories_per_Minute`, `Steps_Goal_%`, `Sleep_Duration`, `Sleep_Previous_Night`| Calculated | Calculated metrics and analytical enrichments |
| QA Fields | `Data_Completeness`, `Data_Validation_Flag`, `Average_HR_Imputed` | Text/Boolean | Data quality, completeness, and validation controls | 

## Related ETL Functions
All cleaning operations were performed using custom Power Query functions:
| **Function** | **Purpose** |
|---------------|-------------|
| `fxClean` | Applies trimming, null handling, and deduplication |
| `fxText` | Standardizes text casing and removes invalid characters |
| `fxDate` | Automatically parses any date format |
| `fxNumber` | Converts localized decimal separators |
| `fxToMinutes` | Converts workout duration to minutes |
| `fxToHours` | Converts minutes to hours when needed |
| `fxToKM` | Converts distance values to kilometers |

➡️ Full code for these functions is available in:  
[`/etl/functions/`](../../etl/functions/)

## Usage
These sample datasets are designed for:
- Reproducing Power Query ETL pipeline examples
- Testing custom M functions (fxDate, fxClean, etc.)
- Demonstrating data transformation stages visually
- Rebuilding the Fitness Analytics Dashboard in Looker Studio

## Data License
All data in this folder is synthetically generated and contains no personal or real-world information.
It is shared under the MIT License for educational and portfolio use.

📅 *Last updated: October 2025*  
👩‍💻 *Author: Monika Burnejko*


