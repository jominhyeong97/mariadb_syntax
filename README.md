
# 📘 MariaDB Syntax Study

MariaDB SQL 문법과 실습을 정리한 저장소입니다.  
비전공자도 SQL 개념을 빠르게 이해할 수 있도록 **예제 중심, 단계별 구성**으로 공부했습니다.

---

## 🗓 학습 기간

- 2025.05.01 ~ 2025.05.30  
- 주 5회, 하루 30분 이상 커밋하며 지속적으로 공부 중

---

## 📚 학습 목표

- MariaDB 환경 구축 및 기본 DDL/DML 이해  
- 데이터 타입, 제약조건, 제어문, 트랜잭션, 조인, 인덱스 등 핵심 SQL 익히기  
- ERD 실습과 뷰(View)/프로시저(Procedure)까지 다루기

---

## 🛠 폴더 & 실습 파일 설명

| 파일명 | 설명 |
|--------|------|
| `1.DDL.sql` | 테이블 생성, 스키마 정의 |
| `2.DML.sql` | 데이터 삽입/수정/삭제 실습 |
| `3.data_type.sql` | 각종 데이터 타입 실습 |
| `4.constraint.sql` | 제약조건 (PK, FK, unique 등) |
| `5.flow_statement.sql` | IF, CASE, LOOP 등 제어 흐름 |
| `6.transaction.sql` | 트랜잭션 개념과 COMMIT/ROLLBACK |
| `7.concurrent_issue.sql` | 동시성 이슈 설명 |
| `8.join.sql` | INNER/LEFT/RIGHT 조인 연습 |
| `9.index.sql` | 인덱스 생성 및 효과 확인 |
| `10.board_renewal.sql` | 게시판 예제로 전체 구조 설계 |
| `11.ERD 실습.sql` | ERD 기반 테이블 설계 실습 |
| `12.user_management.sql` | 유저관리 테이블/권한 테스트 |
| `13.view_procedure.sql` | 뷰와 저장 프로시저 실습 |
| `14.redis.sh` | (보너스) Redis 연동 테스트 스크립트 |
| `11.dump_practice.sh` | 덤프 및 백업/복원 실습 |

---

## 📌 실행 방법

1. MariaDB 설치 후 DB 생성
2. 각 `*.sql` 파일을 순서대로 실행 (`mysql < 1.DDL.sql`)
3. `board_renewal.sql` 등 고급 실습은 `ERD 실습.sql` 참고

---

## 🔗 참고 자료

- 공식 문서: https://mariadb.org/  
- 추천 강의: 생활코딩 MariaDB, YouTube SQL 기초  



