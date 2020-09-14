-- 1
select * from employees.departments;
select * from employees.dept_emp;
select * from employees.dept_manager;
select * from employees.employees;
select * from employees.salaries;
select * from employees.titles;


-- 2
select * from employees.employees where emp_no >=400000;
select * from employees.employees where birth_date = '1960-7-28';
select * from employees.employees where first_name='Karlis';
select * from employees.employees where gender <> 'F';

-- 3
select * from employees.employees where emp_no >= 200000 and emp_no<=300000;
select * from employees.employees where year(hire_date)='1985' or year(hire_date)='1990';
select * from employees.employees where gender='F' and birth_date <='1990-5-20';

-- 4
select first_name, last_name, gender from employees.employees where emp_no >= 400000;
select first_name, last_name, gender from employees.employees where birth_date='1960-7-28';
select first_name, last_name, gender from employees.employees where first_name='Karlis';
select emp_no, salary, salary+salary*0.1 from employees.salaries limit 1000;
select first_name, last_name, gender from employees.employees where not gender = 'F';

-- 5
select first_name, last_name, gender from employees.employees where emp_no >= 400000;
select concat(first_name, ' ', last_name) as '이름', gender from employees.employees;
 -- 퇴사자 내 풀이...
select employees.dept_emp.emp_no, employees.dept_emp.from_date, employees.dept_emp.to_date, employees.employees.last_name, employees.employees.first_name
from employees.employees
join employees.dept_emp
on employees.dept_emp.emp_no = employees.employees.emp_no
where employees.dept_emp.to_date <= now() order by emp_no;

-- 6
select emp_no, last_name, first_name from employees.employees where emp_no>300000 and gender='M' order by last_name;
select emp_no, last_name, first_name from employees.employees where emp_no>300000 and gender='M' order by last_name, first_name desc;
select emp_no, last_name, first_name from employees.employees where last_name like'%on%' order by last_name desc, first_name ; 

-- 퇴사자 선생님 풀이
select * from dept_emp where emp_no not in (
select distinct emp_no from dept_emp where to_date>curdate()
);








-- 1
select * from employees.titles where emp_no<100000;
select * from employees.titles where title='Engineer';
select *from employees.titles where from_date>='2000-1-1';
select * from employees.titles where year(from_date) <> '9999'; 


-- 2
select * from employees.titles where emp_no > 400000 or emp_no<1000;
select * from employees.titles where title = 'Senior Engineer' and month(from_date) = 5;
select * from employees.titles where to_date between'2000-1-1' and '2001-12-31';


-- 3
select emp_no as '사원번호', title as '직급' from employees.titles where emp_no>=40000 or emp_no<1000;
select emp_no as '사원번호', title as '직급', from_date as '시작일자' from employees.titles where title='Staff' or month(from_date)=11;
select emp_no as '사원번호', title as '직급' , from_date as '종료일자' from employees.titles where year(to_date)=2001 or year(to_date)=2002;

-- 4
select emp_no, title from employees.titles where emp_no > 450000 and title = 'Assistant Engineer' order by title;
select emp_no, last_name, first_name from employees.employees where emp_no>300000 and gender='M' order by last_name, first_name desc;
select emp_no, title from employees.titles where title like '%Staff%' order by emp_no desc, title;
