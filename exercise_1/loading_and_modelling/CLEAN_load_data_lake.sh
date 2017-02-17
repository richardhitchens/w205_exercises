#!/bin/bash

# Save my current working directory
CURR_DIR=$(pwd)

# delete staging directories
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

# remove the files from hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions/readmissions.csv
hdfs dfs -rm /user/w205/hospital_compare/measure/measure.csv
hdfs dfs -rm /user/w205/hospital_compare/survey_responses/survey_respones.csv
hdfs dfs -rm /user/w205/hospital_compare/infections/infections.csv

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

