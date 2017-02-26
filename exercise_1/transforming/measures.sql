{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 DROP TABLE IF EXISTS my_measures;\
CREATE TABLE my_measures\
AS SELECT\
 measure_id,\
 measure_name,\
 CAST(CONCAT(SUBSTR(measure_start_date, 7, 4),'-',SUBSTR(measure_start_date, 1, 2),'-',SUBSTR(measure_start_date, 4, 2)) AS date) AS start_date,\
 CAST(CONCAT(SUBSTR(measure_end_date, 7, 4),'-',SUBSTR(measure_end_date, 1, 2),'-',SUBSTR(measure_end_date, 4, 2)) AS date) AS end_date\
FROM measures;}