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
lrange hongs
