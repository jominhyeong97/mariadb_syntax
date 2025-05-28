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

-- group by와 집계함수
select author_id, count(*), sum(price) from post group by author_id;

-- where와 group by : 그룹화 한 컬럼으로 select 해야함함
--예제1) 날짜별 post 글의 개수출력 (날짜 값이 null은 제외)
select date_format(created_time, "%Y-%m-%d") as day, count(*) from post where created_time is not null group by day;
--예제2) 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, count(*) as CARS 
from CAR_RENTAL_COMPANY_CAR  
where OPTIONS like '%열선시트%' or OPTIONS like '%통풍시트%' or OPTIONS like '%가죽시트%' 
group by CAR_TYPE 
order by CAR_TYPE;
-- 예제3) 입양시각 구하기(1)
SELECT DATE_FORMAT(DATETIME,'%H') as HOUR, COUNT(*) as COUNT from ANIMAL_OUTS 
WHERE DATE_FORMAT(DATETIME,'%H') >= '09' and  DATE_FORMAT(DATETIME,'%H') < '20'
GROUP BY HOUR
ORDER BY HOUR;
-- group by와 having
-- having은 group by를 통해 나온 집계값에 대한 조건
-- 글을 2번 이상 쓴 사람 ID찾기
select author_id from post group by author_id having count(*) >=2;

-- 예제4) 동명 동물 수 찾기 (notnull안했는데)
SELECT NAME, COUNT(*) AS COUNT from ANIMAL_INS 
GROUP BY NAME
HAVING COUNT(NAME) >= 2
ORDER BY NAME;

-- 예제5) 카테고리 별 도서 판매량 집계하기
SELECT BOOK.CATEGORY, SUM(SALES) AS TOTAL_SALES FROM BOOK 
INNER JOIN BOOK_SALES ON BOOK.BOOK_ID = BOOK_SALES.BOOK_ID
WHERE DATE_FORMAT(BOOK_SALES.SALES_DATE, '%Y-%m') = '2022-01'
GROUP BY BOOK.CATEGORY
ORDER BY BOOK.CATEGORY

-- 예제6) 조건에 맞는 사용자와 총 거래금액 조회하기
SELECT G.USER_ID, G.NICKNAME,SUM(PRICE) AS TOTAL_SALES FROM USED_GOODS_BOARD B INNER JOIN USED_GOODS_USER G ON B.WRITER_ID = G.USER_ID
WHERE B.STATUS = 'DONE'
GROUP BY G.USER_ID
HAVING TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES

-- 다중열 group by
-- group by 첫번째 컬럼, 두번째 컬럼 : 첫번째 컬럼으로 먼저 그룹, 다음에 두번째 컬럼으로 그룹
-- post테이블에서 작성자별로 만든 제목의 개수를 출력하시오
select author_id, title, count(*) from post group by author_id, title;

-- 예제7) 재구매가 일어난 상품과 회원 리스트 구하기 ??
SELECT USER_ID, PRODUCT_ID FROM ONLINE_SALE 
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*)>=2
ORDER BY USER_ID, PRODUCT_ID DESC