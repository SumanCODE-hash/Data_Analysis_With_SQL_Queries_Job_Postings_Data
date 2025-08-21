/*
-- Comparing top demanded skills from two different data jobs
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst and Data Scientist
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
--

*/

SELECT 
    skills AS Skills_name,
    COUNT(skills_job_dim.job_id) AS skills_demand  --- Aggregate count on job_id in --table skills_job_dim
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id --Join --able with job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  --Join table --with skill_id 
WHERE job_title_short = 'Data Analyst' AND 
      job_no_degree_mention = FALSE
GROUP BY
    Skills_name
ORDER BY
    skills_demand DESC
LIMIT 5;

SELECT 
    skills AS Skills_name,
    COUNT(skills_job_dim.job_id) AS skills_demand  --- Aggregate count on job_id in --table skills_job_dim
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id --Join --able with job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  --Join table --with skill_id 
WHERE job_title_short = 'Data Scientist' AND 
      job_no_degree_mention = FALSE
GROUP BY
    Skills_name
ORDER BY
    skills_demand DESC
LIMIT 5;

/*
💡 Key Insights

SQL = Universal Language → #1 for Analysts, #2 for Scientists → mandatory for both paths.

Python is the major divider → critical for Data Scientists (111k demand vs 40k for Analysts).

Excel & Power BI → Analyst staples (not in top scientist stack).

R & SAS → Still relevant for Data Scientists (stats-heavy/legacy enterprise).

Visualization (Tableau) → Shared skill, but slightly higher demand for Analysts (business context).

Results:
⚖️ Data Analyst vs. Data Scientist Skills
Skill	Data Analyst Demand	Data Scientist Demand	Who Relies More?
SQL	60,648	75,043	Both (core skill)
Python	39,999	111,094	Data Scientist-heavy
Excel	46,482	–	Data Analyst-only
Tableau	32,451	28,165	Analysts slightly more
Power BI	26,018	–	Data Analyst-only
R	–	58,840	Data Scientist-only
SAS	–	28,964	Data Scientist-only
*/
