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

