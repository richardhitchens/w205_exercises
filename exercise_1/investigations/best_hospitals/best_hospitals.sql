
SELECT
 e.provider_id,
 e.z_care,
 e.z_death,
 e.z_readmit,
 e.z_infection,
 e.zscore,
 f.hospital_name
FROM
 (SELECT
   c.provider_id AS provider_id,
   round(d.z_care,3) AS z_care,
   round(d.z_death,3) AS z_death,
   round(d.z_readmit,3) AS z_readmit,
   round(d.z_infection,3) AS z_infection,
   round(d.zscore,3) AS zscore
  FROM
   (SELECT
     a.provider_id AS provider_id
    FROM
     my_effective_care_total a,
     (select percentile(total, 0.1) as min_sample from my_effective_care_total) b
    WHERE
     a.total > b.min_sample) c
  LEFT OUTER JOIN
   my_quality_zscores d
  ON
   (c.provider_id = d.provider_id)
  WHERE
   zscore IS NOT NULL
  ORDER BY
   zscore ASC
  LIMIT 10) e
LEFT OUTER JOIN
 my_hospitals f
ON
 (e.provider_id = f.provider_id);