/*1. Display the department name, city, street address and postal code for all departments. 
Use the JOIN and USING form of syntax. Sort the output by department name descending. */
select department_name, city, street_address, postal_code
from locations
join departments
using (location_id)
order by 1 desc;


/*2.  Display full name of the employees, their hire date and salary together with  their department name, 
but only for departments which names start with A or S. 
Full name should be in format of : First / Last. Use the JOIN and ON form of syntax. 
Sort the output by department name and then by last name. */
select first_name ||' / '|| last_name "Full Name" , hire_date, salary, department_name
from employees
join departments
on departments.department_id = employees.department_id
where department_name like 'A%' or department_name like 'S%'
order by 4, last_name;
 
/*3.  Display full name of  the manager of each department in provinces Ontario,  California and Washington 
plus department name, city, postal code and province name. 
Full name should be in format of : Last,  First.  
Use the JOIN and ON form of syntax. Sort the output by city and then by department name.  */
select e.last_name ||', '|| e.first_name "Full Name", department_name, city, postal_code, state_province
from locations l
join departments d
on d.location_id = l.location_id
join employees e
on e.employee_id = d.manager_id
where state_province in ('Ontario','California', 'Washington')
order by city, department_name;

 
/*4.  Display the department name and Highest, Lowest and Average pay per each department. 
Name these results High, Low and Avg.      
Use JOIN and ON form of the syntax.      
Sort the output so that department with highest average salary are shown first. */
select d.department_name, max(salary) "Highest" , min(salary) "Lowest" , round(avg(salary), 2) "Average"
from employees e
join departments d
on d.department_id = e.department_id
group by department_name
order by 2 desc;

 
/*5.  Display the employee last name and employee number along with their manager’s last name 
and manager number. 
Label the columns Employee, Emp#, Manager, and Mgr#, respectively.  */
select e.last_name "Employee", e.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
from employees e 
inner join employees m
on m.employee_id = e.manager_id



