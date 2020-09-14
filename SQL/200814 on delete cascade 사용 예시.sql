create database JoinExDB3;
use JoinExDB3;
CREATE TABLE stdtbl 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);
CREATE TABLE clubtbl 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubtbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName) on delete cascade  -- clubtbl의 clubname이 사라지면 stdclubtbl의 해당하는 값도 사라짐
);
INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), 
('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'),
 ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'),
 (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');


delete from clubtbl
where clubName='바둑';

delete from stdtbl    -- on delete cascade 해당하지 않으므로 참조 무결성 조건
where stdname='김범수';

delete from stdtbl    -- 성시경을 참조하는 값이 없으므로 삭제 가능
where stdname='성시경'; 
