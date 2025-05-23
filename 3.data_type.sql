-- tinyint : -128~127까지 표현
-- int : 4바이트(2의32승)
-- bigint : 8바이트

-- decimal(총자리수, 소수부자리수)
alter table post add column price decimal(10,3);

-- 문자타입 : 고정길이(char), 가변길이(varchar, text)
alter table author add columnn self_introduction text;

-- blob(바이너리데이터) 타입 실습
-- 일반적으로 blob 으로 저장하기 보다 varchar로 설계하고 이미지경로만을 저장함.
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values(7, 'hong7@naver.com', load_file(''))

-- enum 타입 : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입(매우중요)
alter table author add role enum('admin', 'user') not null default 'user';

-- enum에 지정된값이 아닌경우
insert into author (id, email, role) values (10, 'hong10@naver.com', 'admin2');
-- role을 지정 안한경우
insert into author (id, email) values (10, 'hong10@naver.com');
-- enum에 지정된 값인 경우
insert into author (id, email, role) values (11, 'hong11@naver.com', 'admin');

-- date와 datetime 
-- 날짜타입의 입력, 수정, 조회시에 문자열 형식을 사용
alter table author add birthday date;
alter table post add created_time;
insert into post(id, title, author_id, created_time) values (7, 'hihi', 3, '2025-05-23 14:36:30');
alter table post modify created_time datetime not null default current_timestamp();

-- 비교연산자
select * from author where id >= 2 and id <= 4;
select * from author where id in(2,3,4); -- 같은 구문

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
select * from author where name like '%hong%'; --특정데이터에 길이 있는지 ex.길홍동(o),동홍길(o)
select * from post where title like '%h%';

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; --하나라도 한글이 있으면

-- 숫자 > 날짜
select cast(20250523 as date); --2025-05-23(날짜)
-- 문자 > 날짜
select cast('20250523' as date); --2025-05-23
-- 문자 > 숫자
select cast('12' as unsigned); --12

-- 날짜조회 방법(매우중요)
-- like패턴, 부등호 활용, date_format
select * from post where created_time like '2025-05%'; --문자열처럼 조회
-- 5월1일부터 5월20일까지,날짜만 입력시 시간부분은 00:00:00이 자동으로 붙음
select * from post where created_time >= '2025-05-01' and created_time <= '2025-05-21';

select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%m') = '05';

select * from post where cast(date_format(created_time, '%m') as unsigned) = 5;