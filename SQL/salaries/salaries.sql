-- Data science salaries analysis in SQL
-- PostgreSQL
-- Author: Hubert Antoniewicz

-- Creating table structure:

CREATE TABLE salaries ( 
row_id int,
work_year int, 
experience_level char(2),
employment_type char(2),
job_title varchar(100),
salary int,
salary_currency char(3),
salary_in_usd int,
employee_residence char(2),
remote_ratio int,
company_location char(2),
company_size char(1) 
);

-- Importing data from file

copy salaries from '/tmp/ds_salaries.csv' DELIMITER ',' HEADER ;

select * from salaries
limit 5;

-- Analysis:
--- checking number of observations for every year

select work_year, count(*) from salaries group by work_year

--- we gonna use only 2022 year because of the highest number of observation
--- only full time employment => employment_type = 'FT'

-- Creating new table as subset of initial data for easier querying:

create table sal as (select * from salaries where work_year = '2022' and employment_type = 'FT' );

select * from sal
limit 5;

-- Best paid 
select job_title, round(avg(salary_in_usd)) "Average_salary in USD", count(*) from sal
group by job_title order by 2 desc
limit 10;

-- some jobs occurs more than once and can be affected by outliers

select job_title, salary_in_usd from sal
where job_title in ('Applied Data Scientist','Data Architect','Head of Data Science')
order by 1, 2 desc;

-- it is clearly visible that some salaries are inflated due to single observations with significantly higher pay
-- median would be better measure 

-- Best paid jobs and countries

select job_title, employee_residence, CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS DECIMAL(10,0)) AS "Median salary in USD"
from sal
group by job_title, employee_residence order by "Median salary in USD" desc
limit 10;

-- Best paid jobs non-US

select job_title, employee_residence, CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS DECIMAL(10,0)) AS "Median salary in USD"
from sal
where employee_residence != 'US' 
group by job_title, employee_residence order by "Median salary in USD" desc
limit 10;

-- Worst paid jobs

select job_title, employee_residence, CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS DECIMAL(10,0)) AS "Median salary in USD"
from sal
group by job_title, employee_residence order by "Median salary in USD" asc
limit 10;

-- On-site vs remote work

select remote_ratio, salary_in_usd from sal
order by 2 desc
limit 10;

select remote_ratio, CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS DECIMAL(10,0)) AS "Median salary in USD"
from sal
group by remote_ratio order by "Median salary in USD" desc
limit 10;

select * from sal

select employee_residence, company_location, salary_in_usd
from sal
where employee_residence != 'US'
order by 3 desc
limit 10;

-- Experience level

select experience_level, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS "Median salary"
from sal
group by experience_level order by "Median salary" desc
limit 10;

-- Company size

select company_size, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS "Median salary"
from sal
group by company_size order by "Median salary" desc
limit 10;

select company_size, experience_level, CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) AS DECIMAL(10,0)) AS "Median salary in USD" , count(*)
from sal
group by company_size, experience_level order by 1,3 desc
limit 10;
