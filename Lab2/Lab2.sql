/*1. Write a query to display the tomorrow’s date. Your result will depend on the day when you create this query. 
Label the column Tomorrow. */
select sysdate + 1 "Tomorrow"
from dual;


/*2.  For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary increased by 7% and expressed as a whole number. 
Label the column Good Salary. Also add a column that subtracts the old salary from the new salary and multiplies by 12. 
Label the column  Annual Pay Increase.*/
select last_name, first_name, salary, round(salary * (1.07)) "Good Salary", round(((salary * 1.07) - salary)* 12) "Annual Pay Increase"
from employees
where department_id in (20, 50, 60);


/*3.  Write a query that displays the employee’s Full Name and Job Title in the following format: DAVIES, CURTIES is Store Clerk  for all employees 
whose last name ends with s and first name starts with  C or K. 
Give this column an appropriate label like Person and Job 
Sort the result by the employees’ last names. */
select upper(last_name ||', '|| first_name) || ' is '|| job_title "Person and Job"
from employees
join jobs
on employees.job_id = jobs.job_id
where last_name like '%s' 
and (first_name like 'C%' or first_name like 'K%')
order by last_name;


/*4.  For each employee hired before 1992, display the employee’s last name, hire date and calculate the number of YEARS between TODAY 
and the date the employee was hired. Label the column Years worked.  Order your results by the number of years employed.  
Round the number of years up to the closest whole number. */
select last_name, hire_date, round((sysdate - hire_date)/356) "Years worked"
from employees
where to_char(hire_date, 'YYYY') < 1992
order by 3 desc;


/*5.  Create a query that displays the city names, country codes and state province names, but only for those cities that start on S and have 
at least 8 characters in their name. If city does not have province name assigned, then put Unknown Province. */
select city, country_id, nvl(state_province, 'Unknown Province')
from locations
where city like 'S_______%';