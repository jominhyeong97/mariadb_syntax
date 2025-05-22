-- insert : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(3, 'hong3', 'hong3@naver.com'); --문자열은 일반적으로 작은따옴표 사용

-- update : 테이블에 데이터 변경
update author set name = "홍길동", email = "hong100@naver.com" where id = 3;

-- select : 조회
select 컬럼1, 컬럼2 from 테이블명;
select name, email form author;
select * from author;

-- delete : 삭제
delete from 테이블명 where 조건절;
delete from author where id = 3;

-- select 조건절 활용 조회
-- 테스트 데이터 삽입
-- insert문을 활용해서 author 데이터 3개, post 데이터 5개
    insert into author(id, name, email, password, address) values(2, 'hong2', 'hong2@naver.com', '1234', '강서구');
    insert into author(id, name, email, password, address) values(3, 'hong3', 'hong3@naver.com', '1235', '강동구');
    insert into author(id, name, email, password, address) values(4, 'hong4', 'hong4@naver.com', '1236', '강남구');

    insert into post(id, title, author_id) values(2, 'dkdk', 'hon2');

select * from author where id=1;
select * from author where name = 'hong2';
select * from author where id>3;
select * from author where id>2 and name='hong4';

-- 중복제거 조회 : distinct
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- asc : 오름차순, desc : 내림차순 (디폴트는 오름차순)
-- 아무런 정렬조건 없을시 pk 조건으로 오름차순
select * from author order by name;

-- 멀티컬럼 order by : 여러컬럼으로 정렬시에, 먼저 쓴컬럼 우선정렬. 중복시, 그다음 정렬옵션적용
select * from author order by name desc, email asc; --name으로 먼저 정렬후, name이 중복되면 email로 정렬.

-- 결과값 개수 제한
select * from author order by id desc limit 1;

-- 별칭(alias)를 이용한 select
select name as '이름', email as '이메일' from author;
select name a.email, a.name from author as a; --두 테이블을 결합했을 때 쿼리를 줄이기 위해 사용
select name email , name from author a;

-- null을 조회조건으로 활용
select *from author where password is null;
select *from author where password is not null;