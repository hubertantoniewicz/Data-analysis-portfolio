
# Data science salaries analysis in SQL

+ Author: Hubert Antoniewicz
+ 10/2023
+ PostgreSQL
+ salaries.csv ([source: Kaggle](https://www.kaggle.com/datasets/ruchi798/data-science-job-salaries/))
### Preview of dataset:

| "row_id" | "work_year" | "experience_level" | "employment_type" | "job_title"                  | "salary" | "salary_currency" | "salary_in_usd" | "employee_residence" | "remote_ratio" | "company_location" | "company_size" |
|----------|-------------|--------------------|-------------------|------------------------------|----------|-------------------|-----------------|----------------------|----------------|--------------------|----------------|
| 0        | 2020        | "MI"               | "FT"              | "Data Scientist"             | 70000    | "EUR"             | 79833           | "DE"                 | 0              | "DE"               | "L"            |
| 1        | 2020        | "SE"               | "FT"              | "Machine Learning Scientist" | 260000   | "USD"             | 260000          | "JP"                 | 0              | "JP"               | "S"            |
| 2        | 2020        | "SE"               | "FT"              | "Big Data Engineer"          | 85000    | "GBP"             | 109024          | "GB"                 | 50             | "GB"               | "M"            |
| 3        | 2020        | "MI"               | "FT"              | "Product Data Analyst"       | 20000    | "USD"             | 20000           | "HN"                 | 0              | "HN"               | "S"            |
| 4        | 2020        | "SE"               | "FT"              | "Machine Learning Engineer"  | 150000   | "USD"             | 150000          | "US"                 | 50             | "US"               | "L"            |

## Analysis
+ Analysis will be focused on average salary in USD for different countries, position, experience level and company size.

### Checking number of observations for every year

| "work_year" | "count" |
|-------------|---------|
| 2022        | 318     |
| 2021        | 217     |
| 2020        | 72      |

+ Only 2022 year will be used because of the highest number of observations.
+ Also only full time workers will be considered. 

### Creating new table as subset of initial data for easier querying

| "row_id" | "work_year" | "experience_level" | "employment_type" | "job_title"      | "salary" | "salary_currency" | "salary_in_usd" | "employee_residence" | "remote_ratio" | "company_location" | "company_size" |
|----------|-------------|--------------------|-------------------|------------------|----------|-------------------|-----------------|----------------------|----------------|--------------------|----------------|
| 289      | 2022        | "SE"               | "FT"              | "Data Engineer"  | 135000   | "USD"             | 135000          | "US"                 | 100            | "US"               | "M"            |
| 290      | 2022        | "SE"               | "FT"              | "Data Analyst"   | 155000   | "USD"             | 155000          | "US"                 | 100            | "US"               | "M"            |
| 291      | 2022        | "SE"               | "FT"              | "Data Analyst"   | 120600   | "USD"             | 120600          | "US"                 | 100            | "US"               | "M"            |
| 292      | 2022        | "MI"               | "FT"              | "Data Scientist" | 130000   | "USD"             | 130000          | "US"                 | 0              | "US"               | "M"            |
| 293      | 2022        | "MI"               | "FT"              | "Data Scientist" | 90000    | "USD"             | 90000           | "US"                 | 0              | "US"               | "M"            |


### Best paid jobs (average)

| "job_title"                         | "Average_salary in USD" | "count" |
|-------------------------------------|-------------------------|---------|
| "Data Analytics Lead"               | 405000                  | 1       |
| "Applied Data Scientist"            | 238000                  | 3       |
| "Director of Data Science"          | 196979                  | 1       |
| "Head of Data Science"              | 195938                  | 2       |
| "Data Architect"                    | 182077                  | 8       |
| "Analytics Engineer"                | 175000                  | 4       |
| "Data Science Manager"              | 170197                  | 5       |
| "Principal Data Scientist"          | 162674                  | 1       |
| "AI Scientist"                      | 160000                  | 2       |
| "Computer Vision Software Engineer" | 150000                  | 1       |

+ Some of the job titles occur more than once so we need to determine whether there are any potential outliers inflating average salary in USD.

| "job_title"              | "salary_in_usd" |
|--------------------------|-----------------|
| "Applied Data Scientist" | 380000          |
| "Applied Data Scientist" | 177000          |
| "Applied Data Scientist" | 157000          |
| "Data Architect"         | 266400          |
| "Data Architect"         | 213120          |
| "Data Architect"         | 208775          |
| "Data Architect"         | 192564          |
| "Data Architect"         | 192400          |
| "Data Architect"         | 147800          |
| "Data Architect"         | 144854          |
| "Data Architect"         | 90700           |
| "Head of Data Science"   | 224000          |
| "Head of Data Science"   | 167875          |

+ Based on table above we can conclude that some of specialists make substantially more than others so median would be better measure than average.

### Median of best paid job

| "job_title"                 | "employee_residence" | "Median salary in USD" |
|-----------------------------|----------------------|------------------------|
| "Data Analytics Lead"       | "US"                 | 405000                 |
| "Data Architect"            | "US"                 | 200670                 |
| "AI Scientist"              | "IN"                 | 200000                 |
| "Head of Data"              | "MY"                 | 200000                 |
| "Director of Data Science"  | "CA"                 | 196979                 |
| "Head of Data Science"      | "US"                 | 195938                 |
| "Machine Learning Engineer" | "US"                 | 189650                 |
| "Analytics Engineer"        | "US"                 | 179850                 |
| "Applied Data Scientist"    | "US"                 | 177000                 |
| "Principal Data Scientist"  | "DE"                 | 162674                 |

+ Data analytics lead makes more than 400,000 USD per year.
+ Most of the best paid jobs are located in the US
+ Most of the best paid jobs are lead/head/director position which is consisent with economical intuition.
+ There is a gap between best paid job and others (400k vs 200k) which can be caused by the fact that for the Data analytics lead there was only 1 observation.
+ We can conclude that most of the senior position data science analysts can make around 160-200k USD annualy.


### Median of best paid job outside the US

| "job_title"                         | "employee_residence" | "Median salary in USD" |
|-------------------------------------|----------------------|------------------------|
| "Head of Data"                      | "MY"                 | 200000                 |
| "AI Scientist"                      | "IN"                 | 200000                 |
| "Director of Data Science"          | "CA"                 | 196979                 |
| "Principal Data Scientist"          | "DE"                 | 162674                 |
| "Computer Vision Software Engineer" | "AU"                 | 150000                 |
| "Data Architect"                    | "CA"                 | 141550                 |
| "Data Scientist"                    | "CH"                 | 122346                 |
| "Lead Data Engineer"                | "CA"                 | 118187                 |
| "Data Scientist"                    | "BR"                 | 100000                 |
| "Machine Learning Engineer"         | "GB"                 | 98158                  |

+ Best paid jobs excluding United States are more diverse geographically
+ In Top 10 there are 3 positions from Canada and 7 from different countries
+ In average, data scientists make less money if located out of the United States.
+ Also there are less lead/head/director positions than in the US which can indicate that many companies hire managers from the US and specialists/engineers all around the world.
+ To prove this we need to analyze on-site vs remote ratio in order to verify if data science specialits are working remotely outside the company's residence location.

### Median of worst paid jobs

| "job_title"                | "employee_residence" | "Median salary in USD" |
|----------------------------|----------------------|------------------------|
| "Computer Vision Engineer" | "PT"                 | 10000                  |
| "Business Data Analyst"    | "IN"                 | 18442                  |
| "Data Analytics Engineer"  | "PK"                 | 20000                  |
| "ML Engineer"              | "PT"                 | 21983                  |
| "Data Scientist"           | "IN"                 | 25029                  |
| "Head of Data"             | "EE"                 | 32974                  |
| "Data Analyst"             | "GR"                 | 32974                  |
| "Data Scientist"           | "PL"                 | 35590                  |
| "NLP Engineer"             | "US"                 | 37236                  |
| "Data Analyst"             | "ES"                 | 38470                  |

Worst paid jobs are mostly in developing countries: 
+ from Asia: India, Pakistan,
+ middle-east Europe: Poland, Estonia 
and some developed countrie including:
+ Portugal, Greece and Spain from South Europe:
Also most of those jobs are mid-level positions including engineers,analysts and scientists


### Highest salaries vs remote ratio:

| "remote_ratio" | "salary_in_usd" |
|----------------|-----------------|
| 100            | 405000          |
| 100            | 380000          |
| 100            | 324000          |
| 100            | 266400          |
| 100            | 260000          |
| 100            | 243900          |
| 100            | 242000          |
| 100            | 241000          |
| 100            | 230000          |
| 100            | 230000          |

All the best paying job are 100% remote.


### Median salaries vs remote ratio
| "remote_ratio" | "Median salary in USD" |
|----------------|------------------------|
| 0              | 110900                 |
| 50             | 90065                  |
| 100            | 128875                 |

There is about 20,000 USD difference between highest paid remote job and on-site jobs. Similiar difference is between on-site hybrid (50%) location. Hybrid setups are lowest paid.

We can also see that some of the highest paid data science specialists are working remotely for US companies from Asian developing countries (India, Myanmar)

| "employee_residence" | "company_location" | "salary_in_usd" |
|----------------------|--------------------|-----------------|
| "MY"                 | "US"               | 200000          |
| "IN"                 | "US"               | 200000          |
| "CA"                 | "CA"               | 196979          |
| "CA"                 | "CA"               | 192400          |
| "GB"                 | "GB"               | 183228          |
| "DE"                 | "DE"               | 162674          |
| "AU"                 | "AU"               | 150000          |
| "CA"                 | "CA"               | 130000          |
| "CA"                 | "CA"               | 130000          |
| "GB"                 | "GB"               | 124333          |

### Median salary vs experience level

| "experience_level" | "Median salary" |
|--------------------|-----------------|
| "EX"               | 175000          |
| "SE"               | 138600          |
| "MI"               | 78526           |
| "EN"               | 52396           |

+ We can see than median remuneration for entry level specialists equals 52,000 USD. It is nearly 50% higher for mid-level specialists (78,000). Increase is even higher for senior analysts (nearly 77%) with median salary equal to nearly 139,000.
+ The conclusion is that the pay difference between different experience level is significant so perspectives for junior analyst for better pay in the future are promising.

### Median salary vs company size

| "company_size" | "Median salary" |
|----------------|-----------------|
| "M"            | 123595          |
| "L"            | 122346          |
| "S"            | 65000           |


+ What is interesting, the median salary is almost the same for large and middle size companies. On the other hand, data science employees are making almost twice less working for small company when comparing to larger companies with higher budgets. 

| "company_size" | "experience_level" | "Median salary in USD" | "count" |
|----------------|--------------------|------------------------|---------|
| "L"            | "SE"               | 158200                 | 23      |
| "L"            | "EX"               | 138009                 | 2       |
| "L"            | "MI"               | 81213                  | 14      |
| "L"            | "EN"               | 46198                  | 6       |
| "M"            | "EX"               | 187500                 | 10      |
| "M"            | "SE"               | 136600                 | 167     |
| "M"            | "MI"               | 83950                  | 68      |
| "M"            | "EN"               | 52351                  | 11      |
| "S"            | "EX"               | 118187                 | 1       |
| "S"            | "EN"               | 107500                 | 2       |

+ We can also see that in large companies the salary for less experienced specialists are relatively lower than in small and mid size companies. For small companies the difference between expert and entry level is not significant but there is very small sample size.

## Summary

Data science salaries dataset contained only about 600 observations with just a few variables. On the basis analysis we can observe some interesting results. This includes:
+ most of the best earning data scientist are working in the US or for US companies remotely being resident of different country
+ there is huge difference between entry and expert level salary in both large and middle size companies
+ Fully remote or fully on-site jobs are best paid when comparing to hybrid setups.