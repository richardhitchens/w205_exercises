DROP TABLE IF EXISTS my_survey_ratings;
CREATE TABLE my_survey_ratings
AS SELECT
 t.provider_id,
 t.base + t.consistency AS rating
FROM
(SELECT
 provider_id,
 CAST(hcahps_base_score AS FLOAT) AS base,
 CAST(hcahps_consistency_score AS FLOAT) AS consistency
 FROM survey_responses) AS t;
