-- 트랜젝션 : 하나의 논리적인 작업 단위로 처리되어야 하는 하나 이상의 SQL 문의 집합
-- 트랜젝션 테스트
alter table author add post_count int default 0;

-- post에 글쓴후에, author 테이블의 post_count컬럼에 +1을 시키는 트랜잭션 테스트
start transcation;
update author set post_count= post_count + 1 where id = 3;
insert into post(title, content, author_id) values("hello", "hello...", 100);
rollback; --또는 rollback;
-- 위 트랜잭션은 실패시 자동으로 rollback이 어려움
-- stored 프로시저를 활용하여 성공시 commit, 실패시 rollback 등 다이나믹한 프로그래밍
 DELIMITER //
create procedure transaction_test()
begin

    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;

    start transaction;
    update author set post_count= post_count + 1 where id = 3;
    insert into post(title, content, author_id) values("hello.", "hello...", 3);
    commit;

END //
DELIMITER ;

-- 프로시저 호출
call transaction_test();

-- 사용자에게 입력받는 프로시저 생성
DELIMITER //
create procedure transaction_test2(in titleInput varchar(255), in contentInput varchar(255), in idInput bigint)
begin

    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;

    start transaction;
    update author set post_count= post_count + 1 where id = idInput;
    insert into post(title, content, author_id) values(titleInput, contentInput, idInput);
    commit;

END //
DELIMITER ;

-- 격리수준(동시성 이슈 관련)

Serializable(격리성 매우 높음, 성능 매우 낮음)
동시성 포기, 순차적으로 트랙잭션 처리
Repeatable Read

Read Committed

Read UnCommited(가장 낮은 격리수준, )
