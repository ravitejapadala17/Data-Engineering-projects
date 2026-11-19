ATTACH IF NOT EXISTS 'DataBase\data_jobs.duckdb' AS data_jobs;
ATTACH IF NOT EXISTS 'DataBase\job_mart.duckdb' AS job_mart;
CREATE OR REPLACE TABLE job_mart.stagging.Priority_jobs (
    role_id INTEGER PRIMARY KEY,
    prefered_role VARCHAR,
    priority_lvl INTEGER
);
INSERT INTO job_mart.stagging.Priority_jobs  VALUES
    (1,'Data Engineer', 1),
    (2,'Data Analyst', 2),
    (3,'Data Scientist', 3),
    -- (4,'Machine Learning Engineer', 1)
    ;
SELECT * FROM job_mart.stagging.Priority_jobs;