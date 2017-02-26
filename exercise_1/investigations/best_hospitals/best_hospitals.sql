SELECT
 a.provider_id,
 a.hospital_name,
 round(b.zscore,3)
FROM
 my_hospitals a
LEFT OUTER JOIN
  quality_zscore b
ON
 (a.provider_id = b.provider_id)
WHERE
 b.zscore IS NOT NULL
ORDER BY
 b.zscore ASC
LIMIT 10;