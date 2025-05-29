-- 사용자 테이블 생성
create table author (id bigint auto_increment primary key, email varchar(50) not null,
 name varchar(100), password varchar(255) not null);

--  주소 테이블 생성
create table address (address_id bigint auto_increment primary key, author_id bigint not null, 
foreign key(author_id) references author(id), country varchar(50), city varchar(50), street  varchar(255));

-- post 테이블 생성
create table post (post_id bigint auto_increment primary key, contents varchar(1000), title varchar(255) not null );

-- 연결 테이블 생성
create table author_post (author_post_id bigint primary key auto_increment, 
author_id bigint not null, post_id bigint not null, 
foreign key(author_id) references author(id), 
foreign key(post_id) references post(post_id));

-- 복합키를 이용한 연결 테이블 생성
create table author_post2
(author_id bigint not null, post_id bigint not null, 
primary key(author_id, post_id),
foreign key(author_id) references author(id), 
foreign key(post_id) references post(id));

-- 회원가입 및 주소 생성
DELIMITER //
create procedure insert_author(in emailInput varchar(255), in nameInput varchar(255), in passwordInput varchar(255),in countryInput varchar(255), in cityInput varchar(255), in streetInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    insert into author(email, name, password) values (emailInput, nameInput, passwordInput);
    insert into address(author_id, country, city, street) values((select id from author order by id desc limit 1) , countryInput, cityInput, streetInput);
    commit;
end //
DELIMITER ;

-- 글쓰기
DELIMITER //
create procedure insert_post(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    insert into post(title, contents) values (titleInput, contentsInput);
    insert author_post(author_id, post_id) values((select id from author where email=emailInput), (select id from post order by id desc limit 1));
    commit;
end //
DELIMITER ;

-- 글편집하기
DELIMITER //
create procedure edit_post(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255), in idInput bigint)
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    update post set title=titleInput, contents=contentsInput where id=idInput;
    insert author_post(author_id, post_id) values((select id from author where email=emailInput), idInput);
    commit;
end //
DELIMITER ;


-- 혼자 테스트
-- 테이블 생성
create table user (email varchar(50) unique, user_type enum('구매자', '판매자') not null, 
address varchar(50), user_id bigint primary key auto_increment);
create table `order` (user_id  bigint not null, goods varchar(50) not null, order_date datetime default current_timestamp, 
goods_num int not null, order_id bigint primary key auto_increment, 
foreign key(user_id) references user(user_id));
create table seller (user_id bigint not null, telno varchar(255) not null, 
seller_id bigint primary key auto_increment, foreign key(user_id) references user(user_id));
create table goods (order_id bigint not null, num int, goods_id bigint primary key auto_increment,
foreign key (order_id) references `order`(order_id));

-- 회원 가입
    DELIMITER //
    create procedure gaip(in emailInput varchar(50), in user_typeInput enum('구매자','판매자'),in addressInput varchar(50), user_idInput bigint, telnoInput int)
    begin
        declare exit handler for SQLEXCEPTION
        begin
            rollback;
        end;
        start transaction;
        insert into user(email, user_type, address) values (emailInput, user_typeInput, addressInput);
        insert into seller(user_id, telno) values(user_idInput, telnoInput);
        commit;
    end //
    DELIMITER ;
