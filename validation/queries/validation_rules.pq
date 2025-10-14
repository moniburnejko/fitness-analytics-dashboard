// query: validation_rules
// source: predefined rule table (manual input)
// purpose: define all validation rules applied to fitness_data_final, including rule type, parameters, and severity level
// notes: used dynamically by fitness_data_validation to generate rule_* columns for each check
// author: monika burnejko | 2025

let
    // define schema for the validation rules table
    rules_schema=type table[rule_name=text,target_column=text,rule_type=text,param1=any,param2=any,severity=text],

    // enumerate all rule rows used by the validation engine
    rules_rows={
        {"req_date_not_null","date","not_null",null,null,"ERROR"},
        {"req_workout_type_if_present","workout_type","in_set",{"Walking","Running","Cycling","Swimming","Yoga","HIIT","Strength","Tennis"},null,"WARN"},
        {"range_average_hr_70_150","average_hr","between_inc",70,150,"ERROR"},
        {"range_max_hr_110_195","max_hr","between_inc",110,195,"ERROR"},
        {"range_resting_hr_50_70","resting_hr","between_inc",50,70,"WARN"},
        {"range_sleep_3_12h","sleep_hours","between_inc",3,12,"ERROR"},
        {"range_cal_per_min_le_20","calories_per_minute","max_inc",20,null,"ERROR"},
        {"rel_max_ge_avg_hr","max_hr","rel_compare","average_hr","MAX_GE","ERROR"}},

    // build the typed rules table
    rules=#table(rules_schema,rules_rows)
in
    rules