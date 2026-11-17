-- Active: 1785671854282@@127.0.0.1@3306
-- Active: 1785671854282@@127.0.0.1@3306
DESCRIBE job_postings_fact;
SELECT 
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg != 0;

SELECT 
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL 
    AND salary_year_avg%2 = 0;

CREATE TABLE company_dim AS SELECT * FROM read_csv_auto('company_dim.csv');
CREATE TABLE job_postings_fact AS SELECT * FROM read_csv_auto('job_postings_fact.csv');
CREATE TABLE skills_dim AS SELECT * FROM read_csv_auto('skills_dim.csv');
CREATE TABLE skills_job_dim AS SELECT * FROM read_csv_auto('skills_job_dim.csv');

DESCRIBE company_dim;
DESCRIBE job_postings_fact;
DESCRIBE skills_dim;

DESCRIBE 
SELECT * FROM data_jobs.job_postings_fact;

CREATE TABLE data_jobs.job_postings_fact_new (
    job_id BIGINT PRIMARY KEY,
    company_id BIGINT,
    job_title_short VARCHAR,
    job_title VARCHAR,
    job_location VARCHAR,
    job_via VARCHAR,
    job_schedule_type VARCHAR,
    job_work_from_home BOOLEAN,
    search_location VARCHAR,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country VARCHAR,
    salary_rate VARCHAR,
    salary_year_avg DOUBLE,
    salary_hour_avg DOUBLE
);
INSERT INTO data_jobs.job_postings_fact_new (
    job_id,
company_id,
job_title_short,
job_title,
job_location,
job_via,
job_schedule_type,
job_work_from_home,
search_location,
job_posted_date,
job_no_degree_mention,
job_health_insurance,
job_country,
salary_rate,
salary_year_avg,
salary_hour_avg
)
SELECT * FROM data_jobs.job_postings_fact;
DESCRIBE
SELECT * FROM data_jobs.job_postings_fact;
DROP TABLE data_jobs.job_postings_fact;

ALTER Table job_postings_fact_new
RENAME to job_postings_fact;

DESCRIBE
SELECT * FROM job_postings_fact;

CREATE TEMP TABLE t1 (
    id INTEGER PRIMARY KEY,
    percentage INTEGER CHECK (0 <= percentage AND percentage <= 100)
);
INSERT INTO t1 VALUES (1, 5);
INSERT INTO t1 VALUES (2, 1.1111);
