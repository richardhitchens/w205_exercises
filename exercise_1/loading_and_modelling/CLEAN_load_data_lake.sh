#!/bin/bash

# Save my current working directory
CURR_DIR=$(pwd)

# delete staging directories
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

# Set file names
F1="hospitals.csv"
F2="effective_care.csv"
F3="readmissions.csv"
F4="measure.csv"
F5="survey_responses.csv"
F6="infections.csv"

# remove the files from hdfs
hdfs dfs -rm $F1 /user/w205/hospital_compare/hospitals
hdfs dfs -rm $F2 /user/w205/hospital_compare/effective_care
hdfs dfs -rm $F3 /user/w205/hospital_compare/readmissions
hdfs dfs -rm $F4 /user/w205/hospital_compare/measure
hdfs dfs -rm $F5 /user/w205/hospital_compare/survey_responses
hdfs dfs -rm $F6 /user/w205/hospital_compare/infections

# remove the hdfs directories
hdfs dfs -rmdir /user/w205/hospital_compare/hospitals
hdfs dfs -rmdir /user/w205/hospital_compare/effective_care
hdfs dfs -rmdir /user/w205/hospital_compare/readmissions
hdfs dfs -rmdir /user/w205/hospital_compare/measure
hdfs dfs -rmdir /user/w205/hospital_compare/survey_responses
hdfs dfs -rmdir /user/w205/hospital_compare/infections
hdfs dfs -rmdir /user/w205/hospital_compare

# return to starting directory
cd $CURR_DIR

# graceful exit
exit

