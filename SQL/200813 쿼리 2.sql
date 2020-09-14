use employees;

-- 1
select *, curdate() as 오늘날짜
from employees
where emp_no between 30000 and 35000
order by last_name desc, first_name desc;
 -- =select *,curdate() as 오늘날짜 from employees where emp_no>=30000 and emp_no < 35000 order by last_name desc, first_name desc;
select *, year(birth_date) as 년, month(birth_date) as 월, day(birth_date) as 일
from employees 
where birth_date between '1960-7-28' and '1960-10-20'
order by birth_date, emp_no desc;

-- 2
select *,year(birth_date) as 년, month(birth_date) as 월, day(birth_date) as 일
from employees
where month(birth_date) in (5,8,11)    -- where 월 in (5,8,11); >>> 사용안됨
order by 년, 월, 일, emp_no desc;
select * 
from employees
where last_name in ('Deyuan', 'Perly', 'Zockler', 'Angelopoulos') and gender = 'F';

-- 3
select * from employees where last_name like 'Den%';
select * from employees where last_name like '%Den%';
select * from employees where first_name like '%ina';
select * from employees where last_name like 'Den%' and length(last_name)=5;
select * from employees where last_name like '__________';
select * from employees where length(last_name)=10;




-- 1
select * from dept_emp where emp_no between 20000 and 30000;
select * from salaries where salary between 50000 and 60000 order by salary desc;

-- 2
select * from dept_emp where dept_no in ('d001', 'd005', 'd009');
select * from dept_emp where to_date > curdate() and month(from_date) in (1,5,8,12);
select * from dept_emp where month(from_date) in (1,5,8,12) and emp_no in (select emp_no from dept_emp where to_date > curdate());

-- 3
select * from titles where title like 'Senior%';
select * from titles where title like '%sis%';
select * from titles where title like '%staff';
select * from titles where title like 'sta%' and length(title)=5;
select * from titles where title like '________';
select * from titles where length(title) >= 18;




-- 1
select * from employees where birth_date > (select birth_date from employees where first_name = 'Greger' and last_name = 'Angelopoulos') order by birth_date;
 -- 하위 쿼리의 값이 2개 이상이 나올 때 (1961-1-1, 1962-10-21 나옴)
select * from employees where birth_date = any (select birth_date from employees where first_name = 'Aamer' and lasT_name = 'Bahl');
select * from employees where birth_date in (select birth_date from employees where first_name = 'Aamer' and lasT_name = 'Bahl');

-- 2
select emp_no from salaries where salary < 40000; -- 11711
select distinct emp_no from salaries where salary < 40000;  -- 9958

select emp_no, salary from salaries where salary < 40000; -- 11711
select distinct emp_no, salary from salaries where salary < 40000; -- 11709

select language from world.countrylanguage;  -- 984
select distinct language from world.countrylanguage; -- 457

-- last_name + first_name이 같은 사람 순으로 정렬
select concat(last_name, first_name) as 이름 from employees order by 이름; -- 300024
select distinct concat(last_name, first_name) as 이름 from employees order by 이름; -- 279408
select distinct last_name, first_name as 이름 from employees order by 이름;  -- 279408

-- 3
select emp_no from salaries where salary<40000 order by emp_no limit 100;
select * from employees where gender='F'order by last_name limit 50;
select * from employees order by last_name limit 21, 10; 	-- limit offset, 크기
select * from employees order by last_name limit 31;

-- 4
create table copy_salaries (select * from salaries limit 500);
create table copy_employees (select * from employees order by first_name, last_name limit 300);

create table copy_salaries2 (select *, salary*2 as 희망급여 from salaries limit 500);






use sqldb;
select userid, sum(amount)as 총금액, avg(amount) as 평균, max(amount), min(amount) 
from buytbl where avg(amount)>=4
group by userid -- having 평균 >= 4 
order by 총금액;

-- count 함수 행의 개수 세는 함수 * : 모든 행의 개수
select count(*) as '구매테이블의 행 개수' from buytbl;
select count(num) as '구매테이블의 행의 개수', count(groupname) as 'groupname 행의 개수' from buytbl;

select groupname, num, sum(price*amount) as 비용 
from buytbl 
group by groupname, num with rollup;





