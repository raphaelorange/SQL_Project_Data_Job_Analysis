/* Answer: What are the most optimal skills to learn
(aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high
average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand)
and financial benefits (high salaries), offering strategic
insights for career development in data analysis
*/

select 
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(salary_year_avg), 2) as salary_avg
from 
    job_postings_fact
    
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    salary_year_avg is not null and
    job_title_short = 'Data Analyst' and 
    job_location = 'Philadelphia, PA' or
    job_location = 'New York, NY'
group by
    skills_dim.skill_id
having 
    count(skills_job_dim.job_id)  > 10
order by 
    demand_count desc, salary_avg desc
limit 10 