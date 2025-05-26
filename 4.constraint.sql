-- not null 제약조건 추가
alter table author modify name varchar(255) not null;
-- not null 제약조건 삭제
alter table author modify name varchar (255);

-- 테이블 차원의 제약조건(pk,fk) 추가,제거 - add, drop 사용
-- 제약조건 삭제(fk)
alter table post drop foreign key 제약조건명;
alter table post drop constraint 제약조건명;
-- 제약조건 삭제(pk)
alter table post drop primary key;
-- 제약조건 추가
alter table post add constraint post_pk primary key(id);
alter table post add constraint post_fk foreign key(author_id) references author(id);

-- on delete/update 제약조건 테스트
-- 부모테이블 데이터 delete시에 자식 fk 컬럼 set null, update 시에 자식 fk컬럼 cascade
alter table post add constraint post_fk_new foreign key(author_id) references author(id) on delete set null on update cascade;

-- default 옵션
-- enum 타입 및 현재시간(currunt_timestamp) 에서 많이 쓰임
alter table author modify name varchar(255) default 'anonymouys';
-- auto_increment : 입력을 하지 않았을 때 마지막으로 입력된 가장 큰 값에서 +1만큼 자동으로 증가된 숫자값을 적용
alter table author modify bigint auto_increment
alter table post modify bigint auto_increment

