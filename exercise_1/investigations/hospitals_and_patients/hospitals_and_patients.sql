SELECT
 corr(c.zscore,c.rating) as corr
FROM
 (SELECT
   a.provider_id as provider_id,
   a.zscore as zscore,
   b.rating as rating
  FROM
   my_quality_zscores a
  LEFT OUTER JOIN
   my_survey_ratings b
  ON
   (a.provider_id = b.provider_id)) c;

SELECT
 corr(a.cv,b.rating) as corr
FROM
 (SELECT
  provider_id,
  round(stddev_samp(score)/avg(score),3) as cv
 FROM
  my_effective_care
 GROUP BY
  provider_id) a
LEFT OUTER JOIN
  my_survey_ratings b
ON
  (a.provider_id = b.provider_id);