-- select쿼리_join
use sqldb;
-- 1
select * from usertbl as u join buytbl as b on u.userid = b.userid; 
			-- where문으로 조인하기: select * from usertbl as u, buytbl as b where u.userid=b.userid;
select * from usertbl as u join buytbl as b on u.userid = b.userid where u.userid='jyp';
select u.userid, name, addr, concat(mobile1,mobile2) as 연락처, prodname, price, amount, price*amount as 총금액
from usertbl as u
join buytbl as b
on u.userid = b.userid
where u.userid='jyp';

-- 구매이력이 있는 사람
select userid, name, addr from usertbl where userid in (select distinct userid from buytbl);
select distinct u.userid, name, addr from usertbl as u join buytbl as b where b.userid = u.userid;
select u.userid, name, addr from usertbl as u where exists (select b.userid from buytbl as b where u.userid = b.userid); -- 하위 쿼리에서만 b 사용가능

-- 구매이력이 없는 사람
 select userid, name, addr from usertbl where userid not in (select distinct userid from buytbl);
 select u.userid, name, addr from usertbl as u where not exists (select b.userid from buytbl as b where u.userid = b.userid);



-- 2
create database joinExDB;
use joinexdb;

create table stdTbl(stdName varchar(10), addr char(4), primary key (stdName));
create table clubTbl(clubName varchar(10), roomNo char(4), primary key(clubName));
create table stdclubTbl(num int auto_increment, stdName varchar(10), clubName varchar(10), primary key (num), foreign key(stdName) references stdtbl(stdname), foreign key(clubName) references clubtbl(clubName)) ;


insert stdTbl values('김범수', '경남');
insert stdTbl values('성시경', '서울');
insert stdTbl values('조용필', '경기');
insert stdTbl values('은지원', '경북');
insert stdTbl values('바비킴', '서울');

insert clubtbl values('수영', '101호');
insert clubtbl values('바둑', '102호');
insert clubtbl values('축구', '103호');
insert clubtbl values('봉사', '104호');


insert stdclubtbl values(default, '김범수', '바둑');
insert stdclubtbl values(default, '김범수', '축구');
insert stdclubtbl values(default, '조용필', '축구');
insert stdclubtbl values(default, '은지원', '축구');
insert stdclubtbl values(default, '은지원', '봉사');
insert stdclubtbl values(default, '바비킴', '봉사');



-- 3
	-- 1
select sc.stdName, s.addr, sc.clubName, c.RoomNo from stdclubTbl as sc 
join clubTbl as c on c.clubName = sc.clubName
join stdTbl as s on s.StdName = sc.stdName;
	-- 2
select sc.stdName, s.addr, sc.clubName, c.RoomNo from stdclubTbl as sc 
join clubTbl as c on c.clubName = sc.clubName
join stdTbl as s on s.StdName = sc.stdName
where sc.stdName='김범수';
	-- 3
select count(distinct s.stdName) '가입한 학생 수' from stdTbl s join stdclubTbl sc on s.stdName = sc.stdName;
select count(*) '가입한 학생 수' from stdTbl s where s.stdName in (select distinct sc.stdName from stdclubTbl sc);
select count(s.stdName)'가입한 학생 수' from stdTbl s where exists (select sc.stdName from stdclubTbl sc where sc.stdName = s.stdName);
	-- 4
select count(s.stdName) '가입하지 않은 학생 수' from stdTbl s where s.stdName not in (select sc.stdname from stdclubTbl sc where sc.stdname = s.stdname); 
select count(s.stdName) '가입하지 않은 학생 수' from stdTbl s where not exists (select sc.stdname from stdclubTbl sc where sc.stdname = s.stdname);



-- 4
select s.stdName '동아리 미 가입학생' from stdtbl s left outer join stdclubtbl sc on s.stdName = sc.stdName where num is null;
select s.stdName '동아리 미 가입학생' from stdclubTbl sc right outer join stdTbl s on s.stdName = sc.stdName where num is null;
select c.clubName '가입학생이 하나도 없는 동아리' from clubTbl c left outer join stdclubTbl sc on sc.clubName = c.clubName where num is null;
select c.clubName '가입학생이 하나도 없는 동아리' from stdclubtbl sc right outer join clubtbl c on c.clubName = sc.clubName where num is null;







-- select쿼리_join-연습문제
use employees;
-- 1
select * from employees e join titles t on e.emp_no = t.emp_no;
-- 2
select * from employees e join titles t on e.emp_no = t.emp_no where e.emp_no=10007;
-- 3
select concat(e.first_name,' ', e.last_name) 이름, t.title 직책 from employees e join titles t on e.emp_no = t.emp_no where e.emp_no=10007 and t.to_date>curdate();
-- 4
select concat(e.first_name,' ', e.last_name) 이름, e.hire_date 입사일자, timestampdiff(year,de.from_date,curdate()) 근무년수
from dept_emp de
join departments d on d.dept_no = de.dept_no
join employees e on e.emp_no=de.emp_no
where d.dept_name = 'Finance' and de.to_date > curdate();
-- 5
select concat(e.first_name,' ', e.last_name) 이름, e.hire_date 입사일자, timestampdiff(year,de.from_date,curdate()) 근무년수
from dept_emp de, departments d, employees e
where d.dept_no = de.dept_no and e.emp_no=de.emp_no and d.dept_name = 'Finance' and de.to_date > curdate();
				 /* 
					<join없이>
					 하부쿼리: select dep_no from departments where dep_name='Finanace'
					 중간쿼리: select emp_no from dept_emp where dept_no=
                     상부쿼리: select concat(first_name,' ', last_name) 이름, hire_date 입사일자, timestampdiff(year,hire_date,curdate()) 근무년수 from employees where emp_no in 
					 --> select concat(first_name,' ', last_name) 이름, hire_date 입사일자, timestampdiff(year,hire_date,curdate()) from employees where emp_no in (select emp_no from dept_emp where dept_no=(select dep_no from departments where dep_name='Finanace') and to_date>curdate());
                  */   
select concat(first_name,' ', last_name) 이름, hire_date 입사일자, timestampdiff(year,hire_date,curdate()) 근무년수 from employees where emp_no in (select emp_no from dept_emp where dept_no = (select dept_no from departments where dept_name='Finance') and to_date>curdate());
-- 6
select concat(e.first_name,' ', e.last_name) 이름, d.dept_name 부서, t.title 직책, s.salary 급여
from dept_emp de
join employees e on de.emp_no = e.emp_no
join salaries s on de.emp_no = s.emp_no
join titles t on de.emp_no = t.emp_no
join departments d on d.dept_no = de.dept_no
where t.to_date>curdate() and salary = (SELECT max(salary) FROM salaries);
-- 7
select concat(e.first_name,' ', e.last_name) 이름, d.dept_name 부서, t.title 직책, s.salary 급여
from dept_emp de, employees e, salaries s, titles t, departments d
where de.emp_no = e.emp_no and de.emp_no = s.emp_no and de.emp_no = t.emp_no and d.dept_no = de.dept_no and t.to_date>curdate() and salary = (SELECT max(salary) FROM salaries);
				/* 
                select max(salary) from salaries where to_date > curdate()
                select emp_no from employees where salary=(select max(salary) from salaries where to_date > curdate())
                */
-- 8
select concat(e.first_name,' ', e.last_name) 이름, de.from_date 입사일자, de.to_date 퇴사일자
from dept_emp de
join employees e on de.emp_no = e.emp_no
where e.emp_no in (select emp_no from dept_emp where emp_no not in (SELECT emp_no FROM employees.dept_emp where to_date>curdate()));

