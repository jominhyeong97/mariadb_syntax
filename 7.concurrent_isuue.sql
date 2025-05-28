-- 격리수준(동시성 이슈 관련)

-- Read UnCommited(가장 낮은 격리수준)
    커밋되지 않은 데이터 read가능 > dirty read 문제 발생
    실습절차
    1)워크밴치에서 auto_commit 해제. update 후, commit하지 않음.(transaction1)
    2)터미널을 열어 select했을 때 위 변경사항이 읽히는 확인(transaction2)
    결론 : mariadb는 기본적으로 Repeatable read 이므로 dirty read 발생하지 않음.

-- Read Committed
    커밋한 데이터만 read가능 > phantom read 발생(또는 non-Repeatable read)
    start transaction;
    select count(*) from author;    --개수 :10개
    do sleep(15);                   --이 사이에 insert문
    select count(*) from author;    --개수 :11개(단, Repeatable Read에서는 10개)
    commit;

    insert into author(email) values('honghong25@naver.com');

-- Repeatable Read(매우중요)
    읽기의 일관성 보장 > lost update 문제 발생 > 배타적 잠금"select for update"으로 해결
    -- lost update 문제 발생
        <znjfl>
        DELIMITER //
        create procedure concurrent_test1()
        begin
            declare count int;
            start transaction;
            insert into post(title, author_id) values ('hello world', 4);
            select post_count into count from author where id = 4;
            do sleep(15);
            update author set post_count= count + 1 where id = 4;
            commit;
        END //
        DELIMITER ;

        <터미널>
        select post_count from author where id = 4;
        
    -- lost update 문제 해결 : select for update시에 트랜잭션이 종류후에 특정 행에대한 lock 풀림
    DELIMITER //
            create procedure concurrent_test2()
            begin
                declare count int;
                start transaction;
                insert into post(title, author_id) values ('hello world', 4);
                select post_count into count from author where id = 4 for update;
                do sleep(15);
                update author set post_count= count + 1 where id = 4;
                commit;
            END //
            DELIMITER ;
        
        <터미널>
        select post_count from author where id = 4 for update; 

-- Serializable(격리성 매우 높음, 성능 매우 낮음)
모든 순차적으로 트랜잭션 처리 > 동시성 문제 없음