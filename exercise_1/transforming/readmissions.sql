{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 DROP TABLE IF EXISTS my_readmissions;\
CREATE TABLE my_readmissions\
AS SELECT\
 provider_id,\
 measure_id,\
 CAST(score AS FLOAT) AS score,\
 CAST(denominator AS BIGINT) AS sample\
FROM readmissions;\
\
DROP TABLE IF EXISTS my_death_rates;\
CREATE TABLE my_death_rates\
AS SELECT\
 provider_id,\
 round(sum(score*sample)/sum(sample),1) AS death_rate\
FROM my_readmissions\
WHERE measure_id LIKE 'MORT%'\
GROUP BY provider_id;\
\
DROP TABLE IF EXISTS death_rates_zscore;\
CREATE TABLE death_rates_zscore\
AS SELECT\
 x.provider_id as provider_id,\
 (x.death_rate-y.avg)/y.stddev as zscore\
FROM\
 my_death_rates x,\
 (SELECT\
   avg(death_rate) as avg,\
   stddev_samp(death_rate) as stddev\
  FROM my_death_rates) y;\
\
DROP TABLE IF EXISTS my_readmission_rates;\
CREATE TABLE my_readmission_rates\
AS SELECT\
 provider_id,\
 round(sum(score*sample)/sum(sample),1) AS readmission_rate\
FROM my_readmissions\
WHERE measure_id = 'READM_30_HOSP_WIDE'\
GROUP BY provider_id;\
\
DROP TABLE IF EXISTS readmission_rates_zscore;\
CREATE TABLE readmission_rates_zscore\
AS SELECT\
 x.provider_id as provider_id,\
 (x.readmission_rate-y.avg)/y.stddev as zscore\
FROM\
 my_readmission_rates x,\
 (SELECT\
   avg(readmission_rate) as avg,\
   stddev_samp(readmission_rate) as stddev\
  FROM my_readmission_rates) y;\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 DROP TABLE IF EXISTS my_readmissions;\
DROP TABLE IF EXISTS my_death_rates;\
DROP TABLE IF EXISTS my_readmission_rates;\
}