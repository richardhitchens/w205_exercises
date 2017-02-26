{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 DROP TABLE IF EXISTS my_infections;\
CREATE TABLE my_infections\
AS SELECT\
 provider_id,\
 measure_id,\
 CAST(score AS FLOAT) AS score\
FROM infections;\
\
DROP TABLE IF EXISTS my_infection_rates;\
CREATE TABLE my_infection_rates \
AS SELECT\
 a.provider_id,\
 a.numerator / b.denominator AS score\
FROM\
(SELECT\
 provider_id,\
 sum(score) AS numerator\
FROM my_infections\
WHERE SUBSTR(measure_id,7) = 'NUMERATOR'\
GROUP BY provider_id) a\
LEFT OUTER JOIN\
(SELECT\
 provider_id,\
 sum(score) AS denominator\
FROM my_infections\
WHERE SUBSTR(measure_id,7) = 'ELIGCASES'\
GROUP BY provider_id) b\
ON (a.provider_id = b.provider_id);\
\
DROP TABLE IF EXISTS infection_rates_zscore;\
CREATE TABLE infection_rates_zscore\
AS SELECT\
 x.provider_id as provider_id,\
 (x.score-y.avg)/y.stddev as zscore\
FROM\
 my_infection_rates x,\
 (SELECT\
   avg(score) as avg,\
   stddev_samp(score) as stddev\
  FROM my_infection_rates) y;\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 DROP TABLE IF EXISTS my_infections;\
DROP TABLE IF EXISTS my_infection_rates;\
}