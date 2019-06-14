/*1. Display last name and job id for all employees who perform the same job as Davies. Exclude Davies from this query. */
select last_name, job_id 
from employees
where job_id = (select job_id 
                from employees
                where last_name like 'Davies')
and last_name not like 'Davies';


/*2. Display last name, job id and hire date for all employees hired after Grant. Sort the output by the most recent hire date. */
select last_name, job_id, hire_date
from employees
where hire_date > (select hire_date
                    from employees
                    where last_name like 'Grant')
order by hire_date desc;


/*3. Display city, province name and postal code for all departments located in countries that start with letter I (meaning  Italy, Israel and India). 
If the province is blank, show message Unknown and the heading should be Province. Sort the output by city ascending.  */
 select city, nvl(state_province, 'Unknown') "Province" , postal_code
 from locations
 where country_id in (select country_id
                        from countries
                        where country_name like 'I%')
order by city;


/*4. Display last name, job id and salary for all employees who earn less than the Average salary in the Sales department. 
Do NOT use Join method. Sort the output by top salaries first and then by job_title. */
select last_name, job_id, salary
from employees
where salary < any (select avg(salary)
                    from employees
                    where department_id = (select department_id
                                           from departments
                                           where department_name like 'Sales'))
order by 3 desc, job_id;


/*5. Display last name, job id and salary for all employees whose salary matches any of  the salaries from the IT Department.  
Sort the output by salary ascending first and then by last_name. */
select last_name, job_id, salary
from employees
where salary in (select salary
                  from employees
                  where department_id = (select department_id
                                        from departments
                                        where department_name like 'IT'))
order by salary, last_name;                  


/*6. Display last name and salary for all employees who earn less than the Lowest salary in ANY department.  
Sort the output by top salaries first and then by last name. */
select last_name, salary
from employees
where salary < any (select min(salary)
                    from employees
                    group by department_id)
order by salary desc, last_name;
 