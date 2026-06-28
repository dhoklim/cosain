# PS/CP 알고리즘 블로그 컨텍스트

PS(Problem Solving) / CP(Competitive Programming) 알고리즘 개념 설명과 문제 풀이를 공개 교육용으로 발행하는 블로그.

- **URL**: https://dhoklim.github.io
- **스택**: Jekyll + Chirpy 7.6.0, GitHub Pages, GitHub Actions 자동 배포
- **언어**: 한국어, 코드는 C++ 위주

## 로컬 개발

**VS Code에서**: `Cmd+Shift+P` → "Tasks: Run Task" → 원하는 태스크 선택

| 태스크 | 설명 |
|--------|------|
| 🚀 블로그 미리보기 (livereload) | 로컬 서버 시작 → http://127.0.0.1:4000 (파일 저장 시 자동 새로고침) |
| ✍️  새 글 만들기 | 인터랙티브 스크립트로 front matter 포함 템플릿 파일 생성 |
| 📦 빌드 검사 | 배포 전 htmlproofer 포함 전체 빌드 |

**터미널에서 직접**: `~/.zshrc`에 rbenv가 등록되어 있으므로 새 터미널을 열면 바로 사용 가능

```bash
bundle exec jekyll serve   # 미리보기
bash scripts/new-post.sh   # 새 글 생성
```

push하면 GitHub Actions가 자동으로 빌드·배포합니다. 배포 상태는 https://github.com/dhoklim/dhoklim.github.io/actions 에서 확인.

## 글 파일 규칙

- 위치: `_posts/YYYY-MM-DD-제목-영문.md`
- 날짜는 오늘 날짜 사용

## Front Matter 템플릿

**개념 설명글**
```yaml
---
title: "제목"
date: YYYY-MM-DD HH:MM:SS +0900
description: "80~120자 한국어 요약 — SERP 스니펫과 og:description에 사용됨 (필수)"
categories: [알고리즘, <주제>]   # DP | 그래프 | 정렬 | 자료구조 | 수학 | 그리디 | 문자열
tags: [소문자태그, silver, series-<주제>]
math: true
mermaid: true
toc: true
---
```

**문제 풀이글**
```yaml
---
title: "[출처 번호] 문제 제목"
date: YYYY-MM-DD HH:MM:SS +0900
description: "80~120자 한국어 요약 (필수)"
categories: [문제풀이, <출처>]   # Codeforces | 프로그래머스 | AtCoder
tags: [알고리즘태그, 난이도, cf-번호]
math: true
toc: true
---
```

**태그 규칙**: 항상 소문자. 난이도는 solved.ac 기준 `bronze` `silver` `gold` `platinum` `diamond` `ruby`. 시리즈 묶음은 `series-dp` `series-graph` `series-sort` 형식.

## 글 본문 구조

**개념 설명글** (cp-algorithms.com 스타일)
1. 개요 — 한 문단으로 핵심 아이디어 설명
2. 동작 원리 — mermaid 다이어그램으로 시각화
3. 복잡도 — LaTeX `$$...$$`로 시간·공간 복잡도
4. 구현 (C++) — 코드블록에 `{: file="파일명.cpp" }` 캡션
5. 변형/응용 — (선택)
6. 연습문제 — BOJ/CF 링크 테이블

**문제 풀이글**
1. 문제 — 원문 링크 + 핵심 요약 (전문 복붙 금지, 저작권 주의)
2. 접근/관찰
3. 알고리즘 & 복잡도
4. 코드 (C++)
5. 반례/주의 — (선택)
6. 배운 점

> **BOJ(백준) 2026-04-28 종료**: BOJ 링크 사용 불가. Codeforces, AtCoder, 프로그래머스 문제 위주로 작성. BOJ 번호는 텍스트로만 표기(운영자 재공개 검토 중).

## Chirpy 특수 문법

```markdown
# 수식 (math: true 필요)
인라인: $O(n \log n)$
블록:
$$
dp[i] = dp[i-1] + dp[i-2]
$$

# 코드블록 파일 캡션
```cpp
// 코드
```
{: file="solution.cpp" }

# 강조 박스
> 내용
{: .prompt-tip }    # 초록 팁
{: .prompt-info }   # 파란 정보
{: .prompt-warning } # 노란 주의
{: .prompt-danger }  # 빨간 위험

# mermaid 다이어그램 (mermaid: true 필요)
```mermaid
graph TD
    A --> B
```
```

## 주의사항

- Liquid 템플릿 엔진이 `{{`, `}}` 를 변수로 파싱합니다. 코드 내 이중 중괄호(`{{...}}`)는 `push_back({...})` 등으로 피하거나 `{% raw %}...{% endraw %}`로 감싸세요.
- `categories`는 **최대 2개** (Chirpy 제한).
- 글에서 내부 링크(`/tags/xxx/`, `/categories/xxx/`)를 쓸 때, 해당 태그/카테고리를 가진 글이 없으면 htmlproofer CI가 실패합니다. 아직 글이 없는 경우 링크 대신 텍스트로 씁니다.

## 현재 글 목록

| 파일 | 주제 | 카테고리 |
|------|------|---------|
| `2026-06-28-dfs-bfs.md` | DFS / BFS | 알고리즘 > 그래프 |
| `2026-06-28-dynamic-programming.md` | DP 입문 | 알고리즘 > DP |
| `2026-06-28-sorting-algorithms.md` | 정렬 알고리즘 | 알고리즘 > 정렬 |

## 로드맵 업데이트

새 개념 글을 쓰면 `_tabs/roadmap.md`의 해당 행에 링크를 추가하세요.

```markdown
| DFS / BFS | Silver ~ Gold | [개념 보기](/posts/dfs-bfs/) |
```
