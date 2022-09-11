-- 1. Write a SQL query to find the salaries of all employees
	
select concat(FIRST_NAME," ",LAST_NAME)   -- using concat to get employee full name
as EMPLOYEE_NAME,SALARY from employees; -- using basic statement to return data 

-- 2. Write a SQL query to find the unique designations of the employees. Return job name.
      
select distinct(JOB_TITLE) from jobs;-- using distinct to eliminate duplicates from counting

-- 3. write a SQL query to list the employees’ name, increased their salary by 15%, and expressed as number of Dollars.
	  
create or replace view dp_to_rp               -- using replace(due to multiple acts) to create virtual table  
as select concat(FIRST_NAME,' ',LAST_NAME) as EMPLOYEE_NAME,COMMISSION_PCT*78.1437 -- "dp_to_rp" means dollar percentage to rupee percentage
as COMMISSION_PCT from employees;             -- using alias to give a temporary name
select * from dp_to_rp;                       -- execute to see the virtual table
select EMPLOYEE_NAME,COMMISSION_PCT from dp_to_rp where COMMISSION_PCT >='15';    -- here is the solution

-- 4. Write a SQL query to list the employee's name and job name as a format of "Employee & Job".
	  
select concat(concat(employees.FIRST_NAME," ",employees.LAST_NAME)," & ",jobs.JOB_TITLE)    -- concatenating the strings   
as Employee_and_Job from employees inner join jobs 
on employees.JOB_ID = jobs.JOB_ID;   		    -- inner join helps us to get matched data of both tables 

-- 5. Write a SQL query to find those employees with hire date in the 
--  format like February 22, 1991. Return employee ID, employee name, salary, hire date.
	  
select EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME)         
as EMPLOYEE_NAME, SALARY, HIRE_DATE -- No employees having hire date format like "feburary 22 1991"   
from employees where HIRE_DATE = date_format(HIRE_DATE,'%M %d %Y');	-- Using date_format to know the existence of desired format  

-- 6. Write a SQL query to count the number of characters except the spaces for each employee name. Return employee name length.
	  
create or replace view EMP_NAME as select replace(concat(FIRST_NAME,LAST_NAME)," ","")
as EMPLOYEE_NAME from employees;                   -- replace spaces with no spaces using replace function
select * from EMP_NAME;								
select char_length(EMPLOYEE_NAME) as EMP_NAME_LEN from EMP_NAME;    -- char_length to know length of characters 
    
-- 7. Write a SQL query to find the employee ID, salary, and commission of all the employees. 

select employees.EMPLOYEE_ID,job_history.EMPLOYEE_ID    -- all employees means count of emp in employees table and 
as EMP_ID,employees.SALARY,employees.COMMISSION_PCT from employees -- job_history table
left join  job_history on employees.EMPLOYEE_ID = job_history.EMPLOYEE_ID
union                                          -- union of both left and right join makes outer join 
select employees.EMPLOYEE_ID,job_history.EMPLOYEE_ID 
as EMP_ID,employees.SALARY,employees.COMMISSION_PCT from employees     
right join job_history on employees.EMPLOYEE_ID = job_history.EMPLOYEE_ID;
 
 -- No commisson_pct in jobs_history so 
 
-- 8. Write a SQL query to find the unique department with jobs. Return department ID, Job name. 

select distinct(employees.DEPARTMENT_ID),JOB_TITLE from employees  -- common job_id in jobs and employees
inner join jobs on jobs.JOB_ID = employees.JOB_ID; -- inner join job_id in jobs and employee to get the desired output 
-- Got 20 rows and getting one duplicate row ( dep_id = 0 and job_title = sales representative)
-- Simple two line code but i'm going with below method which deals  
-- with 3 tables (departments,employees,jobs) table and eliminate duplicates

create or replace view DEPID_JOB as select -- job_title and dep_id are on different tables with no common column    
distinct(departments.DEPARTMENT_ID) , (employees.JOB_ID)  -- dep_id is common column of deps & employees so
from departments inner join employees on  -- creating a virtual table that can contain both department_id an job_id
employees.DEPARTMENT_ID = departments.DEPARTMENT_ID;    -- by using inner join
select * from DEPID_JOB;                       -- virtual table containing department_id and job_id
select DEPID_JOB.DEPARTMENT_ID,JOB_TITLE from jobs   -- common job_id in virtual table(DEPID_JOB) and jobs table 
inner join DEPID_JOB on jobs.JOB_ID = DEPID_JOB.JOB_ID ; -- using inner join to get the desired result

-- Got 19 rows with duplicate elimination 

-- 9. Write a SQL query to find those employees who joined before 1991. Return complete information about the employees.

select * from employees where date_format(HIRE_DATE,"%Y") < '1991'; -- %Y get year in 4 numbers like in employees table 

-- 10. Write a SQL query to compute the average salary of those employees 
-- who work as ‘shipping clerk’. Return average salary.

select avg(employees.SALARY) as AVERAGE_SALARY from employees -- using average(avg) function
inner join jobs on employees.JOB_ID = jobs.JOB_ID where JOB_TITLE = 'Shipping Clerk'; -- job_id is common among both tables  


