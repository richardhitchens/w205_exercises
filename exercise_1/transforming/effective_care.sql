DROP TABLE IF EXISTS my_effective_care;
CREATE TABLE my_effective_care
AS SELECT
 *
FROM (
SELECT
 provider_id,
 measure_id,
 CAST(100-score AS FLOAT) AS score,
 CAST(sample AS BIGINT) AS sample
FROM effective_care
WHERE measure_id
IN ('OP_2', 'OP_4', 'OP_23', 'OP_29', 'OP_30', 'OP_31', 'STK_4', 'VTE_5')
UNION ALL
SELECT
 provider_id,
 measure_id,
 CAST(score AS FLOAT) AS score,
 CAST(sample AS BIGINT) AS sample
FROM effective_care
WHERE measure_id
IN ('ED_1b', 'ED_2b', 'OP_1', 'OP_3b', 'OP_5', 'OP_18b', 'OP_20', 'OP_21', 'OP_22', 'PC_01', 'VTE_6')
) U
ORDER BY provider_id, measure_id ASC;

DROP TABLE IF EXISTS my_effective_care_avg_sttdev;
CREATE TABLE my_effective_care_avg_sttdev
AS SELECT
 measure_id,
 round(avg(score),4) as avg,
 round(stddev(score),4) as stddev
FROM my_effective_care
GROUP BY measure_id;

DROP TABLE IF EXISTS my_effective_care_total;
CREATE TABLE my_effective_care_total
AS SELECT
 provider_id,
 sum(sample) as total
FROM my_effective_care
GROUP BY provider_id;

DROP TABLE IF EXISTS my_effective_care_all;
CREATE TABLE my_effective_care_all
AS SELECT
 a.*,
 b.avg as avg,
 b.stddev as stddev
FROM
 (SELECT
   x.*,
   y.total as total
  FROM
   my_effective_care x
  LEFT OUTER JOIN
   my_effective_care_total y
  ON
   (x.provider_id = y.provider_id)
  ) AS a
LEFT OUTER JOIN
 my_effective_care_avg_sttdev b
ON
 (a.measure_id = b.measure_id);

DROP TABLE IF EXISTS my_effective_care_zscore;
CREATE TABLE my_effective_care_zscore
AS SELECT
 provider_id,
 measure_id,
 (score - avg) / stddev AS zscore,
 sample / total AS weight
FROM my_effective_care_all;

DROP TABLE IF EXISTS effective_care_zscore;
CREATE TABLE effective_care_zscore
AS SELECT
 provider_id,
 avg(zscore) AS ew_avg,
 avg(zscore*weight) AS w_avg
FROM
 my_effective_care_zscore
GROUP BY
 provider_id;

DROP TABLE IF EXISTS my_effective_care_avg_sttdev;
DROP TABLE IF EXISTS my_effective_care_all;
DROP TABLE IF EXISTS my_effective_care_zscore;
