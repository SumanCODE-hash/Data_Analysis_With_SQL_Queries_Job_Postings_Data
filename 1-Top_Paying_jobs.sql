/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT 
        job_id,
        job_title,
        job_posted_date,
        job_work_from_home,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere' 
ORDER BY
    salary_year_avg DESC
LIMIT 10;


/*
💡 Key Insights

Mantys tops the list with an extraordinary $650K/year Data Analyst role — much higher than the rest.

Big Tech (Meta, AT&T, Pinterest) also offer lucrative roles in analytics.

Director and Principal-level positions dominate the top 10, showing leadership-oriented analyst jobs tend to be paid more.

All roles are remote-friendly (Anywhere), offering global work flexibility.

Salaries range from $184K → $650K, with a strong concentration above $180K.

Results:
[
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "job_posted_date": "2023-02-20 15:13:33",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "650000.0",
    "company_name": "Mantys"
  },
  {
    "job_id": 547382,
    "job_title": "Director of Analytics",
    "job_posted_date": "2023-08-23 12:04:42",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "336500.0",
    "company_name": "Meta"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "job_posted_date": "2023-06-18 16:03:12",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "255829.5",
    "company_name": "AT&T"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "job_posted_date": "2023-12-05 20:00:40",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "232423.0",
    "company_name": "Pinterest Job Advertisements"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "job_posted_date": "2023-01-17 00:17:23",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "217000.0",
    "company_name": "Uclahealthcareers"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_posted_date": "2023-08-09 11:00:01",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "205000.0",
    "company_name": "SmartAsset"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "job_posted_date": "2023-12-07 15:00:13",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189309.0",
    "company_name": "Inclusively"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "job_posted_date": "2023-01-05 00:00:25",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189000.0",
    "company_name": "Motional"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "job_posted_date": "2023-07-11 16:00:05",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "186000.0",
    "company_name": "SmartAsset"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "job_posted_date": "2023-06-09 08:01:04",
    "job_work_from_home": true,
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "184000.0",
    "company_name": "Get It Recruit - Information Technology"
  }
]
*/