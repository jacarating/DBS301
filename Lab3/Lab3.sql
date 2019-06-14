/*1. Display the difference between the Average pay and Lowest pay in the company among employees. 
Name this result Real Amount. */
select avg(salary) - min(salary) "Real Amount"
from employees;


/*2. Display the department number and Highest, Lowest and Average pay per each department. 
Name these results High, Low and Avg. Sort the output so that department with highest average salary are shown first. */
select department_id, max(salary) "Highest", min(salary)"Lowest", round(avg(salary), 2) "Average"
from employees 
group by department_id
order by 2 desc;

 
/*3. Display how many people work the same job in the same department. Name these results Dept#, Job and HowMany. 
Include only jobs that involve more than one person. Sort the output so that jobs with the most people involved are shown first. */
select department_id "Dept#", job_id, count(employee_id) "HowMany"
from employees
having count(employee_id) > 1
group by department_id, job_id
order by 3 desc;

 
/*4. For each job id display the job id and total amount paid each month for this type of the job. Exclude job_id AD_PRES and AD_VP 
and also include only jobs that require more than $15,000 in total. Sort the output so that top paid jobs are shown first. */
select job_id, sum(salary)
from employees
having job_id not in ('AD_PRES','AD_VP') and sum(salary) > 15000 
group by job_id
order by 2 desc;


/*5. For each manager number display how many persons he / she supervises. Exclude managers with numbers 100, 101 and 102 and 
also include only those managers that supervise more than 2 persons. Sort the output so that manager numbers with the 
most supervised persons are shown first. */
select m.employee_id "Manager ID", count(e.manager_id) "Supervises"
from employees e
inner join employees m
on m.employee_id = e.manager_id
having m.employee_id not in (100,101,102) and count(e.manager_id) > 2
group by m.employee_id, e.manager_id
order by 2 desc;

      
/*6. For each  department show the latest and earliest hire date, but exclude departments 10 and 20 and also exclude 
those departments where the last person was hired in this century. Sort the output so that most recent latest hire dates are shown first. */
select department_id, min(hire_date), max(hire_date)
from employees
having department_id not in(10,20)
and to_char(max(hire_date), 'YYYY') < 2000
group by department_id
order by max(hire_date) desc;