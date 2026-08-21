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

COPY company_dim TO 'company_dim.csv' (HEADER, DELIMITER ',');
COPY job_postings_fact TO 'job_postings_fact.csv' (HEADER, DELIMITER ',');
COPY skills_dim TO 'skills_dim.csv' (HEADER, DELIMITER ',');
COPY skills_job_dim TO 'skills_job_dim.csv' (HEADER, DELIMITER ',');

DESCRIBE company_dim;
DESCRIBE job_postings_fact;
DESCRIBE skills_dim;
