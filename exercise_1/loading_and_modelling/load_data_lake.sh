#!/bin/bash

# Save my current working directory
CURR_DIR=$(pwd)

# create staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to exercise_1 staging directory
cd ~/staging/exercise_1

# get file from data.medicare.org
DATA_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$DATA_URL" -O medicare_data.zip

# unzip the file
unzip medicare_data.zip

# Set old file names
OF1="Hospital General Information.csv"
OF2="Timely and Effective Care - Hospital.csv"
OF3="Readmissions and Deaths - Hospital.csv"
OF4="Measure Dates.csv"
OF5="hvbp_hcahps_11_10_2016.csv"
OF6="Healthcare Associated Infections - Hospital.csv"

# Set new file names
NF1="hospitals.csv"
NF2="effective_care.csv"
NF3="readmissions.csv"
NF4="measure.csv"
NF5="survey_responses.csv"
NF6="infections.csv"

# remove first line of files and rename
tail -n +2 "$OF1" >$NF1
tail -n +2 "$OF2" >$NF2
tail -n +2 "$OF3" >$NF3
tail -n +2 "$OF4" >$NF4
tail -n +2 "$OF5" >$NF5
tail -n +2 "$OF6" >$NF6

# create our hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/measure
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -mkdir /user/w205/hospital_compare/infections

# copy the files to hdfs
hdfs dfs -put $NF1 /user/w205/hospital_compare/hospitals
hdfs dfs -put $NF2 /user/w205/hospital_compare/effective_care
hdfs dfs -put $NF3 /user/w205/hospital_compare/readmissions
hdfs dfs -put $NF4 /user/w205/hospital_compare/measure
hdfs dfs -put $NF5 /user/w205/hospital_compare/survey_responses
hdfs dfs -put $NF6 /user/w205/hospital_compare/infections

# return to starting directory
cd $CURR_DIR

# graceful exit
exit


