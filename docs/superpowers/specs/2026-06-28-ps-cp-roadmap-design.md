# PS/CP 알고리즘 로드맵 개편 명세

## 목적

`_tabs/roadmap.md`를 C++ 입문자가 BOJ Diamond/Ruby 및 ICPC World Finals 수준까지 성장할 수 있는 장기 학습 지도 형태로 개편한다. 단순한 알고리즘 목록이 아니라 학습 순서, 선수 지식, 도달 기준, 관련 글을 함께 제시한다.

## 독자와 범위

- 시작점: C++ 문법을 처음 배우거나 기본 구현이 익숙하지 않은 학습자
- 중간 목표: BOJ Gold 수준의 전형적인 알고리즘을 스스로 선택하고 구현
- 최종 목표: BOJ Diamond/Ruby 및 ICPC 상위권에서 다루는 고급 알고리즘 이해
- 언어: 한국어 설명과 C++17 예제
- 문제 플랫폼: BOJ 중심, 필요하면 Codeforces 및 ICPC 문제 추가

로드맵은 모든 주제를 반드시 순서대로 끝내야 한다고 주장하지 않는다. 공통 기반을 마친 뒤에는 관심 분야와 대회 필요에 따라 심화 트랙을 병행할 수 있음을 명시한다.

## 정보 구조

페이지는 다음 순서로 구성한다.

1. 로드맵 사용법과 난이도 표기 기준
2. 전체 여정을 요약한 단계 표
3. 공통 기반 과정
4. 분야별 심화 트랙
5. 최상위 통합 과정
6. 문제 풀이 및 대회 운영 훈련
7. 글 작성 현황과 갱신 원칙

각 단계에는 아래 정보를 제공한다.

- 권장 난이도
- 선수 지식
- 핵심 주제
- 완료 기준
- 관련 개념 글 링크 또는 `예정` 상태

대표 문제는 로드맵 페이지가 지나치게 길어지지 않도록 단계마다 문제 유형 또는 2~4개의 핵심 문제만 제시한다. 구체적인 문제 목록은 각 개념 글에서 확장한다.

## 단계 구성

### 공통 기반

0. C++와 PS 환경: 입출력, STL, 정수 범위, 복잡도, 디버깅
1. 기초 자료구조와 구현: 배열, 문자열, 스택, 큐, 덱, 해시, 집합
2. 완전탐색: 재귀, 순열·조합, 비트마스킹, 백트래킹
3. 정렬과 탐색: 정렬, 이분 탐색, 매개변수 탐색
4. 선형 스캔 기법: 누적 합, 투 포인터, 슬라이딩 윈도, 스위핑
5. 그리디와 분할 정복
6. 그래프와 DP 입문: DFS/BFS, 기초 DP

이 과정의 완료 기준은 BOJ Gold 하위 문제에서 필요한 알고리즘 후보를 스스로 좁히고, 기본 구현을 참고 자료 없이 작성하는 것이다.

### 분야별 심화 트랙

#### 그래프

- 위상 정렬과 DAG DP
- 최단 경로: Dijkstra, Bellman–Ford, Floyd–Warshall, 0-1 BFS
- 서로소 집합과 최소 신장 트리
- SCC, 단절점·단절선, 2-SAT
- 이분 매칭, 최대 유량, 최소 비용 최대 유량
- 오일러 경로, 블로섬, 지배자 트리 등 최상위 주제

#### 트리와 질의 자료구조

- 트리 순회, 서브트리, LCA, 트리 DP
- Fenwick tree와 segment tree
- lazy propagation, merge sort tree, persistent segment tree
- Heavy-Light Decomposition, centroid decomposition
- Li Chao tree, dynamic segment tree, Link-Cut Tree

#### 동적 프로그래밍

