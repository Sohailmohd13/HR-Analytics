use [HR-Analytics];
select * from Hr_data;

-- Total Employees 
select count (*) As Total_Employee from Hr_data;

-- Total Attrition 
select Count (attrition) As Total_attrition from hr_data
where attrition = 'yes';

-- Attrition Rate 
select Round (Count
( Case when Attrition = 'yes' then 1 End) * 100 
/ Count(*),2 )from Hr_data;

-- Active Employee
select Count (CF_Current_Employee)As Active_Employee from Hr_data
where CF_Current_Employee = 1 ;

-- Employee Distribution by Department
select Department , Count(*) As Dept_wise_Employee from Hr_data 
group by Department
order by Dept_wise_Employee Desc ;

-- Department-wise Attrition Count
select Department , Count (Attrition) As Dept_wise_attrition from Hr_data
where attrition = 'yes'
group by department 
order by Dept_wise_attrition desc;

-- Department-wise Attrition Rate
SELECT Department,COUNT(*) AS Total_Employees,
ROUND (COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0/ COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- Job Role-wise Attrition Rate
select job_role ,count(*) As Total_Employees,
Round (count(case when  Attrition = 'yes' then 1 End)*100 / Count(*),2) As JB_wise_Attrition_in_perc
from Hr_data 
group by job_role
order by JB_wise_Attrition_in_perc desc ;

-- Gender-wise Attrition Rate
select Gender ,count(*) As Total_Employees,
Round (count(case when  Attrition = 'yes' then 1 End)*100 / Count(*),2) As Gender_wise_Attrition_in_perc
from Hr_data 
group by Gender
order by Gender_wise_Attrition_in_perc desc ;

-- Overtime vs Attrition
select Over_time,count(*) As Total_Employees,
Round (count(case when  Attrition = 'yes' then 1 End)*100 / Count(*),2) As Overtime_wise_Attrition_in_perc
from Hr_data 
group by Over_time 
order by Overtime_wise_Attrition_in_perc desc ;

-- Average Age by Department
SELECT Department,ROUND(AVG(Age), 2) AS Average_Age
FROM hr_data
GROUP BY Department
ORDER BY Average_Age DESC;

-- Average Monthly Income by Department
SELECT Department,ROUND(AVG(Monthly_Income), 2) AS Average_Monthly_Income
FROM hr_data
GROUP BY Department
ORDER BY Average_Monthly_Income DESC;

-- Monthly Income by Attrition
SELECT Attrition,COUNT(*) AS Employee_Count,
ROUND(AVG(Monthly_Income), 2) AS Average_Income,
ROUND(MIN(Monthly_Income), 2) AS Minimum_Income,
ROUND(MAX(Monthly_Income), 2) AS Maximum_Income
FROM hr_data
GROUP BY Attrition;

-- Average Income by Job Role
SELECt Job_Role,ROUND(AVG(Monthly_Income), 2) AS Average_Income
FROM hr_data
GROUP BY Job_Role
ORDER BY Average_Income DESC;

-- Job Satisfaction vs Attrition
SELECT Job_Satisfaction,COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Count,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0/ COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Job_Satisfaction
ORDER BY Job_Satisfaction;

-- Work-Life Balance vs Attrition
SELECT Work_Life_Balance,COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Count,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0/ COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Work_Life_Balance
ORDER BY Work_Life_Balance;

-- Experience vs Attrition
SELECT Attrition,
ROUND(AVG([Total_Working_Years]), 2) AS Average_Total_Working_Years,
ROUND(AVG([Years_At_Company]), 2) AS Average_Years_At_Company FROM hr_data
GROUP BY Attrition;

-- Performance Rating vs Attrition
SELECT Performance_Rating,COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Count,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100 / COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Performance_Rating
ORDER BY Performance_Rating;

-- Top 10 Highest Paid Employees
SELECT TOP 10 Employee_Number,Job_Role,Department,Monthly_Income FROM hr_data
ORDER BY Monthly_Income desc;

-- Rank Job Roles by Attrition Rate
WITH AttritionRate AS (SELECT Job_Role,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100/ COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Job_Role)
SELECT Job_Role,Attrition_Rate,
RANK() OVER (ORDER BY Attrition_Rate DESC) AS Attrition_Rank
FROM AttritionRate
ORDER BY Attrition_Rank;

-- Employees Earning Below Average Income
select Employee_Number,Job_Role,Department,Monthly_Income,Attrition
FROM hr_data
WHERE Monthly_Income < (SELECT AVG(Monthly_Income) FROM hr_data)
ORDER BY Monthly_Income;

-- Department with Highest Attrition Rate
WITH DepartmentAttrition AS (select Department,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100/ COUNT(*),2) AS Attrition_Rate
FROM hr_data
GROUP BY Department)
SELECT TOP 1 Department,Attrition_Rate
FROM DepartmentAttrition
ORDER BY Attrition_Rate desc;

-- Overall HR Summary
SELECT COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition = 'Yes'THEN 1 END) AS Total_Attrition,
ROUND(COUNT(CASE WHEN Attrition = 'Yes'THEN 1 END) * 100.0 / COUNT(*),2) AS Attrition_Rate,
ROUND(AVG(Age), 2) AS Average_Age,
ROUND(AVG(Monthly_Income), 2) AS Average_Monthly_Income,
ROUND(AVG(job_satisfaction), 2) AS Average_Job_Satisfaction,
ROUND(AVG(Total_Working_Years), 2) AS Average_Working_Years
FROM hr_data;