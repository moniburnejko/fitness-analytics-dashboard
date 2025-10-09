# 🧾 Fitness Analytics Data Samples

> **Purpose:** Provide a representative subset of the dataset used in the *Fitness Analytics Dashboard* project for educational and portfolio demonstration purposes.

## Included Files
| **File** | **Description** | **Rows** |
|-----------|-----------------|-----------|
| `FitnessData_raw_sample.xlsx` | Raw input data containing uncleaned records, mixed formats, and duplicates | 25 |
| `FitnessData_clean_sample.xlsx` | Final cleaned and standardized dataset after Power Query ETL processing | 25 |

## Dataset Overview
Files contain four logically related sheets:
1. `WorkoutLogs` – physical activity records (type, duration, calories)
2. `ActivityTracking` – daily steps, distance, and active minutes
3. `SleepMonitoring` – sleep duration
4. `HeartRateData` – average, max, and resting HR data

All sheets are joined by the **`Date`** column.  
The clean version represents the **final fact table** used in Looker Studio.

## Raw Data Characteristics
The raw data was intentionally designed to simulate **real-world ETL challenges**, including:

| **Issue Type** | **Example** | **Resolution** |
|----------------|-------------|----------------|
| Inconsistent date formats | `2024/01/03`, `03.01.2024`, `Jan 3 2024` | Standardized via `fxDate` |
| Mixed numeric units | `1.5 h`, `90 min`, `1,2h` | Converted via `fxToMinutes` / `fxToHours` |
| Mixed distance formats | `5.6 km`, `5600 m`, `3.5 mi` | Standardized via `fxToKM` |
| Extra spaces and casing issues | `" Walking "`, `"YOGA"`, `"hiit "` | Cleaned via `fxText` |
| Nulls and duplicates | Blank or repeated records | Removed via `fxClean` |
| Missing HR values | `null` in `Average_HR` and `Max_HR` | Imputed using median per Workout_Type |

## Clean Data Improvements
| **Transformation Step** | **Operation** | **Result** |
|--------------------------|---------------|-------------|
| Trim & Text Cleaning | Removed redundant spaces and inconsistent casing | Uniform text values |
| Date Standardization | Applied `fxDate` function to all date columns | Unified format `YYYY-MM-DD` |
| Unit Normalization | Converted all time and distance to consistent units | Minutes & Kilometers |
| Logical Consistency | Matched calories, HR, and steps to workout duration | Data coherence |
| Null Handling | Filled missing HR values with activity-type median | Improved completeness |
| Deduplication | Removed 5% exact duplicates | 100% unique daily records |

## Column Summary (Clean Version)
| **Category** | **Column Name** | **Type** | **Description** |
|---------------|----------------|-----------|------------------|
| Date & Time | `Date`, `DayOfWeek`, `DayOfWeek_Number`, `Month_Name`, `Month_Number`, `Month_StartDate`, `YearMonth`, `Quarter`| Date/Text | Daily granularity, extracted fields |
| Workout | `Workout_Type`, `Workout_Duration_(min)`, `Calories_Burned` | Text/Number | Training session details |
| Activity | `Steps`, `Distance_km`, `Active_Minutes` | Number/Text | Movement and activity summary |
| Sleep | `Sleep_Hours` | Number/Text | Sleep metrics for recovery analysis |
| Heart Rate | `Average_HR`, `Max_HR`, `Resting_HR` | Number | Physiological response data |
| Derived Fields | `Workout_Intensity`, `Calories_per_Minute`, `Steps_Goal_%`, `Sleep_Duration`, `Sleep_Previous_Night`, `Workout_Consistency`, `Recovery_Category` | Calculated | Created in Power Query / Looker Studio |

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
- Demonstrating Power Query transformation workflows  
- Testing ETL functions (`fxDate`, `fxClean`, etc.)  
- Rebuilding the *Fitness Analytics Dashboard* in Looker Studio  

## Data License
> All data in this folder is **synthetically generated** and contains **no personal or real-world information**.  
It is shared under the **MIT License** for educational and portfolio purposes.

📅 *Last updated: October 2025*  
👩‍💻 *Author: Monika Burnejko*
