DROP TABLE IF EXISTS my_measures;
CREATE TABLE my_measures
AS SELECT
 measure_id,
 measure_name,
 CAST(CONCAT(SUBSTR(measure_start_date, 7, 4),'-',SUBSTR(measure_start_date, 1, 2),'-',SUBSTR(measure_start_date, 4, 2)) AS date) AS start_date,
 CAST(CONCAT(SUBSTR(measure_end_date, 7, 4),'-',SUBSTR(measure_end_date, 1, 2),'-',SUBSTR(measure_end_date, 4, 2)) AS date) AS end_date
FROM measures;