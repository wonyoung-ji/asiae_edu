-- 1
use employees;
select * from employees where birth_date < (select birth_date from employees where emp_no = '10010');
select * from employees where birth_date > (select birth_date from employees where first_name='Magy' and hire_date='1995-9-26');
select * from employees where birth_date > any (select birth_date from employees where first_name='Magy' and hire_date>='1995-09-26');
select * from employees where birth_date > all (select birth_date from employees where first_name='Magy' and hire_date>='1995-09-26');
select * from employees where birth_date in (select birth_date from employees where first_name='Magy' and hire_date>='1995-09-26');

-- 2
select title from titles limit 1000; 
select distinct title from titles limit 1000;
select countrycode from world.city limit 2000;
select distinct countrycode from world.city limit 2000;

-- 3
select * from dept_emp where dept_no <> 'd005' order by from_date, to_date limit 150;
select * from employees where gender='M' and (first_name='Parto' or last_name like '%ford%') order by last_name limit 5;
select * from salaries limit 40,10;

-- 4
create table copy_dept_emp (select * from dept_emp limit 1500);
create table copy_titles (select emp_no, title, from_date from titles order by title, emp_no limit 1300);






-- 1
select count(*) as '모든 테이블의 레코드 개수' from employees;
select count(*) as '남성사원' from employees where gender='M';
select count(*) as '여성사원' from employees where gender='F';
select gender, count(*) as '인원수' from employees group by gender;
select count(distinct emp_no) from salaries where salary between 60000 and 70000;
 -- select count(*) from (select distinct emp_no from salaries where salary between 60000 and 70000) as temp;
 -- temp라는 임시 테이블 만듦 ( temp는 변수 )
select dept_no as 부서명, count(*) as 사원수 from dept_emp group by dept_no;
select dept_no as 부서명, count(*) as 재직자수 from dept_emp where to_date > curdate() group by dept_no order by 재직자수;

select count(*) from world.country where indepYear is not null;
select count(IndepYear) from world.country; -- count는 null 값을 세지 않음
-- select count(*) from (select indepyear from world.country where indepyear is not null) as temp;
select count(region) from world.country;
select count(distinct region) from world.country;
select countrycode, count(distinct district) from world.city group by countrycode order by countrycode desc;

-- 2
select sum(salary), max(salary), min(salary), avg(salary), stddev(salary), var_samp(salary) from employees.salaries;
select emp_no as 사원, sum(salary), max(salary), min(salary), avg(salary), stddev(salary), var_samp(salary) from employees.salaries group by emp_no;
select * from employees.salaries where salary > (select avg(salary) from employees.salaries);
select count(*) from employees.salaries where salary > (select avg(salary) from employees.salaries);

-- 3
select countrycode, name, sum(population) as 인구수 from world.city group by countrycode, name with rollup order by countrycode;





select gender,
case
	when gender='F' then '여자'
    when gender='M' then '남자'
end as 성별,
count(*) as 인원수
from employees
group by gender;
