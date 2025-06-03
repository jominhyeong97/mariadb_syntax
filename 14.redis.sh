# window에서 기본설치 안됨 → 도커를 통한 redis설치
docker run --name redis-container -d -p 6379:6379 redis

# redis 접속명령어
redis -cli

# docker redis 접속
docker ps : 컨테이너 id 조회회
docker exec -it 86a5a49dc692  redis-cli

# redis는 0~15번까지의 db로 구성(default는 0번 db) : 매우 중요
# db번호 선택
select db번호

# db내 모든 키 조회
keys *

# 가장 일반적인 String 자료구조

# set을 통해 key:value 세팅
set user1 hong1@naver.com
set user:email:1 hong1@naver.com
set user:email:2 hong2@naver.com
# set : 기존에 key:value 존재할 경우 덮어쓰기기
set user:email:1 hong3@naver.com 
# key값이 이미 존재하면 pass, 없으면 set : nx
set user:email:1 hong4@naver.com nx

# 만료시간(ttl) 설정(초단위) : ex
set user:email:5 hong5@naver.com ex 10
# redis 실전활용 : token등 사용자 인증정보 저장 → 빠른성능활용
set user:1:refresh_token abcdef1234 ex 1800

# key를 통해 value 조회
get user:email:1 

# 특정 key 삭제
del user:email:1

# 현재 DB내 모든 key값 삭제
flushdb

# redis 실전활용2 : 좋아요기능 구현 → 동시성이슈 해결
set likes:posting:1 0 #redis는 기본적으로 모든 key:value가 문자열. 내부적으로는 "0"으로 저장.
# 특정 key값의 value를 1만큼 증가,감소 
incr likes:posting:1 
decr likesposting:1

# redis 실전활용3 : 재고관리구현 → 동시성이슈 해결
set stocks:produck:1 100
decr stocks:produck:1
incr stocks:produck:1

# redis 실전활용4 : 캐싱기능 구현
# 1번 회원 정보 조회 : select name, email age from member where id=1;
# 위 데이터의 결과값을 spring서버를 통해 json으로 변형하여 redis에 캐싱
# 최종적인 데이터 형식 : {"name":"hong", "email":"hong@daum.net", "age":30}
set member:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":30}" ex 1000

# list 자료구조
# redis의 list는 deque와 같은 자료구조 즉 double-ended queue구조
# lpush : 데이터를 list 자료구조에 왼쪽부터 삽입 / rpush : 오른쪽부터 삽입
lpush hongs hong1
lpush hongs hong2
rpush hongs hong3
# list 조회 : 0은 리스트의 시작 인덱스, -1은 마지막 인덱스
lrange hongs 0 -1 #전체조회
lrange hongs -1 -1 #마지막 값 조회
lrange hongs 0 0 #0번째 값 조회
lrange hongs -2 -1 #마지막 2번째부터 마지막 까지
lrange hongs 0 2 #0번째부터 2번째까지
# list값 꺼내기, 꺼내면서 삭제.
rpop hongs
lpop hongs
# A리스트에서 rpop하여 B리스트에서 lpush(중요하지 않음)
rpoplpush 
# list의 데이터 개수 조회
llen hongs
# list의 ttl 적용
expire hongs 20
# list의 ttl 조회
ttl hongs

# redis 실전활용5 : 최근 조회한 상품 목록
rpush user:1:recent:product apple
rpush user:1:recent:product banana
rpush user:1:recent:product mango
rpush user:1:recent:product orange
rpush user:1:recent:product melon
# 최근 본 상품 조회
lrange user:1:recent:product -3 -1

# set 자료구조 : 중복 없음, 순서 없음.
sadd memberlist m1
sadd memberlist m2
sadd memberlist m3
sadd memberlist m3 > 중복
# set 자료 조회
smembers memberlist
# set멤버 개수 조회
scard memberlist
# 특정멤버가 set안에 있는 존재여부 확인
sismember memberlist m2
# 특정멤버 삭제
srem memberlist m2 

# redis 실전활용6 : 좋아요 구현
# 게시글상세보기에 들어가면
scard posting:likes:1 (눌렀던 사람들 수)
sismember posting:likes:1 a1@naver.com (내가 눌렀는지)
# 게시글에 좋아요를 하면
sadd posting:likes:1 a1@naver.com
# 좋아요 한 사람을 클릭해서 조회
smembers posting:likes:1

# zset : sorted set(정렬된 셋)
# zset을 활용해서  최근시간순으로 정렬가능(zset도 set이므로 같은상품 add경우 중복이 제거되고 ,score(시간)값만 업데이트)
zadd user:1:recent:product 091330 mango
zadd user:1:recent:product 091332 apple (최신 apple로 업데이트 됨)
zadd user:1:recent:product 091335 banana
zadd user:1:recent:product 091341 orange
zadd user:1:recent:product 091350 apple

# zset조회 : zrange(score기준 오름차순), zrevrange(score기준 내림차순)
zrange user:1:recent:product 0 2
zrange user:1:recent:product -3 -1 
(mango, banana, orange, apple)
# withscore를 통해 score값까지 같이 출력
zrevrange user:1:recent:product 0 2 withscores 
(apple, orange, banana, mango)

# 실전활용7 : 주식시세저장
# 종목:삼성전자, 시세:55000원, 시간:현재시간(유닉스타임스탬프) > 년월일시간을 초단위로 변환한것
zadd stock:price:se 1748911141 55000
zadd stock:price:se 1748911142 55500
zadd stock:price:lg 1748911143 100000
zadd stock:price:lg 1748911143 110000
# 삼성전자의 현재시세
zrange stock:price:se -1 -1

# hashes 자료구조 : value가 amp형태의 자료구조(key:value, key:value ... 형태의 자료구조)
set member:info:1 "{\"name\":\"hong\", \"email\":\"hong@daum.net\", \"age\":30}" 
hset member:info:1 name hong email hong@daum.net age 30
# 특정 값 조회
hget member:info:1 name
# 모든 객체 값 조회
hgetall member:info:1
# 특정 요소 값 수정
hset member:info:1 name hong2
# 빈번하고 변경되는 객체값을 저장시 효율적