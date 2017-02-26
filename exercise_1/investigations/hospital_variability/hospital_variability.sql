SELECT
 a.measure_id,
 b.measure_name,
 a.stddev
FROM
 (SELECT
   measure_id,
   round(stddev_samp(score)/avg(score),3) as stddev
  FROM
   my_effective_care
  GROUP BY
   measure_id
  ORDER BY
   stddev DESC) a
LEFT OUTER JOIN
 my_measures b
ON
 (a.measure_id = b.measure_id)
LIMIT 10;