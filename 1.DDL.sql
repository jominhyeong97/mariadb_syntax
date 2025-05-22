복습시 최종정리 DDL
-- create database 데이터베이스명
-- create table 테이블명 (a int, b varchar(255), primary key(a), foreign (b) reference 타테이블(b));

-- show databases
-- show tables
-- show index from 테이블명

-- describe 테이블명

-- alter table rename 테이블명 바꿀테이블명
-- alter table 테이블명 add column 칼럼명 varchar(255);
-- alter table 테이블명 modify column 칼럼명 not null, modify column 칼럼명 unique;
-- alter table 테이블명 change 칼럼명 바꿀칼럼명 int;

-- drop 테이블명
-- drop table if exists 테이블명


-- Maria 서버에 접속
mairadb -u root -p 입력 후 비밀번호 별도 입력

-- 스키마(database)생성
create database board;

-- 스키마 삭제
drop database board;

-- 스키마 목록조회
show databases;

-- 스키마 선택
use 스키마명;

-- 문자인코딩 변경(안중요)
alter database board default character set = utf8mb4;

-- 문자인코딩 조회(안중요)
show variables like 'character_set_server';

-- 테이블 생성
create table author(id int primary key, name varchar(255), email varchar(255), password varchar(255));

-- 테이블 목록조회
show tables;

-- 테이블 컬럼정보 조회(중요)
describe author;

-- 테이블 생성명령문 조회
show create table author;

-- posts테이블 신규생성(id, title, contents, author_id)
create table posts
    (id int, title varchar(255), contents varchar(255), author_id int not null, 
    primary key(id), foreign key(author_id) references author(id));

-- 테이블 제약조건 조회(안중요)
select * from information_schema.key_column_usage where table_name='posts';

-- 테이블 index 조회
show index from author;

-- <정리>
-- 테이블의 구조를 변경 : alter
-- 테이블의 이름 변경
alter table posts rename post;
-- 테이블의 컬럼 추가
alter table author add column age int;
-- 테이블의 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table post change column contets content varchar(255);
-- 테이블 컬럼의 타입과 제약조건 변경 > 덮어쓰기
alter table author modify column email varchar(100) not null;
alter table author modify column email varchar(100) not null unique;

-- alter 실습 : author 테이블에 address 컬럼을 추가(varchar 255), post 테이블에 title은 not null로 변경, content는 길이 3000자로 변경
alter table author add address varchar(255);
alter table post modify column title varchar(255) not null, modify column content varchar(3000);

-- 테이블을 삭제하는 명령어 : drop
drop table abc;
drop table if exists abc; (일련의 쿼리문에서 특정쿼리에서 에러가 안나게끔 if exists 사용)



/*
1.마리아 로그인
2.스키마1 이름의 스키마 생성
3.스키마1 삭제
4.스키마2 이름의 스키마 생성
5.스키마 생성 됐는지 목록조회
6.스키마2 선택
7.테이블1 생성 : int a(pk), int b(fk), 문자 c, 문자 d(빈값없이), 문자e(중복값없이) 생성)
8.테이블1의 인덱스 조회
9.테이블1의 생성명령문 조회(7번항목 조회)
10.테이블1 칼럼정보 조회


mariadb -u root -p
create database 스키마1;
drop database 스키마1;
create database 스키마2;
show databases; (스키마 목록조회)
use 스키마2;
create table 테이블1 (a int, b int, c varchar(255), d varchar(255) not null, 
e varchar(255) unique, primary key(a), foreign key(b) references 다른테이블명(칼럼명));
show index from 테이블1;
show create table 테이블명;(테이블 생성명령문 조회)
describe 테이블1;(테이블 컬럼정보 조회);*/

-- 