- 배낭, LIS/LCS, 구간 DP, 비트마스크 DP, 자릿수 DP
- 트리 DP, DAG DP, 확률 DP, 게임 DP
- Convex Hull Trick, divide-and-conquer optimization, Knuth optimization
- slope trick, Aliens trick 등 최상위 최적화

#### 문자열

- 문자열 해싱, Trie, KMP, Z algorithm
- Aho–Corasick, Manacher
- suffix array와 LCP
- suffix automaton, suffix tree 및 고급 문자열 질의

#### 수학과 정수론

- 소수 판정, 에라토스테네스의 체, 유클리드 호제법
- 빠른 거듭제곱, 모듈러 역원, 조합론
- 확장 유클리드, 중국인의 나머지 정리
- 행렬 거듭제곱, 선형 점화식
- FFT/NTT, 다항식 연산
- Miller–Rabin, Pollard's rho 및 고급 조합론

#### 계산 기하

- 벡터, CCW, 선분 교차, 다각형 넓이
- 볼록 껍질, 회전하는 캘리퍼스
- 점과 다각형의 위치 관계, 최근접 점 쌍
- 반평면 교집합, Minkowski sum, 원 관련 기하

#### 오프라인·확률·기타 기법

- 좌표 압축, sqrt decomposition, Mo's algorithm
- parallel binary search, small-to-large, DSU rollback
- randomized algorithm, bitset optimization
- meet-in-the-middle, ternary search, game theory

### 최상위 통합 과정

최상위 단계에서는 알고리즘 이름을 외우는 대신 여러 분야를 결합하는 문제를 다룬다. 예시는 트리 위의 자료구조, 유량을 이용한 모델링, 다항식과 DP의 결합, 오프라인 동적 연결성, 기하와 이분 탐색의 결합이다.

완료 기준은 다음과 같다.

- 제약 조건에서 필요한 시간복잡도를 먼저 계산한다.
- 익숙하지 않은 문제를 기존 알고리즘의 조합으로 모델링한다.
- 정당성 증명과 복잡도 분석을 풀이 전에 작성한다.
- 팀 대회에서 문제 분배, 구현 검수, 제출 우선순위를 운영한다.

## 기존 글 연결

현재 발행된 글은 실제 포스트 주소로 연결한다.

- 정렬 알고리즘: `/posts/sorting-algorithms/`
- DFS/BFS: `/posts/dfs-bfs/`
- DP 입문: `/posts/dynamic-programming/`

아직 글이 없는 주제는 존재하지 않는 내부 링크를 만들지 않고 `예정`으로 표시한다. 이는 htmlproofer 실패를 방지한다.

## 표현 원칙

- 한 단계에 너무 많은 약어만 나열하지 않고 한국어 이름을 병기한다.
- 난이도는 절대 기준이 아니라 일반적인 BOJ 체감 범위임을 밝힌다.
- `Diamond/Ruby` 도달을 특정 알고리즘 목록의 암기와 동일시하지 않는다.
- 고급 트랙은 병렬 학습이 가능하도록 선수 지식을 명시한다.
- 모바일에서도 읽기 쉽도록 표의 열 수를 제한하고 긴 설명은 표 밖에 둔다.

## 검증

개편 후 다음 항목을 확인한다.

1. front matter와 Chirpy 문법이 유효한가
2. 발행된 세 글의 내부 링크가 실제 주소와 일치하는가
3. 존재하지 않는 태그·카테고리·게시물 링크가 없는가
4. 단계 번호와 트랙 간 선수 관계가 모순되지 않는가
5. `tools/test.sh` 또는 동등한 Jekyll 빌드 검사를 통과하는가

## 제외 범위

- 모든 단계의 개별 개념 글을 한 번에 작성하지 않는다.
- 모든 알고리즘에 문제 목록을 완비하지 않는다.
- 특정 온라인 저지의 레이팅 상승을 보장하지 않는다.
- 대회 규정이나 플랫폼별 최신 정책은 로드맵의 핵심 내용에 포함하지 않는다.
