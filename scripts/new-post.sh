#!/usr/bin/env bash
# 새 블로그 글 파일을 생성하는 스크립트
# 사용법: ./scripts/new-post.sh

set -e

TODAY=$(date +%Y-%m-%d)
NOW=$(date "+%Y-%m-%d %H:%M:%S +0900")

echo ""
echo "=== 새 글 만들기 ==="
echo ""

# 글 종류 선택
echo "글 종류를 선택하세요:"
echo "  1) 알고리즘 개념 설명"
echo "  2) 문제 풀이 (백준/Codeforces 등)"
echo ""
read -p "선택 (1/2): " TYPE

if [[ "$TYPE" == "1" ]]; then
  # 개념 설명글
  echo ""
  echo "카테고리(주제)를 선택하세요:"
  echo "  1) DP          2) 그래프        3) 정렬"
  echo "  4) 자료구조    5) 수학          6) 그리디"
  echo "  7) 문자열      8) 직접 입력"
  echo ""
  read -p "선택 (1~8): " CAT_NUM

  case "$CAT_NUM" in
    1) CATEGORY="DP";      SERIES_TAG="series-dp"    ;;
    2) CATEGORY="그래프";  SERIES_TAG="series-graph"  ;;
    3) CATEGORY="정렬";    SERIES_TAG="series-sort"   ;;
    4) CATEGORY="자료구조"; SERIES_TAG="series-ds"    ;;
    5) CATEGORY="수학";    SERIES_TAG="series-math"   ;;
    6) CATEGORY="그리디";  SERIES_TAG="series-greedy" ;;
    7) CATEGORY="문자열";  SERIES_TAG="series-string" ;;
    *)
      read -p "주제 직접 입력: " CATEGORY
      SERIES_TAG="series-$(echo "$CATEGORY" | tr '[:upper:]' '[:lower:]')"
      ;;
  esac

  echo ""
  read -p "글 제목 (한국어 가능): " TITLE
  echo ""
  read -p "주요 태그 (공백 구분, 예: dp knapsack): " TAGS_RAW
  echo ""
  echo "난이도:"
  echo "  1) bronze  2) silver  3) gold  4) platinum  5) diamond"
  read -p "선택 (1~5): " DIFF_NUM
  case "$DIFF_NUM" in
    1) DIFF="bronze" ;; 2) DIFF="silver" ;;
    3) DIFF="gold"   ;; 4) DIFF="platinum" ;; 5) DIFF="diamond" ;;
    *) DIFF="silver" ;;
  esac

  # 파일명: 영문 제목 생성
  echo ""
  read -p "파일명용 영문 슬러그 (예: dynamic-programming-intro): " SLUG

  FILENAME="_posts/${TODAY}-${SLUG}.md"

  # 태그 배열 생성
  TAGS_YAML=""
  for tag in $TAGS_RAW; do
    TAGS_YAML="$TAGS_YAML $tag,"
  done
  TAGS_YAML="${TAGS_YAML%,}"

  cat > "$FILENAME" << FRONTMATTER
---
title: "${TITLE}"
date: ${NOW}
categories: [알고리즘, ${CATEGORY}]
tags: [${TAGS_YAML} ${DIFF}, ${SERIES_TAG}]
math: true
mermaid: true
toc: true
---

## 개요



## 동작 원리

\`\`\`mermaid
graph TD
    A --> B
\`\`\`

## 복잡도

$$
O()
$$

## 구현 (C++)

\`\`\`cpp
#include <bits/stdc++.h>
using namespace std;

int main() {

    return 0;
}
\`\`\`
{: file="solution.cpp" }

## 연습문제

| 번호 | 문제 | 핵심 |
|------|------|------|
| BOJ  | []() |  |
FRONTMATTER

elif [[ "$TYPE" == "2" ]]; then
  # 문제 풀이글
  echo ""
  echo "출처를 선택하세요:"
  echo "  1) 백준 (BOJ)   2) Codeforces   3) 프로그래머스   4) 기타"
  read -p "선택 (1~4): " SRC_NUM
  case "$SRC_NUM" in
    1) SOURCE="백준";       SRC_TAG="boj"  ;;
    2) SOURCE="Codeforces"; SRC_TAG="cf"   ;;
    3) SOURCE="프로그래머스"; SRC_TAG="pg"  ;;
    *) read -p "출처 직접 입력: " SOURCE; SRC_TAG=$(echo "$SOURCE" | tr '[:upper:]' '[:lower:]') ;;
  esac

  echo ""
  read -p "문제 번호 (예: 1463): " PROB_NUM
  read -p "문제 제목: " PROB_TITLE
  echo ""
  read -p "주요 태그 (공백 구분, 예: dp greedy): " TAGS_RAW
  echo ""
  echo "난이도:"
  echo "  1) bronze  2) silver  3) gold  4) platinum  5) diamond"
  read -p "선택 (1~5): " DIFF_NUM
  case "$DIFF_NUM" in
    1) DIFF="bronze" ;; 2) DIFF="silver" ;;
    3) DIFF="gold"   ;; 4) DIFF="platinum" ;; 5) DIFF="diamond" ;;
    *) DIFF="silver" ;;
  esac

  SLUG="${SRC_TAG}-${PROB_NUM}"
  FILENAME="_posts/${TODAY}-${SLUG}.md"

  TAGS_YAML=""
  for tag in $TAGS_RAW; do
    TAGS_YAML="$TAGS_YAML $tag,"
  done
  TAGS_YAML="${TAGS_YAML%,}"

  case "$SRC_NUM" in
    1) PROB_LINK="" ;;  # BOJ 2026-04-28 종료 — 링크 대신 번호 텍스트만
    2) PROB_LINK="https://codeforces.com/problemset/problem/${PROB_NUM}" ;;
    3) PROB_LINK="https://school.programmers.co.kr/learn/courses/30/lessons/${PROB_NUM}" ;;
    *) PROB_LINK="" ;;
  esac

  if [[ -n "$PROB_LINK" ]]; then
    PROB_REF="[${SOURCE} ${PROB_NUM} — ${PROB_TITLE}](${PROB_LINK})"
  else
    PROB_REF="${SOURCE} ${PROB_NUM} — ${PROB_TITLE}"
  fi

  cat > "$FILENAME" << FRONTMATTER
---
title: "[${SOURCE} ${PROB_NUM}] ${PROB_TITLE}"
date: ${NOW}
categories: [문제풀이, ${SOURCE}]
tags: [${TAGS_YAML} ${DIFF}, ${SRC_TAG}-${PROB_NUM}]
math: true
toc: true
---

## 문제

${PROB_REF}

> 핵심 요약:

## 접근 / 관찰



## 알고리즘 & 복잡도

- **알고리즘**:
- **시간복잡도**: \$O()\$
- **공간복잡도**: \$O()\$

## 코드 (C++)

\`\`\`cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    return 0;
}
\`\`\`
{: file="${SLUG}.cpp" }

## 배운 점

FRONTMATTER

else
  echo "잘못된 선택입니다."
  exit 1
fi

echo ""
echo "✓ 파일 생성: $FILENAME"
echo ""
echo "다음 단계:"
echo "  1. VS Code에서 파일을 열어 내용을 작성하세요."
echo "  2. 로컬 미리보기: 터미널에서 bundle exec jekyll serve"
echo "  3. 완성 후 배포: git add $FILENAME && git commit -m '글 제목' && git push"
echo ""
