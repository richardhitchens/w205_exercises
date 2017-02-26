{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 DROP TABLE IF EXISTS quality_zscores;\
CREATE TABLE quality_zscores\
AS SELECT\
 f.provider_id as provider_id,\
 f.ew_avg as z_care,\
 e.z_infection,\
 e.z_death,\
 e.z_readmit\
FROM\
 effective_care_zscore f\
LEFT OUTER JOIN\
 (SELECT\
   d.provider_id as provider_id,\
   d.zscore as z_infection,\
   c.z_death,\
   c.z_readmit\
  FROM\
   infection_rates_zscore d \
  LEFT OUTER JOIN\
   (SELECT\
     a.provider_id,\
     a.zscore as z_death,\
     b.zscore as z_readmit\
    FROM\
     death_rates_zscore a\
    LEFT OUTER JOIN\
     readmission_rates_zscore b\
    ON\
     (a.provider_id = b.provider_id)) c\
  ON\
   (d.provider_id = c.provider_id)) e\
 ON\
  (f.provider_id = e.provider_id);\
\
DROP TABLE IF EXISTS quality_zscore;\
CREATE TABLE quality_zscore\
AS SELECT\
 provider_id,\
 0.5*z_care + 0.2*z_infection + 0.1*z_death +0.2*z_readmit AS zscore\
FROM\
 quality_zscores;\
\
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 DROP TABLE IF EXISTS effective_care_zscore;\
DROP TABLE IF EXISTS infection_rates_zscore;\
DROP TABLE IF EXISTS readmission_rates_zscore;\
DROP TABLE IF EXISTS death_rates_zscore;\
}