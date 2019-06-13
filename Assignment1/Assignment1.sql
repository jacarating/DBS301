/* Display the employee number, full employee name, job and hire date of all  employees hired in May or November of any year, with the most recently   
hired employees  displayed first. Also, exclude people hired in 1994 and  1995. Full name should be in the form Lastname, Firstname  with an 
alias called Full Name. Hire date should point to the last day in May or November of that year (NOT to the exact day) and be in the form like 
shown below with the heading Start Date.  Do NOT use LIKE operator.  You should display ONE row per output line by limiting the width of the 
Full Name to 25 characters. The output lines should look like this line:    
174   Abel, Ellen   SA_REP [May 31st of 1996]   */

select substr(employee_id,1,3) "ID" , substr(last_name || ', ' || first_name,1, 25) "Full Name" , job_id "Job" ,
to_char(last_day(hire_date),'"["fmMonth DDth "of" YYYY"]"') "Start Date"
from employees
where (to_char(hire_date, 'MM') = 05 or to_char(hire_date, 'MM') = 11)
and to_char(hire_date, 'YYYY') not in ('1994', '1995');

/* List the employee number, full name, job and the modified salary for all employees whose monthly earning (without this increase) is outside the 
range $6,000 – $11,000  and who are employed as Vice Presidents or Managers (President is not counted here). You should use Wild Card characters for this.  
VP’s will get 30% and managers 20% salary increase. Sort the output by the top salaries (before this increase) firstly. Heading will be like 
Employees with increased Pay The output lines should look like this sample line: 
 
Emp# 124 : Kevin Mourgos is ST_MAN and will get a new salary of $6,960 */

select 'Emp# ' ||employee_id|| ' : '||''|| first_name ||' '|| last_name ||' is '|| job_id ||' and will get a new salary of $' ||''||
case job_id when 'AD_VP' then salary * 1.30
            when 'AC_MGR' then salary * 1.30
            when 'SA_MAN' then salary * 1.20
            when 'MK_MAN' then salary * 1.20
            when 'ST_MAN' then salary * 1.20
            else salary end "Employees with increased Pay"
from employees
where (salary not between 6000 and 11000) 
and (job_id like '%VP' or job_id like '%MAN' or job_id like '%MGR')
order by salary desc;



/* Display the employee last name, salary, job title and manager# of all  employees not earning a commission OR if they work in  SALES department, 
but only if their total monthly salary with $1000 included bonus and  commission (if  earned) is  greater  than  $15,000.   
Let’s assume that all employees receive this bonus. If an employee does not have a manager, then display the word NONE  instead. 
This column should have an alias Manager#. Display the Total annual salary as well in the form of $135,600.00 with the  heading  Total Income. 
Sort the result so that best paid employees are shown first.   The output lines should look like this sample line: 
De Haan 17000 AD_VP 100  $216,000.  */

select e.last_name "Last Name" , e.salary , e.job_id "Job Title" , nvl(to_char(e.manager_id), 'NONE') "Manager#", 
to_char(((e.salary + 1000) * 12) * (1 + nvl(e.commission_pct, 0)), '$999,999.99') "Total Income" 
from employees e
left join employees m
on m.employee_id = e.manager_id
where (e.commission_pct is null or e.department_id = 80)
and ((e.salary + 1000) * (1 + nvl(e.commission_pct, 0))) > 15000
order by 2 desc;



/* Display Department_id, Job_id and the Lowest salary for this combination under the alias Lowest Dept/Job Pay, but only if that Lowest Pay falls in the 
range $6000 - $18000.  Exclude people who work as some kind of Representative job from this query and departments IT and SALES as well.           
Sort the output according to the Department_id and then by Job_id. You MUST NOT use the Subquery method.   */

select department_id ||' '||  job_id ||' '||  min(salary) "Lowest Dept/Job Pay"
from employees
group by department_id, job_id
having (min(salary) between 6000 and 18000)
and (job_id not like '%REP' and department_id not in (60, 80))
order by department_id, job_id;

/*Display last_name, salary and job for all employees who earn more   than all lowest paid employees per department outside the US locations.           
Exclude President and Vice Presidents from this query.           
Sort the output by job title ascending.           
You need to use a Subquery.  */

select last_name, salary, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where e.job_id not in ('AD_PRES', 'AD_VP')
and salary > Any (select min(salary)
                from employees e
                join departments d
                on e.department_id = d.department_id
                join locations l
                on d.location_id = l.location_id
                group by e.department_id, l.country_id
                having l.country_id not like 'US')
order by 3;


/* Who are the employees (show last_name, salary and job) who work either in IT or MARKETING department and earn more than the worst paid person in the ACCOUNTING 
department. Sort the output by the last name alphabetically. You need to use ONLY the Subquery method (NO joins allowed).   */

select last_name, salary, job_id
from employees
where department_id in(20, 60)
and salary > any (select min(salary)
                  from employees
                  where department_id = 110)
order by last_name;


/* Display alphabetically the full name, job, salary  (formatted as a currency   amount incl. thousand separator, but no decimals) and department number  for each 
employee who earns less than the best paid unionized employee  (i.e. not the president nor any manager nor any VP),  and who work in either SALES or MARKETING department. 
Full name should be displayed as Firstname  Lastname and should have the heading Employee. Salary should be left-padded with the & symbol till the width of 10 characters. 
It should have an alias Salary.  You should display ONE row per output line by limiting the width of the   Employee to 25 characters. 
The output lines should look like this sample line: 
  Jonathon Taylor  SA_REP    &&&& $8,600  80 */

select substr(first_name ||' '|| last_name,0,25) "Employee", job_id, lpad(to_char(salary,'$999,999'), 13, '&') "Salary",  department_id
from employees
where salary < any (select max(salary)
                    from employees
                    where job_id not in ('AD_PRES','AD_VP','AC_MGR','%MAN'))
and department_id in (20, 80)
order by 1;


/* “Tricky One” 
Display department name, city and number of different  jobs in each department. If city is null, you should print Not Assigned Yet.  This column should have alias City.           
Column that shows # of different jobs in a department should have the   heading # of Jobs You should display ONE row per output line by limiting the width of the   City to 25 characters. 
You need to show complete situation from the EMPLOYEE point of view,     meaning include also employees who work for NO department (but do NOT display empty departments)
and from the CITY point of view meaning you need to  display all cities without departments as well. 
You need to use Join method.  */

select department_name, substr(nvl(city,'Not Assigned Yet'),0,25) "City", count(e.job_id) "# of Jobs"
from departments d
right join employees e 
on e.department_id = d.department_id
full join locations l
on l.location_id = d.location_id 
group by department_name, substr(nvl(city,'Not Assigned Yet'),0,25)
