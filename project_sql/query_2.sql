/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

-- WITH skills_needed AS (
--     SELECT 
--         skill.skill_id,
--         skills_need_for_jobs.job_id,
--         skill.skills
--     FROM 
--         skills_dim AS skill
--     JOIN skills_job_dim AS skills_need_for_jobs
--     ON skill.skill_id = skills_need_for_jobs.skill_id
-- )


-- SELECT 
--    job_postings_fact.job_id,
--    job_title,
--    skills AS skills_needed,
--    salary_year_avg
-- FROM job_postings_fact
-- LEFT JOIN skills_needed 
--     ON job_postings_fact.job_id = skills_needed.job_id
-- WHERE 
--     job_title_short = 'Data Analyst'
--     AND
--     salary_year_avg IS NOT NULL
--     AND
--     skills_needed IS NOT NULL
-- ORDER BY
--     salary_year_avg DESC
-- LIMIT 10


WITH top_paying_jobs AS (

    SELECT 
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND
        job_work_from_home = True
        AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10

)

SELECT * 
FROM top_paying_jobs
JOIN skills_job_dim
ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC