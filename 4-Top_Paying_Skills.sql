/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
-- Then focousing on Remote
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills AS Skills_name,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary--- Aggregate count on job_id in --table skills_job_dim
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id --Join --able with job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  --Join table --with skill_id 
WHERE job_title_short = 'Data Analyst' AND 
      salary_year_avg IS NOT NULL AND
      job_work_from_home =TRUE
GROUP BY
    Skills_name
ORDER BY
    avg_salary DESC
LIMIT 25;


/*
Insights

Big Data & Cloud Tools (PySpark, Databricks, Airflow, Kubernetes, GCP, Postgres)
→ Highest paying, because companies need data analysts who can scale data pipelines and handle distributed systems.

MLOps / AI Platforms (DataRobot, Watson, Scikit-learn)
→ Show strong demand since analysts with ML/AI deployment knowledge command premium salaries.

Version Control & Collaboration (Bitbucket, GitLab, Jenkins, Atlassian, Notion)
→ Surprisingly high salaries here—indicates analysts who integrate well into DevOps teams are very valuable.

Programming & Libraries (Swift, Pandas, NumPy, Scala, Golang)
→ Core coding skills tied to performance and specialized applications (mobile, distributed, or scientific computing).

Results:
[
  {
    "skills_name": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills_name": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills_name": "watson",
    "avg_salary": "160515"
  },
  {
    "skills_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills_name": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills_name": "swift",
    "avg_salary": "153750"
  },
  {
    "skills_name": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills_name": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills_name": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skills_name": "golang",
    "avg_salary": "145000"
  },
  {
    "skills_name": "numpy",
    "avg_salary": "143513"
  },
  {
    "skills_name": "databricks",
    "avg_salary": "141907"
  },
  {
    "skills_name": "linux",
    "avg_salary": "136508"
  },
  {
    "skills_name": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skills_name": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skills_name": "twilio",
    "avg_salary": "127000"
  },
  {
    "skills_name": "airflow",
    "avg_salary": "126103"
  },
  {
    "skills_name": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skills_name": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skills_name": "notion",
    "avg_salary": "125000"
  },
  {
    "skills_name": "scala",
    "avg_salary": "124903"
  },
  {
    "skills_name": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skills_name": "gcp",
    "avg_salary": "122500"
  },
  {
    "skills_name": "microstrategy",
    "avg_salary": "121619"
  }
]
*/
