SELECT
 a.state,
 round(avg(b.zscore),3) as zscore
FROM
 my_hospitals a
LEFT OUTER JOIN
  my_quality_zscores b
ON
 (a.provider_id = b.provider_id)
WHERE
 zscore IS NOT NULL
GROUP BY
 a.state
ORDER BY
 zscore ASC
LIMIT 10;