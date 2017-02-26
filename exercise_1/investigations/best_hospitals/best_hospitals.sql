
SELECT
 g.provider_id,
 round(h.z_care,3),
 round(h.z_death,3),
 round(h.z_readmit,3),
 round(h.z_infection,3),
 g.zscore,
 g.hospital_name
FROM
 (SELECT
  e.provider_id AS provider_id,
  f.hospital_name AS hospital_name,
  e.zscore AS zscore
 FROM
  (SELECT
    c.provider_id AS provider_id,
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
    quality_zscore d
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
  (e.provider_id = f.provider_id)) g
LEFT OUTER JOIN
 quality_zscores h
ON
 (g.provider_id = h.provider_id);