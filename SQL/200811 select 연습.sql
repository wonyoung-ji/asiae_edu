select * from usertbl;
select * from buytbl;

-- 키가 170이상인 레코드 출럭
select * from usertbl where height>=170;

-- usertbl 입사일자가 2010이상인 레코드
select * from usertbl where mdate>='2010-1-1';

-- usertbl 1년 후 예상 키 출력: 현재키 + 10
-- 필드명 바꾸기 : as
-- 필드명에 공백이 있을 경우 ''로 묶기
select *, height+10 as '1년 후 키' from usertbl;

-- usertbl 생일이 1970년 미만이거나 주소가 전남인 레코드:alter
select * from usertbl where birthYear < 1970 or addr = '전남';

-- 입사일에서 년도가 2010년 초과하는 레코드 출력: year(날짜필드)
select * from usertbl where year(mdate)>2010;

-- mobile1의 값이 null인 것
select * from usertbl where mobile1 is null;

-- moibile1의 값이 null이 아닌 것
select * from usertbl where mobile1 is not null;

-- 성이 조씨인 레코드 출력
-- % :공백포함 모든 값
-- _:글자 하나
select * from usertbl where name like '조%'  -- 조로 시작하는 모든 것

-- world에서, country 중 East로 끝나는 것
use country;
select * from country where Region like '%East';

-- name 필드에 en 문자열 있는 레코드 출력
select * from country where name like '%en%';
select * from country where name like 'ar%';

-- name 필드에서 ar로 시작하면서 길이가 5인 레코드만 출력
select * from country where name like 'ar___';
select * from country where name like 'ar%' and length(name)=5;

-- country 테이블에서 100개 추출
select * from country limit 100;

-- country 테이블 이름 순으로 출력
-- 정렬(오름차순:default,내림차순:descending)
select * from country order by name, code desc limit 100;

-- country에서 코드, 이름, 지역, capita
-- 조건=gnp가 10000이상
-- code 내림차순 정렬, 50개
select code, name, region, capital from country
where GNP>=10000 order by code desc limit 50 ;





