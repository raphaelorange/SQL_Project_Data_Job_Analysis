/*
Question: What are the most in-demand skills for
data analysts?
- Join job postings to inner join table similar to
query 2
- Identify the top 5 in-demand skills for a data
analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest
demand in the job market, providing insights into
the most valuable skills for job seekers.
*/




select 
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE
        job_title_short = 'Data Analyst' and
        job_location = 'Philadelphia, PA' or
        job_location = 'New York, NY'
group by
    skills
order by demand_count desc
limit 5