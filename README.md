# Introduction
📊 A professional, step‑by‑step deep‑dive into the remote **Data Analyst** job market. This README distills the results of SQL analyses into clear insights on 💰 top‑paying roles, 🔥 in‑demand skills, and 🎯 skills that balance **high demand** with **high salary**.

🔍 SQL queries? See them here: [project_sql folder](/project_sql/)

# Background
This analysis targets remote Data Analyst roles to reveal where compensation and skill demand intersect. The data originates from a structured job‑market dataset containing postings, companies, salaries, and required skills. The objective: produce actionable guidance for career planning and portfolio‑ready insights.

### The questions answered with SQL:
1. What are the top‑paying data analyst jobs? (**Q‑1**)
2. What skills are required for these top‑paying jobs? (**Q‑2**)
3. What skills are most in demand for data analysts? (**Q‑3**)
4. Which skills are associated with higher salaries? (**Q‑4**)
5. What are the most optimal skills to learn (high demand + high salary)? (**Q‑5**)

# Tools I Used
- **SQL** — primary analysis and aggregation layer.
- **PostgreSQL** — relational engine for joins, CTEs, and windowing patterns.
- **VS Code** — query authoring and iteration.
- **Git & GitHub** — version control and reproducibility of SQL and insights.

# The Analysis
Each subsection mirrors a business question (**Q‑#**) and provides: the SQL approach and concise insights.

---

## Q‑1) Top‑Paying Remote Data Analyst Jobs
Identify remote roles with specified salaries, ranked by average yearly pay.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

**Insights (Q‑1):**
- The top band for remote data analyst‑aligned roles ranges from **$184K → $650K**.
- Senior/principal/director titles frequently appear among top salaries, indicating leadership responsibility premiums.
- High‑pay employers span technology, finance, healthcare, and platforms — reflecting cross‑industry demand.

**Top 10 (sample results)**

| Rank | Job Title                                         | Company                                   | Avg. Salary (USD) | Location |
|-----:|---------------------------------------------------|-------------------------------------------|------------------:|---------|
| 1 | Data Analyst | Mantys | **650,000** | Anywhere |
| 2 | Director of Analytics | Meta | **336,500** | Anywhere |
| 3 | Associate Director – Data Insights | AT&T | **255,829** | Anywhere |
| 4 | Data Analyst, Marketing | Pinterest Job Advertisements | **232,423** | Anywhere |
| 5 | Data Analyst (Hybrid/Remote) | Uclahealthcareers | **217,000** | Anywhere |
| 6 | Principal Data Analyst (Remote) | SmartAsset | **205,000** | Anywhere |
| 7 | Director, Data Analyst – HYBRID | Inclusively | **189,309** | Anywhere |
| 8 | Principal Data Analyst, AV Performance Analysis | Motional | **189,000** | Anywhere |
| 9 | Principal Data Analyst | SmartAsset | **186,000** | Anywhere |
| 10 | ERM Data Analyst | Get It Recruit – Information Technology | **184,000** | Anywhere |

*Optional figure placeholder*
![Top Paying Roles](assets/1_top_paying_roles.png)

---

## Q‑2) Skills for the Top‑Paying Jobs
Join the top 10 roles to their required skills to see what high‑paying employers value.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
      AND job_location = 'Anywhere'
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    tp.job_id,
    tp.job_title,
    tp.company_name,
    tp.salary_year_avg,
    sd.skills
FROM top_paying_jobs tp
INNER JOIN skills_job_dim sj ON tp.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
ORDER BY tp.salary_year_avg DESC;
```

**Insights (Q‑2):**
- **SQL** appears across nearly all top roles.
- **Python** and **Tableau** are prominent among high‑paying postings, with supporting stacks like **R**, **Snowflake**, **Pandas**, **Excel**.
- Leadership‑tilted analyst roles frequently add cloud and collaboration tooling (e.g., **Azure/AWS**, **Jira/Confluence/GitLab/Bitbucket**).

*Optional figure placeholder*
![Top Paying Skills](assets/2_top_paying_roles_skills.png)

---

## Q‑3) Most In‑Demand Skills for Remote Data Analysts
Aggregate postings by skill to identify highest demand.

```sql
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
```

**Insights (Q‑3):**
- **SQL** leads demand for remote analysts, followed by **Excel**, **Python**, **Tableau**, and **Power BI**.
- The mix reflects a business‑analytics core (SQL/Excel/BI) complemented by programming (Python).
| Skill        | Data Analyst Demand | Data Scientist Demand | Who Relies More?       |
| ------------ | ------------------- | --------------------- | ---------------------- |
| **SQL**      | 60,648              | 75,043                | Both (core skill)      |
| **Python**   | 39,999              | 111,094               | Data Scientist-heavy   |
| **Excel**    | 46,482              | –                     | Data Analyst-only      |
| **Tableau**  | 32,451              | 28,165                | Analysts slightly more |
| **Power BI** | 26,018              | –                     | Data Analyst-only      |
| **R**        | –                   | 58,840                | Data Scientist-only    |
| **SAS**      | –                   | 28,964                | Data Scientist-only    |

**Top 5 — Demand**
Data Analyst
| Skill     | Demand |
|-----------|-------:|
| SQL       | 60,648 |
| Excel     | 46,482 |
| Python    | 39,999 |
| Tableau   | 32,451 |
| Power BI  | 26,018 |

---

## Q‑4) Skills Associated with Higher Salaries (Remote)
Compute average salary by skill for remote Data Analyst roles.

```sql
SELECT
    sd.skills,
    ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact jp
JOIN skills_job_dim sj ON jp.job_id = sj.job_id
JOIN skills_dim sd ON sj.skill_id = sd.skill_id
WHERE jp.job_title_short = 'Data Analyst'
  AND jp.salary_year_avg IS NOT NULL
  AND jp.job_work_from_home = TRUE
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 25;
```

**Insights (Q‑4):**
- Highest averages skew toward **big‑data/ML & engineering** stacks (e.g., **PySpark**, **DataRobot**, **Pandas/NumPy**, **Airflow**, **Databricks**), plus **DevOps/collab** tools (e.g., **GitLab**, **Bitbucket**, **Jenkins**).
- **Cloud** and **search** tech (e.g., **GCP**, **Elasticsearch**) feature among top averages.

**Top 10 — Avg Salary by Skill**

| Skill          | Avg Salary (USD) |
|----------------|------------------:|
| pyspark        | 208,172 |
| bitbucket      | 189,155 |
| couchbase      | 160,515 |
| watson         | 160,515 |
| datarobot      | 155,486 |
| gitlab         | 154,500 |
| swift          | 153,750 |
| jupyter        | 152,777 |
| pandas         | 151,821 |
| elasticsearch  | 145,000 |

---

## Q‑5) Most Optimal Skills to Learn (High Demand + High Salary)
Blend demand and salary to surface skills offering both **job security** and **financial upside**.

```sql
-- Remote‑only, specified‑salary roles, deduplicated by skills_name
WITH skill_demand AS (
    SELECT sd.skills AS skills_name,
           COUNT(sj.job_id) AS skills_demand
    FROM job_postings_fact jp
    JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    JOIN skills_dim sd ON sj.skill_id = sd.skill_id
    WHERE jp.job_title_short = 'Data Analyst'
      AND jp.job_no_degree_mention = FALSE
      AND jp.salary_year_avg IS NOT NULL
      AND jp.job_work_from_home = TRUE
    GROUP BY sd.skills
), avg_salary_skills AS (
    SELECT sd.skills AS skills_name,
           ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact jp
    JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    JOIN skills_dim sd ON sj.skill_id = sd.skill_id
    WHERE jp.job_title_short = 'Data Analyst'
      AND jp.salary_year_avg IS NOT NULL
      AND jp.job_work_from_home = TRUE
    GROUP BY sd.skills
)
SELECT d.skills_name,
       d.skills_demand,
       s.avg_salary
FROM skill_demand d
JOIN avg_salary_skills s ON s.skills_name = d.skills_name
WHERE d.skills_demand > 15
ORDER BY d.skills_demand DESC, s.avg_salary DESC
LIMIT 25;
```

**Insights (Q‑5):**
- **Core, high‑demand skills** with strong averages: **Python** (~$101K, 1,485 postings), **R** (~$100K, 910), **Oracle** (~$105K, 272), **Azure** (~$111K, 236), **AWS** (~$108K, 223), **Snowflake** (~$113K, 186), **Looker** (~$104K, 186), **Go** (~$115K, 218).
- **SQL** has the largest demand footprint (2,368) with an average just under $100K — essential for market reach, even if not the absolute top paying.
- **Visualization tools** such as **Tableau** (~$99K, 1,354) remain near‑optimal due to breadth of demand, especially when paired with Python and cloud skills.

**Recommended learning paths**
- **Data Foundations**: SQL → Excel → BI (Tableau/Power BI)
- **Analyst‑to‑Engineer Lift**: Python → Pandas/NumPy → Airflow → Snowflake/Azure/AWS
- **Analytics Engineering**: SQL + dbt‑style modeling + Git/GitLab/Bitbucket

---

# What I Learned
- **Advanced SQL patterns**: multi‑CTEs, careful GROUP BY alignment, and consistent filters across CTEs (e.g., remote‑only).
- **Analytical framing**: mapping business questions to precise SQL, then translating results into executive‑ready insights.
- **Market synthesis**: balancing demand metrics with compensation to prioritize learning investments.

# Conclusions
### Insights
1. **Top‑pay roles** concentrate in senior/principal/director tracks and span multiple industries.
2. **SQL** is the baseline for employability; **Python** and **Tableau/Power BI** boost both pay and scope.
3. **Cloud & big‑data tooling** (Snowflake, Azure, AWS, PySpark) correlates with higher salary bands.
4. The **most optimal** upskilling strategy layers **SQL + Python + BI** first, then adds **cloud/engineering** capabilities.

### Closing Thoughts
This step‑by‑step SQL‑driven analysis provides a professional blueprint for prioritizing skills and opportunities in remote Data Analyst roles. Use it to guide learning paths, update portfolios, and target high‑value postings with confidence.

