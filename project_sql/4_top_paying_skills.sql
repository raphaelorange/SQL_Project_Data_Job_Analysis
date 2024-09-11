/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill
for Data Analyst positions
- Focuses on roles with specified (remove null)
salaries, regardless of location
- Why? It reveals how different skills impact salary
levels for Data Analysts and helps identify the most
financially rewarding skills to acquire or improve
*/


select 
    skills,
    round(avg(salary_year_avg), 2) as salary_avg
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE
        job_title_short = 'Data Analyst' and
        (job_location = 'Philadelphia, PA' or
        job_location = 'New York, NY') and
        salary_year_avg is not null
group by
    skills
order by 
    salary_avg desc
limit 25