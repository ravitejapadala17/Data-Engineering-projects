--Step 3: Mart — Create flat mart table
DROP SCHEMA if EXISTS flat_mart CASCADE;
CREATE SCHEMA flat_mart;
SELECT '*** Loading job postings flat data ***' AS Info;
CREATE OR REPLACE TABLE flat_mart.job_postings AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.company_id,
    cd.name AS company_name,
    ARRAY_AGG(
        STRUCT_PACK(
            skill := sd.skills,
            types := sd.type
        )
    ) AS skill_and_type
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
LEFT JOIN skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim as sd
ON sjd.skill_id = sd.skill_id
GROUP BY ALL
;

SELECT 'job postings flat' AS table_name, COUNT(*) AS record_count FROM flat_mart.job_postings;

SELECT '*** job postings flat Sample ***' AS info;
SELECT * FROM flat_mart.job_postings LIMIT 5;