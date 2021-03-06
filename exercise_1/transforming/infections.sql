DROP TABLE IF EXISTS my_infections;
CREATE TABLE my_infections
AS SELECT
 provider_id,
 measure_id,
 CAST(score AS FLOAT) AS score
FROM infections;

DROP TABLE IF EXISTS my_infection_rates;
CREATE TABLE my_infection_rates 
AS SELECT
 a.provider_id,
 a.numerator / b.denominator AS score
FROM
(SELECT
 provider_id,
 sum(score) AS numerator
FROM my_infections
WHERE SUBSTR(measure_id,7) = 'NUMERATOR'
GROUP BY provider_id) a
LEFT OUTER JOIN
(SELECT
 provider_id,
 sum(score) AS denominator
FROM my_infections
WHERE SUBSTR(measure_id,7) = 'ELIGCASES'
GROUP BY provider_id) b
ON (a.provider_id = b.provider_id);

DROP TABLE IF EXISTS infection_rates_zscore;
CREATE TABLE infection_rates_zscore
AS SELECT
 x.provider_id as provider_id,
 (x.score-y.avg)/y.stddev as zscore
FROM
 my_infection_rates x,
 (SELECT
   avg(score) as avg,
   stddev_samp(score) as stddev
  FROM my_infection_rates) y;

DROP TABLE IF EXISTS my_infections;
DROP TABLE IF EXISTS my_infection_rates;
