use sqldb;
insert usertbl values('kdong', '홍길동', 1725, '강원', '010', '12341234', 172, curdate());
-- 참조 무결성 제약조건 위배
insert buytbl values(default, 'kdong', '운동화', null,30,15);

update buytbl set groupname='전자제품' where groupname='전자';
update buytbl set amount=5 where num=8;
update buytbl set price=price*1.1 where prodname='모니터';

delete from buytbl where num=5;
delete from usertbl where userid='BBK';



