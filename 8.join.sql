-- inner join
-- 두 테이블사이에 지정된 조건에 맞는 레코드만을 반환. on 조건을 통해 교집합찾기
-- 즉, post 테이블에 글쓴적이있는 author와 글쓴이가 author에 있는 post 데이터를 결합하여 출력
    select * from author inner join post on author.id = post.author_id;
    select * from author (as) a inner join post (as) p on a.id = p.author_id;
-- 출력순서만 달라질뿐 위 쿼리와 아래쿼리는 동일
    select * from post p inner join author a on a.id = p.author_id;
-- 만약 출력순서 까지 같게 하고 싶다면
    select a.*, p.* from post p inner join author a on a.id = p.author_id;
    
-- 글쓴이가 있는 글 전체 정보와 글쓴이의 이메일만 출력하시오.
-- post중에 글쓴이가 없는 데이터 제외, 글쓴이중에 글쓴적없는 사람도 제외.
select p.*, a.email from post p inner join author a on a.id = p.author_id;

-- 글쓴이가 있는 글의 제목, 내용, 그리고 글쓴이의 이름만 출력하시오.(title, content, name)
select p.title, p.content, a.name from post p inner join author a on a.id=p.author_id;

-- a left join b : a테이블의 데이터는 모두조회하고, 관련있는(on조건) b데이터도 출력.
-- 글쓴이는 모두 출력하되, 글을 쓴적있다면 관련글도 같이 출력
select * from author a left join post p on a.id=p.author_id;

-- 모든 글목록을 출력하고, 만약 저자가 있다면 이메일정보를 출력.
select p.* from post p left join author a on a.id=p.author_id;

-- 모든 글목록을 출력하고, 관련된 저자정보 출력.(author_id가 not null이라면)
-- 아래 두 쿼리는 동일
select * from post p inner join author a on a.id=p.author_id;
select * from post p left join author a on a.id=p.author_id;

-- 실습)글쓴이가 있는 글 중에서 글의 title과 저자의 email을 출력하되, 저자의 나이가 30세 이상인글만 출력.
select p.title, a.email from post p inner join author a on a.id=p.author_id where a.age >= 30;

-- 전체 글 목록을 조회하되, 글의 저자의 이름이 비어져 있지 않은 글목록만을 출력.
select * from post p left join author a on a.id = p.author_id where a.name is not null;

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT b.BOOK_ID, a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE, "%Y-%m-%d") as PUBLISHED_DATE 
from BOOK b inner join AUTHOR a on b.AUTHOR_ID = a.AUTHOR_ID where b.CATEGORY = '경제' order by b.PUBLISHED_DATE;

-- 없어진 기록 찾기
SELECT o.ANIMAL_ID, o.NAME 
from ANIMAL_OUTS o left join  ANIMAL_INS i on o.ANIMAL_ID = i.ANIMAL_ID where i.ANIMAL_ID is null ORDER BY i.ANIMAL_ID ;

-- union : 두 테이블의 select 결과를 횡으로 결합(기본적으로 distinct가 적용)
-- union 시킬 때 컬럼의 개수와 컬럼의 타입이 같아야함 
select name, email from author union select title, content from post;
-- union all : 중복까지 모두 포함
select name, email from author union all select title, content from post;

-- 서브쿼리(중요) : select문 안에 또다른 select문
-- where절 안에 서브쿼리
-- 한번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id=p.author_id;
select * from author where id in(select author_id from post);

-- 컬럼 위치에 서브쿼리
-- author의 email과 author 별로 본인의 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id=a.id) from author a 

-- from절 위치에 서브쿼리
select a.* from (select * from author where id>5) as a;

-- group by 컬럼명 : 특정 컬럼으로 데이터를 그룹화 하여, 하나의 행(row)처럼 취급
select author_id from post group by author_id;
-- 보통 아래와 같이 집계함수와 많이 사용
select author_id, count(*) from post group by author_id;

-- 집계함수
-- null은 count에서 제외
select count(*) from author;
select sum(price) from post;
select avg(price) from post;
select round(avg(price), 3) from post; --소수점3번째 자리에서 반올림
