
select last_name, job_id 
from employees
where job_id  in (select job_id
                from employees
                where last_name = 'Davies')
and last_name not like 'Davies';

