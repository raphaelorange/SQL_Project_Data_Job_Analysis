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





