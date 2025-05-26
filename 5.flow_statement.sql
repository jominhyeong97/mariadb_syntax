-- 흐름제어 : if, case when, ifnull
-- if(a,b,c) : a 조건이 참이면 b반환, 그렇지 않으면 c를 반환
select id, if(name is null, '익명사용자', name) from author;

-- ifnull(a,b) : a가 null이면 b를 반환, null 아니면 a를 그대로 반환
select id, ifnull(name, '익명사용자') from author;

select id,
 case 
    when name is null then '익명사용자' 
    when name = 'hong4' then '홍4'
    else name
 end
 from author;

--  경기도에 위치한 식품창고 목록 출력하기
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, ifnull(FREEZER_YN,'N') as FREEZER_YN 
from FOOD_WAREHOUSE where ADDRESS like '%경기도%' order by WAREHOUSE_ID asc;
-- 조건에 부합하는 중고거래 상태 조회하기
case 문

-- 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE, IFNULL(TLNO, 'NONE') AS TLNO 
FROM PATIENT WHERE AGE <= 12 && GEND_CD = 'W' ORDER BY AGE DESC, PT_NAME;

