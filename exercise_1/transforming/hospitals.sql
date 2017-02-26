DROP TABLE IF EXISTS my_hospitals;
CREATE TABLE my_hospitals
AS SELECT
 provider_id,
 hospital_name,
 state,
 hospital_type,
 hospital_ownership,
 emergency_services
FROM hospitals;