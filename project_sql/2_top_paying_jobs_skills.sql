/*
Question: What skills are required for the top-paying 
data analyst jobs?
- Use the top 10 highest-paying Data Analyst 
jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which
high-paying jobs demand certain skills, helping job
seekers understand which skills to develop that
align with top salaries
*/

with top_paying_jobs as (
    select 
        job_id,
        job_title,
        company_dim.company_name,
        salary_year_avg
    from 
        job_postings_fact
    left join company_dim on company_dim.company_id = job_postings_fact.company_id
    where 
        salary_year_avg is not null and
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'
    order by 
        salary_year_avg desc
)

select
    top_paying_jobs.*,
    skills_dim.skills,
    skills_dim.type
from top_paying_jobs
inner join skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order BY salary_year_avg desc
limit 10





select skills_dim.skills,
       skill_count.total_skills
from skills_dim
left join skill_count on skill_count.skill_id =  skills_dim.skill_id 
order by total_skills desc
limit 5


select
    skills.skill_id,
    skills as skill_name,
    skill_count
from remote_job_skills
inner join skills_dim as skills on skills.skill_id = remote_job_skills.skill_id
order by 
    skill_count desc
limit 5
