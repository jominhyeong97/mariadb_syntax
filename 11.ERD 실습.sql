-- 테이블 생성
create table users (user_id bigint auto_increment, name varchar(50) not null, address varchar(255),
age int not null, primary key(user_id));

create table seller (seller_id bigint auto_increment, seller_num varchar(50) unique, name varchar(50) not null, 
address varchar(50) not null, primary key (seller_id));

create table goods (goods_id bigint auto_increment, goods_name varchar(50) not null unique, goods_num bigint unsigned not null,
primary key(goods_id));

create table orders (order_id bigint auto_increment, user_id bigint not null, order_time datetime default current_timestamp,
primary key(order_id), 
foreign key(user_id) references users(user_id));

create table goods_list (list_id bigint auto_increment, seller_id bigint not null, goods_id bigint , 
list_time datetime default current_timestamp, 
primary key(list_id), foreign key (seller_id) references seller(seller_id), 
foreign key (goods_id) references goods(goods_id));

create table order_detail (detail_id bigint auto_increment, list_id bigint not null, 
order_id bigint not null, detail_num bigint unsigned not null, 
primary key(detail_id), foreign key(list_id) references goods_list(list_id), 
foreign key (order_id) references orders(order_id));

-- 일반사용자 회원가입
    DELIMITER //
    create procedure users_join(in nameInput varchar(50),in addressInput varchar(255), in ageInput int)
    begin
        declare exit handler for SQLEXCEPTION
        begin
            rollback;
        end;
        start transaction;
        insert into users(name, address, age) values (nameInput, addressInput, ageInput);
        commit;
    end //
    DELIMITER ;

-- 회원가입 확인인
select * from users;

-- 판매자 회원가입
    DELIMITER //
    create procedure seller_join(in seller_numInput varchar(50), in nameInput varchar(50), in addressInput varchar(55))
    begin
        declare exit handler for SQLEXCEPTION
        begin
            rollback;
        end;
        start transaction;
        insert into seller(seller_num, name, address) values (seller_numInput,  nameInput, addressInput);
        commit;
    end //
    DELIMITER ;

-- 판매자 회원가입 확인
select * from seller;

-- 상품등록(판매자 정보가 나와야함) >
    DELIMITER //
    create procedure goods_register(in goods_nameInput varchar(50), in goods_numInput bigint unsigned, in seller_idInput bigint)
    begin
        declare exit handler for SQLEXCEPTION
        begin
            rollback;
        end;
        start transaction;
        insert into goods(goods_name, goods_num) values (goods_nameInput, goods_numInput);
        insert into goods_list(seller_id) values (seller_idInput);

        commit;
    end //
    DELIMITER ;

-- 상품정보조회(재고, 품명 등등)

select goods_list.seller_id, goods.goods_name, goods.goods_num, goods.goods_id from goods 
left join goods_list on goods.goods_id = goods_list.goods_id; 


-- 상품 주문

    DELIMITER //
    create procedure goods_orders(in user_idInput bigint, in list_idInput bigint, in order_idInput bigint, in detail_numInput bigint unsigned)
    begin
        declare exit handler for SQLEXCEPTION
        begin
            rollback;
        end;
        start transaction;
        insert into orders(user_id) values (user_idInput);
        insert into order_detail(list_id, order_id, detail_num) values (list_idInput, order_idInput, detail_numInput);
        update goods set goods_num = goods_num - detail_numInput  where goods.goods_id = list_idInput;
        commit;
    end //
    DELIMITER ;


-- 주문내역 상세조회(주문자가 나와야함)

select * from order_detail inner join orders on order_detail.order_id = orders.order_id 
left join users on orders.user_id = users.user_id;