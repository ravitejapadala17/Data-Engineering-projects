ATTACH IF NOT EXISTS 'data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'job_mart.duckdb' AS job_mart;

CREATE OR REPLACE TEMP TABLE src_priorty_jobs AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    tgt.priority_lvl,
    CURRENT_TIMESTAMP AS updated_at
FROM job_mart.stagging.job_flat AS jpf
JOIN job_mart.stagging.Priority_jobs AS tgt
ON jpf.job_title_short = tgt.prefered_role;
/*
--Update query
UPDATE job_mart.priority_jobs_snapshot AS tgt
SET priority_lvl = src.priority_lvl,
    updated_at = src.updated_at
FROM src_priorty_jobs as src
WHERE src.job_id = tgt.job_id
    AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl;
--Insert query
INSERT INTO job_mart.priority_jobs_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
SELECT
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    CURRENT_TIMESTAMP
FROM src_priorty_jobs AS src
WHERE NOT EXISTS(
    SELECT 1 FROM job_mart.main.priority_jobs_snapshot AS tgt
    WHERE tgt.job_id=src.job_id
);
--Delete Query
DELETE FROM job_mart.priority_jobs_snapshot AS tgt
WHERE NOT EXISTS(
    SELECT 1 FROM src_priorty_jobs AS src WHERE tgt.job_id= src.job_id
);
*/
--MERGE 
MERGE INTO job_mart.main.priority_jobs_snapshot as tgt
USING src_priorty_jobs AS src
ON tgt.job_id = src.job_id
WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
    UPDATE SET priority_lvl = src.priority_lvl,
    updated_at = src.updated_at
WHEN NOT MATCHED THEN
    INSERT (
        job_id,
        job_title_short,
        company_name,
        job_posted_date,
        salary_year_avg,
        priority_lvl,
        updated_at
    )
    VALUES(
        src.job_id,
        src.job_title_short,
        src.company_name,
        src.job_posted_date,
        src.salary_year_avg,
        src.priority_lvl,
        src.updated_at
    )
WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM job_mart.main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count;