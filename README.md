# Introduction

Explore the data job market! This project focuses on data analyst positions, highlighting top-paying roles, in-demand skills, and where high demand aligns with high salaries in data analytics.

SQL Queries can be found here: [project_sql folder](/project_sql/)
# Background

Motivated by the goal of better understanding the data analyst job market, this project aims to identify high-paying, in-demand skills, making it easier for others to find the best opportunities.  

The data is sourced from [Luke Barousse's SQL Course](https://lukebarousse.com/sql) and provides valuable insights into job titles, salaries, locations, and key skills.

### The questions I aimed to address through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools

For my in-depth exploration of the data analyst market, I utilized several essential tools.


- **SQL**: The core of my analysis, enabling me to query the database and uncover valuable insights.
- **PostgresSQL**: The selected database management system, perfectly suited for managing the job posting data.
- **Visual Studio Code**: My preferred tool for managing databases and running SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, facilitating collaboration and project tracking.

# The Analysis

### 1. Top Paying Data Analyst Jobs

```sql

select 
    job_id,
    job_title,
    company_dim.company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
from 
    job_postings_fact
left join company_dim on company_dim.company_id = job_postings_fact.company_id
where 
    salary_year_avg is not null and
    job_title_short = 'Data Analyst' AND
    ( job_location = 'Philadelphia, PA' or
    job_location = 'New York, NY' )
order by 
    salary_year_avg desc
limit 10
```

Here is the breakdown of the top data anlayst jobs in Philadelphia and New York in 2023:

- **Broad Salary Range** Salaries range from 42,500 to 240,000.

- **Diverse Employers** Companies such as TikTok, Coda Search, and CyberCoders are offering competitive salaries, indicating widespread interest across various industries.

- **Job Title Variety** The range of job titles is broad, from Data Analyst to Blockchain Researcher, highlighting the diversity of roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs

To identify the skills needed for high-paying jobs, I combined job postings with skills data, offering insights into what employers value in well-compensated roles.

```

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
        (job_location = 'Philadelphia' or
        job_location = 'New York, NY')
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


```
*The most popular skills for the top-10 jobs were SQL and Python.*

### 3. In-Demand Skills for Data Analysts

This query revealed the skills most commonly sought after in job listings, highlighting areas with strong demand.

```

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
```
Here’s a summary of the top skills in demand for data analysts in 2023:

- **SQL** and **Excel** continue to be essential, highlighting the importance of solid foundational skills in data handling and spreadsheet analysis.

- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **R**  are crucial, highlighting the rising importance of technical skills in data storytelling and support in making decisions.

| Skills    | Demand Count |
|----------|-------|
| SQL      | 5342  |
| Python   | 4844  |
| Tableau   | 2177  |
| Excel    | 2118  |
| R        | 2097  |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary

Analyzing the average salaries linked to various skills uncovered which ones are the highest paying.


- **Databases and Data Management**: Top-paying skills include **Elasticsearch**, **Neo4j**, and **Cassandra**, which are essential for managing large, unstructured datasets. Analysts with expertise in these tools are highly valued for their ability to handle scalable, high-performance databases.

- **Programming and Development Proficiency**: Core programming languages such as **C**, **C++**, and **Java**, along with frameworks like **Spring** and **Angular**, emphasize the importance of coding and full-stack development in building and integrating data-driven applications. Skills in **Git** and **Unix** further enhance an analyst’s ability to manage development environments and version control systems.

- **Data Science, Machine Learning, and Cloud Tools**: Expertise in machine learning libraries like **Scikit-learn** and **Python libraries** like **NumPy** and **Pandas**, combined with cloud platforms like **GCP** and **Azure**, are critical in modern data analytics for building predictive models and managing data pipelines in scalable, cloud-based environments.


| Skill          | Average Salary ($) |
|----------------|--------------------|
| Elasticsearch  | 185,000          |
| Neo4j          | 185,000          |
| Cassandra      | 175,000          |
| dplyr          | 167,500          |
| Unix           | 162,500          |
| Perl           | 157,000          |
| Twilio         | 150,000          |
| Spring         | 147,500          |
| C              | 146,500          |
| Angular        | 138,516          |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

By merging insights from both demand and salary data, this query sought to identify skills that are not only highly sought after but also well-paid, providing a targeted approach for skill development.

```

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
```
| Skill      | Demand Count | Average Salary ($) |
|------------|---------------|--------------------|
| SQL        | 5031          | 135,858.59          |
| Python     | 4683          | 147,275.22          |
| Tableau    | 2012          | 114,851.10          |
| R          | 1977          | 136,071.11          |
| Excel      | 1886          | 104,458.11          |
| AWS        | 1605          | 151,590.17          |
| Spark      | 1254          | 157,287.56          |
| Snowflake  | 917           | 151,551.57          |
| Azure      | 912           | 153,042.07          |
| Java       | 859           | 152,949.58          |

*Table of the most optimal skills for Data Analysts sorted by demand count*

Here's a breakdown of the most essential skills for Data Analysts in 2023: 



- **High-Demand Programming Languages and Analytical Tools**

    - **SQL (5,031 demand count)**, **Python (4,683 demand count)**, **R (1,977 demand count)**, and **Excel (1,886 demand count)** are fundamental tools in data analysis, providing versatility in data extraction, statistical analysis, and basic reporting. SQL is essential for database management, Python and R enable advanced analytics and machine learning, and Excel remains widely used for everyday data manipulation.

- **Cloud Computing and Big Data Technologies**
   - **AWS (1,605 demand count)**, **Azure (912 demand count)**, **Snowflake (917 demand count)**, and **Spark (1,254 demand count)** reflect the growing need for data analysts who can manage cloud infrastructure and handle large datasets. These tools optimize data storage, processing, and analytics in scalable cloud environments, making them highly sought after as businesses shift to cloud-based solutions.

- **Data Visualization and Software Development Skills**
   - **Tableau (2,012 demand count)** and **Java (859 demand count)** highlight the importance of data storytelling and application development. Tableau helps analysts create interactive dashboards for clearer communication of insights, while Java enables integration of data analytics into software applications, expanding the scope of what data analysts can achieve.


# What I leaned

Throughout this adventure, I've tuned my SQL skills with some serious horsepower:

- **Advanced Query Development** 

Perfected advanced SQL techniques, expertly merging tables and using WITH clauses for highly efficient temporary table operations.

- **Data Aggregation**

Became familiar with GROUP BY and made aggregate functions such as COUNT() and AVG() my go-to tools for summarizing data.

- **Analytical Strength**

Became familiar with GROUP BY and made aggregate functions such as COUNT() and AVG() my go-to tools for summarizing data.


# Conclusions

### Insights

1. **Top-Paying Data Analyst Roles**: The highest-paying data analyst positions in Philadelphia and New York offer a broad salary range, with the top reaching $240,000!  
2. **Key Skills for High Salaries**: Advanced SQL proficiency is essential for securing high-paying roles, making it a crucial skill for maximizing earnings.  
3. **Most Sought-After Skills**: SQL is also the most in-demand skill for data analysts, making it vital for those entering the job market.  
4. **Skills Linked to Higher Earnings**: Specialized skills like scikit-learn and NumPy are tied to higher average salaries, reflecting the value of niche expertise.  
5. **Optimal Skills for Market Success**: SQL stands out as both highly demanded and well-compensated, making it one of the best skills for data analysts to focus on to enhance their market value.

### Closing Thoughts

This project improved my SQL abilities and offered important insights into the data analyst job market. The analysis results act as a roadmap for prioritizing skill development and job search strategies. By concentrating on high-demand, well-paying skills, aspiring data analysts can enhance their competitiveness in the job market. This exploration emphasizes the need for continuous learning and adapting to evolving trends in data analytics.