DROP TABLE IF EXISTS quality_zscores;
CREATE TABLE quality_zscores
AS SELECT
 f.provider_id as provider_id,
 f.ew_avg as z_care,
 e.z_infection,
 e.z_death,
 e.z_readmit
FROM
 effective_care_zscore f
LEFT OUTER JOIN
 (SELECT
   d.provider_id as provider_id,
   d.zscore as z_infection,
   c.z_death,
   c.z_readmit
  FROM
   infection_rates_zscore d 
  LEFT OUTER JOIN
   (SELECT
     a.provider_id,
     a.zscore as z_death,
     b.zscore as z_readmit
    FROM
     death_rates_zscore a
    LEFT OUTER JOIN
     readmission_rates_zscore b
    ON
     (a.provider_id = b.provider_id)) c
  ON
   (d.provider_id = c.provider_id)) e
 ON
  (f.provider_id = e.provider_id);

DROP TABLE IF EXISTS my_quality_zscores;
CREATE TABLE my_quality_zscores
AS SELECT
 provider_id,
 z_care,
 z_infection,
 z_death,
 z_readmit,
 0.5*z_care + 0.2*z_infection + 0.1*z_death +0.2*z_readmit AS zscore
FROM
 quality_zscores;


DROP TABLE IF EXISTS quality_zscores;
DROP TABLE IF EXISTS effective_care_zscore;
DROP TABLE IF EXISTS infection_rates_zscore;
DROP TABLE IF EXISTS readmission_rates_zscore;
DROP TABLE IF EXISTS death_rates_zscore;
