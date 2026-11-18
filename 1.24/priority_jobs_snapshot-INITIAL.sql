ATTACH IF NOT EXISTS 'data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'job_mart.duckdb' AS job_mart;

CREATE OR REPLACE TABLE job_mart.main.priority_jobs_snapshot(
    job_id      INTEGER PRIMARY KEY,
    job_title_short VARCHAR,
    company_name    VARCHAR,
    job_posted_date TIMESTAMP,
    salary_year_avg DOUBLE,
    priority_lvl INTEGER,
    updated_at TIMESTAMP
);
INSERT INTO job_mart.main.priority_jobs_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    tgt.priority_lvl,
    CURRENT_TIMESTAMP
FROM job_mart.stagging.job_flat AS jpf
JOIN job_mart.stagging.Priority_jobs AS tgt
ON jpf.job_title_short = tgt.prefered_role;

SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM job_mart.main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count;
DESCRIBE SELECT * FROM job_mart.main.priority_jobs_snapshot;
