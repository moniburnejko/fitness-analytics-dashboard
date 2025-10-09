# 🧾 Fitness Analytics - Data Dictionary

> **Purpose:** Define and document all columns across the *Fitness Analytics Dashboard* dataset, describing their meaning, data type, origin, and transformation logic.

## 📂 Table Overview
| **Table Name** | **Description** | **Source File** |
|----------------|-----------------|-----------------|
| `WorkoutLogs` | Records of daily workouts (type, duration, calories) | `FitnessData_raw_sample.xlsx` |
| `ActivityTracking` | Daily step count, distance, and active minutes | `FitnessData_raw_sample.xlsx` |
| `SleepMonitoring` | Nightly sleep duration | `FitnessData_raw_sample.xlsx` |
| `HeartRateData` | Daily average, max, and resting heart rate | `FitnessData_raw_sample.xlsx` |
| `FitnessData_Clean` | Unified clean fact table combining all sources | `FitnessData_clean_sample.xlsx` |

## WorkoutLogs (RAW)
| **Column Name** | **Example** | **Description** | **Transformation Notes** |
|-----------------|-------------|-----------------|--------------------------|
| Date | Jul 30 2024 | Workout session date | Unified via `fxDate` |
| Workout Type | hiit session | Activity type | Cleaned via `fxText`; nulls retained for missing sessions |
| Workout Duration (min) |  1 h 17 min | Session length | Converted to minutes via `fxToMinutes` |
| Calories Burned | ~265 kcal  | Total calories burned per session | Cleaned via `fxNumber` |

## ActivityTracking (RAW)
| **Column Name** | **Example** | **Description** | **Transformation Notes** |
|-----------------|--------------|-----------------|--------------------------|
| Date | 2024.02.13 | Day of recorded activity | Unified via `fxDate` |
| Steps |  3.0K | Number of steps recorded per day | Converted to numeric; normalized K notation |
| Distance (km) | 5,1 mi | Distance walked/run | Converted to kilometers via `fxToKM` |
| Active Minutes | 0.7 h  | Total active minutes per day | Normalized via `fxToMinutes` |

## SleepMonitoring (RAW)
| **Column Name** | **Example** | **Description** | **Transformation Notes** |
|-----------------|-------------|-----------------|--------------------------|
| Date | 22/02/2024 | Sleep record date | Unified via `fxDate`|
| Sleep_Hours |  7 h 1 min  | Total hours slept | Cleaned via `fxNumber` |

## HeartRateData (RAW)
| **Column Name** | **Example** | **Description** | **Transformation Notes** |
|-----------------|-------------|-----------------|--------------------------|
| Date | 20 May 2024 | Heart rate measurement date | Unified via `fxDate` |
| Average_HR |   138bpm  | Average heart rate during workout | Cleaned via `fxNumber`; missing values filled by median |
| Max_HR | 166 BPM  | Maximum recorded heart rate | Cleaned via `fxNumber` |
| Resting_HR |   57 | Resting heart rate for the day | Cleaned via `fxNumber` |


## FitnessData_Clean (Unified Table)
| **Column Name** | **Data Type** | **Description** | **Example Values** | **Derived From** |
|------------------|----------|--------------|------------------|--------------|
| Date | Date | ISO format date (YYYY-MM-DD) | 024-03-15 | All tables (joined) |
| DayOfWeek | Text | Day name | Monday | Derived from Date | 
| DayOfWeek_Number | Integer | Day number (1=Monday) | 1 | Derived from Date |
| Month_Name | Text | Month name | January | Derived from Date| 
| Month_Number | Integer | Month number | 1 | Derived from Date| 
| Month_StartDate | Date | First day of month | 2024-01-01 | Derived from Date | 
| YearMonth | Text | Year-Month format | 2024-01 | Derived from Date | 
| Quarter | Text | Quarter designation | Q1 | Derived from Date | 
| Workout_Type | Text | Type of workout | Running | From WorkoutLogs |
| Workout_Intensity | Text | Calculated intensity level | High | Derived from HR data |
| Workout_Duration_min | Integer | Duration in minutes | 45 | From WorkoutLogs | 
| Calories_Burned | Integer | Calories burned | 350 | From WorkoutLogs |
| Calories_per_Minute | Decimal | Calculated burn rate | 7.78 | Derived (Calories/Duration) |
| Active_Minutes | Integer | Total active minutes | 90 | From ActivityTracking |
| Average_HR | Integer | Average heart rate | 135 | From HeartRateData |
| Average_HR_Imputed | Boolean | Imputation flag | TRUE/FALSE | HeartRateData + MedianHR helper table |
| Max_HR | Integer | Maximum heart rate | 165 | From HeartRateData |
| Resting_HR | Integer | Resting heart rate | 62 | From HeartRateData |
| Distance_km | Decimal | Distance in kilometers | 5.5 | From ActivityTracking |
| Steps | Integer | Step count | 8500 | From ActivityTracking |
| Steps_Goal_% | Decimal | Percentage of 10K goal | 85.0 | Derived (Steps / 10K) |
| Steps_Goal_Reached | Boolean | Goal achievement flag | TRUE/FALSE | Derived from Steps_Goal_% |
| Sleep_Hours | Decimal | Hours of sleep | 7.5 | From SleepMonitoring |
| Sleep_PreviousNight | Decimal | Previous night's sleep hours | 6.5 | Derived from Sleep_Hours (offset -1 day by Date) |
| Sleep_Duration | Text | Sleep category | Optimal(6-8h) | Derived from Sleep_Hours |
| Data_Completeness | Text | Data quality flag | Complete/Incomplete | FitnessData_Clean (post-validation rules) |
| Data_Validation_Flag | Text | Validation status | Valid/No_data | FitnessData_Clean (post-validation rules) |

📅 *Last updated: October 2025*  
👩‍💻 *Author: Monika Burnejko*
