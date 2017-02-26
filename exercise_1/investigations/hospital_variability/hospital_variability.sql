{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 SELECT\
 a.measure_id,\
 b.measure_name,\
 a.stddev\
FROM\
 (SELECT\
   measure_id,\
   round(stddev_samp(score)/avg(score),3) as stddev\
  FROM\
   my_effective_care\
  GROUP BY\
   measure_id\
  ORDER BY\
   stddev DESC) a\
LEFT OUTER JOIN\
 my_measures b\
ON\
 (a.measure_id = b.measure_id)\
LIMIT 10;}