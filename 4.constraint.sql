-- not null 제약조건 추가
alter table author modify name varchar(255) not null;
-- not null 제약조건 삭제
alter table author modify name varchar (255);

