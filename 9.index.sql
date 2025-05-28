-- pk,fk,unique 추가시에 해당 컬럼에 index 자동생성
-- index가 만들어지면, 조회성능은 향상.추가/수정/삭제 성능 하락

-- index 조회
show index from author;

-- index 삭제
alter table author drop index 인덱스명

-- index 생성
create index 인덱스명 on 테이블(컬럼명);

-- index를 통해 조회성능향상을 얻으려면, 반드시 where 조건에 해당 칼럼에 대한 조건이 있어야함
select * from author where id=1;

-- where 조건에서 2컬럼으로 조회시에 1컬럼에만 index가 있는 경우
select * from author where name='hong' and email='hong2@naver.com';

-- where 조건에서 2컬럼으로 조회시에 2컬럼 모두에 index가 있는 경우 : db알고리즘에서 최적의 알고리즘 실행
select * from author where name='hong' and email='hong2@naver.com';

-- index는 1컬럼 뿐만아니라 2컬럼을 대상으로 1개의 index를 설정하는 것도 가능하다
-- 이 경우 두컬럼을 and조건으로 조회해야만 index를 사용
-- 복합인덱스생성
create index 인덱스명 on 테이블명(컬럼1,컬럼2);


-- 기존테이블 삭제 후 아래 테이블로 신규생성
create table author(id bigint primary key, email varchar(255), name varchar(255));

-- index test 시나리오
-- 아래 프로시저를 통해 수십만건의 데이터 insert 후에 index 생성 전후에 따라 조회성능 확인
DELIMITER //
CREATE PROCEDURE insert_authors()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE email VARCHAR(100);
    DECLARE batch_size INT DEFAULT 10000; -- 한 번에 삽입할 행 수
    DECLARE max_iterations INT DEFAULT 100; -- 총 반복 횟수 (1000000 / batch_size)
    DECLARE iteration INT DEFAULT 1;
    WHILE iteration <= max_iterations DO
        START TRANSACTION;
        WHILE i <= iteration * batch_size DO
            SET email = CONCAT('bradkim', i, '@naver.com');
            INSERT INTO author (email) VALUES (email);
            SET i = i + 1;
        END WHILE;
        COMMIT;
        SET iteration = iteration + 1;
        DO SLEEP(0.1); -- 각 트랜잭션 후 0.1초 지연
    END WHILE;
END //
DELIMITER ;