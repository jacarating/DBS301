/*1. The following SELECT statement executes successfully: 
SELECT last_name “LName”, job_id “Job Title”,         
Hire Date “Job Start” 
FROM employees;
True  / False */
/* False because column name is incorrect. Hire Date should be hire_date.*/


/* 2. There are coding errors in this statement. 
 Can you identify them? 
 SELECT employee_id, last name, commission_pct Emp Comm, 
 FROM employees;  */
 /*last name -> last_name, Emp Comm -> "Emp Comm"*/
 
 
/*3. Show the structure of the LOCATIONS table. Then create a query to display the  output shown below. 
Be careful, you need to get the exact output. 
 
City#   City    Province with Country Code  
---------------------------------------------------------------------------------        
1000  Roma                IN THE IT         
1100  Venice              IN THE IT         
1200  Tokyo               Tokyo Prefecture IN THE JP        
1300  Hiroshima           IN THE JP         
1400  Southlake           Texas IN THE US         
1500  South San Francisco California IN THE US 
*/
select * from locations;
select location_id "City#", city, state_province ||' '|| 'IN THE' ||' '|| country_id "Province with Country Code"
from locations
where location_id between 1000 and 1500;


/*4.  Create a query to display unique department codes from the EMPLOYEES table*/
select distinct department_id
from employees;


/*5. Display the employee_id, last name and salary of employees earning in the range of   $8000 to $15,000. 
Sort the output by top salaries first and then by last name. */
select employee_id, last_name, salary
from employees
where salary between 8000 and 15000
order by 3 desc, 2;


/*6. Modify previous query (#5) so that additional condition is to display only if they work as Programmers or Sales Representatives. 
Same sorting as before. */
select employee_id, last_name, salary
from employees
where (salary between 8000 and 15000)
and job_id in (select job_id
                from jobs
                where job_title in ('Programmer','Sales_Representative'))
order by 3 desc, 2;


/*7. Modify previous query (#5) so that displays same job_id but for people who earn outside the given salary range 
i.e., >15000 and <8000. Same sorting as before. */
select employee_id, last_name, salary, job_id
from employees
where salary not between 8000 and 15000
and job_id in (select job_id
                from jobs
                where job_title in ('Programmer','Sales_Representative'))
order by 3 desc, 2;


/*8. Display the last name, job_id and salary of employees hired before 1998  List the most recently hired employees first. */
select last_name, job_id, salary
from employees
where to_char(hire_date, 'YYYY') < 1998
order by hire_date desc;


/*9. Modify previous query (#8) so that displays only employees earning more than $10,000.       
List the output by job_id alphabetically and then by highest paid employees. */
select last_name, job_id, salary
from employees
where to_char(hire_date, 'YYYY') < 1998
and salary > 10000
order by job_id, 3 desc;


/*10. Display the job_ids and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere. */
select job_id, first_name || ' '|| last_name "full name"
from employees
where first_name like '%e%' or first_name like '%E%';