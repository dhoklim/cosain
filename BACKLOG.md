---
title: PS/CP 블로그 백로그
---

> 이 문서는 멀티 에이전트 감사(6개 차원 → 종합 → 완전성 비평 → 최종화)로 생성되었으며, 모든 항목은 실제 레포 상태에 대해 검증되었습니다. 생성일 2026-06-28.

# 앞으로 할 일 — PS/CP 블로그 통합 백로그

## 현재 상태 요약

로드맵 개편은 **커밋·푸시까지 모두 완료**되었습니다(`git rev-parse HEAD`와 `git rev-parse origin/main`이 모두 `89643c8`로 동일, `git log origin/main..HEAD` 비어 있음, 작업 트리 클린). 즉 방문자는 이미 470줄 풀버전 로드맵을 보고 있습니다. 다만 GitHub Actions의 htmlproofer 단계에 백슬래시 깨짐 버그가 있어 **배포 게이트(링크 검사)가 무력화**되었을 수 있어, 남은 실제 액션은 "배포 페이지 정상 렌더 확인 + CI 게이트 복구"입니다. 발행 글은 개념글 3편뿐(풀이글 0건), `_config.yml`의 댓글·분석·OG 이미지·검색엔진 인증·아바타·파비콘이 전부 비어 있습니다. 외부 의존 대상인 **BOJ가 2026-04-28 종료**(solved.ac API는 2026-04-12 종료)되어 `_posts/`의 죽은 BOJ 링크 **고유 16개**와 자료 신뢰가 위협받습니다 — 단, 운영자가 "문제만이라도 재공개 검토 중"이라 공지했으므로 문제번호는 텍스트로 보존하며 병기·대체하는 편이 안전합니다. 또한 루트 `LICENSE`가 여전히 테마 저자(Cotes Chung) 명의라 본인 글의 권리관계가 비어 있습니다.

---

## 🚀 지금 바로 (Now)

### 콘텐츠

| # | 항목 | 무엇 / 왜 | 난이도 |
|---|------|-----------|--------|
| **1** | **배포된 로드맵 페이지 검수 + CI 게이트 복구** | **무엇:** 로드맵 플랜(`docs/superpowers/plans/2026-06-28-ps-cp-roadmap.md`)은 Task 1·2 완료·커밋·**푸시까지 끝남**(HEAD==origin/main==`89643c8`). 남은 행동은 두 가지: (a) 배포된 `/roadmap/` 페이지가 470줄 풀버전으로 정상 렌더되는지 실제 URL에서 확인, (b) CI htmlproofer 백슬래시 버그(아래 도구 항목)로 링크 검사 게이트가 무력화되지 않았는지 점검·복구. **왜:** 학습 지도는 이미 라이브지만, 게이트가 깨져 있으면 이후 죽은 링크·빌드 오류가 그대로 배포됨. **명령:** `bash tools/test.sh`(종료코드 0) → 배포 URL 육안 확인 → Actions(build+htmlproofer+deploy) 그린 확인. | S |

> 검증 메모: 감사/드래프트는 "roadmap.md가 옛 stub" 또는 "미푸시 커밋 2개 push가 남은 단 하나의 행동"이라 했으나, 실제로는 **커밋·푸시 모두 완료**됨. 진짜 미완은 **CI 게이트 복구 + 배포 확인**임.

### 콘텐츠 — 🩹 BOJ 종료 대응 (최우선 신뢰 복구)

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **죽은 BOJ 링크 16개 점검 → CF/AtCoder/프로그래머스 병기·교체 (문제번호 텍스트 보존)** | **무엇:** `grep -rhoE 'acmicpc.net/problem/[0-9]+' _posts/ \| sort -u`로 추출되는 **고유 16개**(전부 `_posts/`에만 존재 — 로드맵에는 acmicpc 링크 0개)를 동급 난이도 CF/AtCoder/프로그래머스로 매핑·병기. BOJ 번호는 **링크 대신 텍스트로 보존**(운영자가 문제 재공개 검토 중). CI htmlproofer가 외부 링크를 검사하는지(죽은 도메인에 막히는지) 확인. **왜:** 벤치마크(cp-algorithms·USACO Guide)의 핵심 가치가 "살아있는 연습문제 연결"인데 최대 외부 의존이 죽음. 작업량은 16개 링크 수준으로 적정. | S |
| **`new-post.sh` 158행 하드코딩된 BOJ 링크 처리** | **무엇:** `scripts/new-post.sh` 158행이 `PROB_LINK="https://www.acmicpc.net/problem/${PROB_NUM}"`로 BOJ를 하드코딩 → 출처가 CF/AtCoder/프로그래머스여도 BOJ URL 생성됨. 출처별(`SRC_TAG` 분기) 올바른 문제 URL을 만들도록 수정(BOJ 선택 시는 텍스트만 출력 옵션). **왜:** 풀이 모드가 이미 완비돼 있어도(아래 정정 참고) 링크 생성기가 죽은 도메인을 계속 박으면 신규 풀이글마다 깨진 링크가 재생산됨. | S |

### 사이트 설정/기능

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **깨진 `twitter:site "@"` 플레이스홀더 제거** | **무엇:** 배포된 모든 head에 `<meta name="twitter:site" content="@" />`가 나감. 계정 없으면 `_data/contact.yml`·`_data/share.yml`의 twitter 블록 주석 처리, 있으면 `_config.yml` 32행 `twitter.username` 채움. **왜:** 빈 `@`는 X 카드 검사기·크롤러가 잘못된 핸들로 인식 — 명백히 배포 중인 버그. **확인:** 빌드 후 `grep -o 'twitter:site[^>]*' _site/index.html`. | S |
| **giscus 댓글 활성화** | **무엇:** posts defaults에 `comments: true`가 이미 켜져 있어 `_config.yml` provider만 `giscus`로 채우고 repo/repo_id/category/category_id/`lang: ko` 입력하면 즉시 동작. **왜:** PS 블로그의 핵심 상호작용은 풀이 질문·반례 토론. GitHub 로그인 기반이라 개발자 독자층과 정확히 맞음. **절차:** repo Settings에서 Discussions 켜기 → giscus.app 앱 설치 → 값 발급. | M |

### SEO·발견성

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **글마다 `description` front matter 추가** | **무엇:** 3개 글 front matter에 80~120자 요약 추가(현재 SERP 스니펫이 본문 첫 단어 "개요"로 채워짐). `_meta description`·JSON-LD·twitter:description 동시 해결. CLAUDE.md 템플릿·`new-post.sh`에 필수 필드로 박기. **왜:** jekyll-seo-tag가 description 없으면 본문 첫 텍스트를 자르는데 전부 "개요" 한 단어 → CTR 사실상 0. SEO 투자 대비 효과 1위. | S |
| **기본 OG 이미지(`social_preview_image`) 설정** | **무엇:** 1200×630 PNG를 `assets/img/og-default.png`로 만들고 `_config.yml` 99행 지정 → Chirpy가 자동으로 og:image + `summary_large_image` 출력. 글별 `image:` override 가능. **왜:** 현재 og:image 메타가 전무하고 twitter:card는 소형 summary. 카카오톡/디스코드/X 공유 시 썸네일 없는 밋밋한 링크 → 한국 PS 커뮤니티 공유 유입 손실. | M |
| **Google Search Console 인증 + sitemap 제출** | **무엇:** GSC에 `https://dhoklim.github.io` 등록(HTML 태그 방식) → `_config.yml` 43행 `webmaster_verifications.google`에 코드 → 배포 후 소유권 확인 → `sitemap.xml` 제출. **왜:** sitemap은 이미 생성되지만 등록 안 하면 색인 상태·유입 키워드·색인 속도 전혀 추적 불가. 신생 블로그 발견성의 출발점. | S |
| **네이버 서치어드바이저 등록** | **무엇:** searchadvisor.naver.com에 사이트 추가. 네이버는 jekyll-seo-tag 키 미지원이므로 인증 HTML 파일을 리포 루트에 두거나 head include로 `naver-site-verification` 메타 삽입. 인증 후 `sitemap.xml` + `feed.xml` 제출. **왜:** 한국어/한국 독자 대상인데 구글만 등록하면 네이버 검색 유입을 통째로 놓침. BOJ 종료로 독자들이 새 거점 찾는 지금이 노출 적기. | M |

### 도구·자동화

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **CI htmlproofer 백슬래시 깨짐 수정** | **무엇:** `.github/workflows/pages-deploy.yml` **56·57행 두 옵션 앞의 `\-\-` 접두 백슬래시**(`\-\-disable-external`, `\-\-ignore-urls`)가 버그 — 인자가 옵션으로 파싱 안 됨. (57행 ignore-urls 정규식 **내부**의 `\/`는 정상 이스케이프이므로 버그 아님.) 가장 안전한 수정은 해당 스텝을 `run: bash tools/test.sh`로 교체해 로컬과 동일 스크립트 사용. **왜:** 배포 게이트인 링크 검사가 의도대로 동작 안 함 → 죽은 링크/빌드 오류가 그대로 배포. "로컬 통과/CI 다름" 혼란의 구조적 원인이자 #1 항목의 게이트 복구 대상. | S |
| **`_config.yml` exclude에 `scripts` 추가 + 빌드 산출물 일관성 점검** | **무엇:** exclude(212~221행)에 `- scripts` 한 줄 추가(docs/tools는 이미 제외, scripts만 누락). 추가로 `_site`·`.jekyll-cache`·`vendor`가 `.gitignore`와 exclude 양쪽에서 일관 처리되는지 확인. exclude는 **사이트 노출만 막을 뿐 파일 삭제가 아니므로**, `scripts/new-post.sh`를 참조하는 `.vscode/tasks.json`·CLAUDE.md는 영향 없음을 확인. **왜:** scripts/가 `_site`로 복사돼 셸 스크립트가 노출됨. 동일 부류(빌드 산출물/캐시) 일관 정리로 노출·캐시 추적 문제를 함께 해결. | S |
| **Gemfile.lock 추적 + 재현성 확보** | **무엇:** `.gitignore` 2~4행에서 `Gemfile.lock` 무시 해제 후 `git add -f Gemfile.lock` 커밋. PLATFORMS에 `x86_64-linux-gnu` 이미 포함. **왜:** setup-ruby의 bundler-cache·캐시 키가 lock 기반 → 무시 시 캐시 미스(매번 gem 재설치), Dependabot bundler PR 불가, 로컬/CI gem 버전 불일치. | S |

### 콘텐츠 보존·신뢰

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **본인 콘텐츠·자산 백업/미러링 (외부 의존 붕괴 대비)** | **무엇:** BOJ가 2026-04-28 종료되며 문제·제출·대회 외 데이터가 삭제됩니다(공지). (1) 글에서 참조한 본인 과거 BOJ 제출/solved.ac 티어 캡처 등 사라질 자료를 종료 전(가능하면 남은 캐시/캡처라도 **즉시**) 스냅샷으로 `assets/img`에 보관, (2) 향후 외부 이미지·gist를 본문에 직접 끌어쓰지 말고 `assets/img/posts/`에 **자기호스팅**하는 규칙을 CLAUDE.md에 추가. **왜:** 최대 외부 의존 대상(BOJ/solved.ac)이 실제로 사라지는 중인데 '링크 교체'만으로는 사라진 자료 자체를 복구할 수 없음. 삭제 시점(2026-04-28)이 이미 지났으므로 잔여 자료 확보가 시급. | S |

### 브랜딩·UX

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **사이드바 아바타 이미지 추가** | **무엇:** 512×512 정사각 이미지를 `assets/img/avatar.png`로 저장, `_config.yml` 95행 `avatar: /assets/img/avatar.png`. **왜:** 현재 아바타 앵커가 빈 원으로 배포(`id="avatar"`에 배경 이미지 없음) → 미완성 인상. 첫인상·브랜드 식별성 좌우. | S |
| **커스텀 파비콘 세트 생성** | **무엇:** realfavicongenerator.net으로 favicon 세트 7종 생성 후 `assets/img/favicons/`에 배치(파일명 정확히 일치해야 테마 기본 덮어씀). **왜:** 현재 탭·PWA 설치 아이콘이 모두 Chirpy 기본 새 로고 → 수많은 Chirpy 블로그와 구분 안 됨. `pwa.enabled:true`라 설치 아이콘으로도 노출. *(파비콘 작업은 S지만 디자인 포함 시 Later로 분할 가능)* | S |
| **about 페이지 보강 — 글쓴이/연락처 + 백준 표기 정리** | **무엇:** `_tabs/about.md`(이미 학습경로/로드맵 안내 보유) 상단에 `## 글쓴이`: 한두 줄 소개 + GitHub(github.com/dhoklim) + 이메일(dhoklim@gmail.com) + "오류/제안 환영" 한 줄. 기존 "**문제 출처**: 백준(BOJ), Codeforces, 프로그래머스" 표기를 종료 사실에 맞게 정리(백준 종료/재공개 검토 명시 또는 살아있는 저지 우선). **왜:** "누가 쓰는가"가 없어 신뢰·기여 경로 부재. ⚠️ solved.ac API는 2026-04-12 중단 → 라이브 배지 임베드 불가, 정적 티어 표기 또는 캡처로 대체. *(드래프트의 "백준 1순위 문장 수정"·"로드맵 안내 추가"는 about.md에 해당 문장/누락이 없으므로 무효 — 위 액션으로 정정)* | S |

---

## 📋 다음 (Next)

### 콘텐츠

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **개념글 ↔ 풀이글 페어링 — 풀이 파이프라인 0→가동** | **무엇:** 개념글 1편마다 대표 문제 풀이글 1~2편 동반 발행 규칙. **`new-post.sh` 풀이 모드는 이미 완비**되어 있음(메뉴 "2) 문제 풀이" + 출처 분기 `case` + `categories: [문제풀이, ${SOURCE}]`(167행) + `${SRC_TAG}-${PROB_NUM}` 태그(168행)) → 신규 스크립트 작업 불필요, 그대로 사용. 첫 배치로 기존 3개 개념글에 풀이 6편 작성해 `문제풀이` 카테고리·문제번호 태그 생태계 부트스트랩. ⚠️ BOJ 종료 → CF/AtCoder/프로그래머스 문제 기준(158행 링크 하드코딩은 Now에서 수정). **왜:** 로드맵·개념글이 수십 문제를 가리키지만 walkthrough가 0건. 풀이글은 작성 비용 낮고 검색 유입(문제번호) 큼. | M |
| **입력 크기 → 허용 복잡도 치트시트** | **무엇:** N 제약별(≤10/≤20/≤500/≤2000/≤1e5/≤1e6/≤1e9) 1초 통과 가능 복잡도 매핑 표를 새 글 또는 `_includes/complexity-table.html`로. 로드맵 0단계에서 참조. **왜:** USACO Guide·CP2·Codeforces 공통 핵심 레퍼런스. 로드맵 자체가 "제약 읽고 복잡도 계산" 능력을 목표로 내거는데 그 도구표가 빠짐 — 자기 목표와의 직접 불일치. 표 하나로 끝나 비용 매우 낮음. | S |
| **글↔글, 글→로드맵 내부 링크 추가** | **무엇:** 각 글 하단에 "관련 글/다음 단계" 섹션 + `[로드맵](/roadmap/)` 1개씩. 대상 글 존재할 때만 `/posts/` 링크(없으면 텍스트). **왜:** 현재 글 본문 내부 링크 0개. 허브-스포크 구조 완성 → 크롤러 발견·PageRank 분배·체류시간·완주율 상승. `htmlproofer`로 검증. | M |

### 사이트 설정/기능

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **GoatCounter 연결 (조회수 + 분석 통합)** | **무엇:** goatcounter.com 가입 → `_config.yml` `analytics.goatcounter.id` + `pageviews.provider: goatcounter`. `JEKYLL_ENV=production` 빌드 시 스크립트 삽입. **왜:** 어떤 글이 읽히는지 데이터가 있어야 로드맵·후속 글 우선순위를 정함. 쿠키리스·무료·GDPR 친화. Chirpy pageviews 위젯은 GoatCounter 전용. | M |

### SEO·발견성

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **Bing 웹마스터도구 등록** | **무엇:** bing.com/webmasters에서 "GSC에서 가져오기"로 사이트·sitemap 일괄 등록(GSC 선행 필요). **왜:** Bing은 ChatGPT/Copilot 등 AI 검색 백엔드 색인원. Import로 클릭 몇 번에 끝나 비용 대비 이득. | S |
| **JSON-LD 보강 (author/publisher/image)** | **무엇:** OG 이미지 작업과 연동 — `social_preview_image`/글별 `image` 설정 시 Chirpy가 JSON-LD `image`도 채움. `_data/authors.yml` 또는 front matter `author`로 author 보강 후 rich-results 테스트. **왜:** 현재 JSON-LD에 author·publisher·image 누락 → 구글 Article 리치 결과 부적격. | S |

### 라이선스·저작권

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **LICENSE 및 콘텐츠 저작권/문제 지문 인용 정책 정비** | **무엇:** 루트 `LICENSE`가 아직 "MIT License / Copyright (c) 2021 Cotes Chung"(테마 저자)로 남아 본인 글의 저작권 주체가 불명확. (1) 코드/테마용 LICENSE와 **별도로 글(콘텐츠) 라이선스**(예: CC BY-NC 4.0 등)를 결정해 `_config.yml` 또는 about.md/footer에 명시, (2) 풀이글이 인용할 외부 문제(CF/AtCoder/프로그래머스 등) **지문 전문 복사 금지·요약+원문 링크** 원칙을 CLAUDE.md 발행 체크리스트에 명문화, (3) about.md에 코드 라이선스/저작권 한 줄 추가. **왜:** 현재 LICENSE는 테마 저자 명의 그대로라 권리관계가 비어 있고, 문제 지문 전문 인용은 저작권 분쟁 소지. 글이 늘기 전에 한 번 정해두면 일괄 수정 비용 방지. | S |

### 도구·자동화

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **외부 링크 검사 잡 (주간 스케줄)** | **무엇:** `.github/workflows/external-links.yml`(cron 주1회 + workflow_dispatch)로 `--disable-external` 빼고 htmlproofer 실행, 배포 차단 없이 리포트만. `--ignore-status-codes '0,403,429,503'` + `--hydra '{"max_concurrency":2}'`로 오탐 감소. **왜:** 외부 링크 24개+가 어떤 검사도 안 됨. 죽은 BOJ/오타 링크 노출. 본 빌드에 넣으면 외부 장애로 배포 막힘 → 분리 잡이 안전. | M |
| **Dependabot 설정 (github-actions + bundler)** | **무엇:** `.github/dependabot.yml`로 actions 핀·Chirpy·html-proofer 주간 업데이트 PR. **왜:** 보안 패치·Chirpy 마이너 업데이트 놓침. ⚠️ "Gemfile.lock 추적"과 함께 적용해야 bundler PR이 의미 있음. | S |
| **`new-post.sh` 슬러그 자동화 + 드래프트 지원** | **무엇:** 제목→영문 슬러그 자동 생성(엔터로 수락), `-d/--draft`로 `_drafts/`에 날짜 없는 파일 생성. **왜:** 한글/오타 슬러그 위험 + 작성 중 글을 main에 올리면 즉시 배포. `_drafts`는 production 빌드 제외로 안전한 초안 워크플로. *(풀이 모드 자체는 이미 구현돼 있으니 신설 대상은 슬러그 자동화·드래프트뿐)* | M |

### 브랜딩·UX

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **모바일 넓은 표 가로 스크롤 처리** | **무엇:** 로드맵(21행, 최대 102자 폭)·정렬글(6열 복잡도 표)을 360px 폭에서 점검. Chirpy 7.x는 자동 `.table-wrapper` 지원 → 그래도 넘치면 컬럼 분리/약어. CLAUDE.md에 "표 6열 이하, 셀 짧게" 가이드. **왜:** 로드맵 spec이 모바일 가독성을 강조하는데 표가 좁은 화면에서 잘림. 이동 중 모바일 조회 잦음. | M |
| **시리즈 prev/next 내비게이션 도입** | **무엇:** 이미 있는 `series-*` 태그 활용. front matter `series:` 키 + 순수 Liquid `_includes/series-nav.html`(플러그인 불필요·더 안전). 로드맵 단계와 매핑. **왜:** 바킹독·kks227식 연재 흐름이 한국 PS 블로그 강점이고 로드맵의 선수지식 연결 구조와 정확히 맞음 → 한 주제 완주율 상승. | M |
| **태그/난이도 인덱스 + 알고리즘별 문제 모음 페이지** | **무엇:** JusticeHui식 난이도(Bronze~Ruby)·주제별 큐레이션 탭(`_tabs/problems.md`). 연습문제를 `_data/problems.yml`로 구조화해 인덱스·글 양쪽 재사용. **왜:** USACO Guide·JusticeHui 공통 "전략적 탐색" 장치. 경쟁 프로그래머는 약점 난이도/주제로 바로 점프 선호. | M |
| **시리즈/난이도 태그를 로드맵 단계와 정렬** | **무엇:** 단계↔series 태그↔난이도 1:1 매핑 표를 CLAUDE.md에 추가(0~1단계→series-basic/ds, 7→series-graph, 8→series-tree, 9→series-dp 등). 한 글에 단계 난이도와 같은 difficulty 태그 1개 필수. **왜:** 태그가 로드맵과 어긋나면 독자가 태그 페이지로 모아보기 어렵고 "예정→링크" 교체 시 매번 즉흥 분류. 한 번 고정하면 자동 분류. | S |
| **재사용 스타일 가이드 + `new-post.sh` 템플릿 보강** | **무엇:** `docs/STYLE.md`에 개념글/풀이글 섹션 체크리스트, prompt 박스 4종·mermaid·LaTeX 관례, "핵심 요약/자주 하는 실수/선수지식·다음 단계" 표준 섹션 명문화. `new-post.sh` 히어독에 복잡도 요약 표·변형/응용·prompt 박스 스텁 추가. **왜:** 현 템플릿이 실제 발행글보다 얇아 글이 15편↑로 늘면 품질 흔들림. cp-algorithms식 예측 가능한 구조가 학습 효율의 핵심. | S |

---

## 🗄️ 나중 (Later)

### 콘텐츠

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **현실적 발행 캘린더(주 단위 케이던스)** | **무엇:** "권장 발행 순서" 12+편을 주 단위로 변환 — 주당 개념글 1 + 페어 풀이글 1~2(주 2~3편). 12주 공통기반 스프린트 → 격주 심화. 심화 트랙(10~13단계)은 비정기로 명시. **왜:** 글 3편이 전부 같은 날(2026-06-28) 발행 → 리듬 부재. 무리한 매일 발행 대신 묶음 케이던스로 선수지식 순서 지키며 번아웃 방지. | S |
| **개념 글 시각화 임베드/VisuAlgo 링크** | **무엇:** dfs-bfs·sorting·dp 글에 `> [VisuAlgo에서 단계별 보기](...) {: .prompt-tip }`. 필요 시 정적 호환 순수 JS canvas 데모. **왜:** USACO Guide가 VisuAlgo 공식 추천. "순서"가 핵심인 주제 이해도 상승. 이미 mermaid 도식이 강점이라 링크만으로 차별화. | S |
| **커뮤니티 크로스포스팅 + RSS 구독 유도** | **무엇:** 영문 요약본을 Codeforces blog/dev.to에 `rel=canonical`로 게시. 글 하단·about에 `/feed.xml` 구독 안내. CLAUDE.md 발행 체크리스트에 "크로스포스팅+canonical" 추가. **왜:** 신생 블로그 최대 약점은 유입 채널 부재. BOJ 종료로 독자들이 새 거점 찾는 지금이 노출 적기. | S |

### 사이트 설정/기능

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **`theme_mode` 기본값 결정 (선택)** | **무엇:** 현재 시스템 따름(합리적 기본). 코드 가독성 위해 다크 고정 원하면 `_config.yml` 85행 `theme_mode: dark`. **왜:** 긴 C++ 블록 많아 다크 선호 독자 있으나 시스템 따름이 접근성상 무난 → 취향 문제, 우선순위 낮음. | S |
| **`last_modified_at` 운영 규칙** | **무엇:** 큰 수정 시 front matter에 `last_modified_at: YYYY-MM-DD HH:MM:SS +0900` 추가 → Chirpy "Updated" 배지. CLAUDE.md에 규칙 기록(template엔 미포함). **왜:** PS 콘텐츠는 더 나은 풀이/반례로 잦은 갱신 → 갱신일 없으면 오래된 글로 오해. 신선도 SEO 유리. | S |

### SEO·발견성

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **RSS/Atom 피드 홍보 + 피드 favicon 연동** | **무엇:** about·사이드바에 `/feed.xml` 구독 안내. 커스텀 파비콘 도입 시 `feed.xml`의 `<icon>/<logo>`가 실제 이미지로 자동 반영. **왜:** 피드 생성은 정상이나 구독 유도가 전무 → 재방문 채널 손실. 네이버 RSS 제출과도 연결. | S |

### 도구·자동화

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **`new-post.sh` 로드맵 링크 자동 안내** | **무엇:** 개념글 생성 후 종료 메시지에 "`_tabs/roadmap.md`에 링크 추가" + 복붙용 표 라인 출력(자동 sed 삽입은 위치 추론 위험 → 안내까지만). **왜:** CLAUDE.md 규칙이지만 생성 안내에 빠져 자주 누락 → 죽은 학습 경로. | M |
| **pre-commit 훅 (빌드/링크/Liquid 가드)** | **무엇:** `tools/git-hooks/pre-commit` + `git config core.hooksPath`. raw/endraw 밖 `{{` 검출, 경량 grep 기본, `RUN_FULL=1`일 때만 `tools/test.sh`. **왜:** CLAUDE.md의 Liquid 함정·내부 링크 함정을 커밋 시점에 잡아 CI 실패 왕복 감소. | M |
| **이미지 최적화 파이프라인** | **무엇:** `tools/optimize-images.sh`(oxipng/pngquant/imagemagick) + 선택적 CI 용량 경고. CLAUDE.md에 "이미지는 assets/img/posts/" 규칙. **왜:** 현재 mermaid 위주라 이미지 적으나 그림 풀이·BOJ 캡처 백업 자산이 늘면 빌드·로딩 무거워짐. OG 이미지도 같은 파이프라인 활용. | M |
| **로컬 배포상태 확인 헬퍼** | **무엇:** `tools/deploy-status.sh`(gh CLI로 최근 워크플로 상태·실패 로그). `.vscode/tasks.json`에 "🩺 배포 상태" 태스크. **왜:** 현재 배포 확인은 Actions 웹 방문 필요 → 마찰. CI 인자 깨짐 같은 문제 조기 발견. | S |
| **CLAUDE.md/docs 동기화** | **무엇:** 로드맵이 이미 풀버전으로 커밋·푸시됨 → CLAUDE.md 124~130행 "로드맵 업데이트" 예시를 새 표 구조에 맞춤. 드래프트/배포상태/이미지/alt/자기호스팅/저작권 규칙 추가. **왜:** 설명과 실제 어긋남 방지, 기여자 일관성. | S |

### 브랜딩·UX

| 항목 | 무엇 / 왜 | 난이도 |
|------|-----------|--------|
| **브랜드 컬러 스킴 통일** | **무엇:** 강조색 1~2개 확정 후 파비콘·아바타·OG 이미지에 공통 적용. 필요 시 `assets/css/jekyll-theme-chirpy.scss`로 테마 변수 override. **왜:** 세 자산을 따로 만들면 색 제각각 → 하나의 강조색으로 일관된 인상. | M |
| **이미지 alt / 다이어그램 접근성 규칙 문서화** | **무엇:** CLAUDE.md에 "모든 이미지 의미 있는 alt 필수, mermaid 아래 한 줄 텍스트 요약" 규칙 + Chirpy 캡션 문법 예시. **왜:** 글 늘기 전 규칙 박아두면 일괄 수정 비용 방지. 세 글 모두 mermaid 사용 → 대체 설명 규칙 특히 중요. | S |
| **커스텀 도메인 vs github.io 판단** | **무엇:** 지금은 github.io 유지(CNAME 안 만듦). 전환 트리거(월 방문 수백/브랜드 확정)를 README에 1줄 기록. **왜:** 글 3편 초기엔 도메인·DNS·HTTPS 비용 > 이득. github.io는 무료 HTTPS·안정 인덱싱. | S |

---

## 📅 콘텐츠 발행 순서

선수 지식이 끊기지 않는 순서(로드맵 0~9단계 기반)로 다음 ~12편의 개념글을 발행합니다. 정렬·DFS/BFS·DP 입문(이미 발행)은 3·6단계 글인데 그 사이 0~5단계 기초가 비어 초보 독자가 끊기므로, 아래 순서로 "예정"을 실제 링크로 점진적으로 메웁니다.

| 순서 | 개념글 | 로드맵 단계 | 권장 series 태그 |
|------|--------|-------------|-------------------|
| 1 | 시간복잡도와 C++ STL | 0 | series-basic |
| 2 | 스택·큐·덱·우선순위 큐 | 1 | series-ds |
| 3 | 재귀와 백트래킹 | 2 | series-search |
| 4 | 이분 탐색과 매개변수 탐색 | 3 | series-search |
| 5 | 누적 합과 차분 배열 | 4 | series-prefix |
| 6 | 투 포인터와 슬라이딩 윈도 | 4 | series-prefix |
| 7 | 그리디 알고리즘 | 5 | series-greedy |
| 8 | 분할 정복과 거듭제곱 | 5 | series-divide |
| 9 | 위상 정렬과 DAG | 7-A | series-graph |
| 10 | 최단 경로 (Dijkstra/벨만포드/플로이드) | 7-A | series-graph |
| 11 | 서로소 집합과 MST | 7-A | series-graph |
| 12 | 배낭/LIS/LCS · Fenwick/세그먼트 트리 | 9-A / 8-A | series-dp / series-tree |

> 이후(13~15편): 트리 순회·LCA·트리 DP(8-A/9-B), 고급 DP(구간/비트마스크/자릿수)(9-A) 순으로 확장.

**개념 ↔ 풀이 페어링 전략**
- 규칙: **개념글 1편마다 대표 문제 풀이글 1~2편 동반 발행** (주당 개념 1 + 풀이 1~2 = 주 2~3편).
- 풀이글은 **이미 구현된** `new-post.sh` 풀이 모드("2) 문제 풀이")로 생성(`categories: [문제풀이, ${SOURCE}]`, `tags: [..., 난이도, ${SRC_TAG}-${PROB_NUM}]`), 본문은 문제 요약·접근·알고리즘&복잡도·코드·배운 점(지문 전문 복붙 금지 — 요약+원문 링크).
- ⚠️ **BOJ 종료(2026-04-28)·solved.ac API 종료(2026-04-12)** → 문제 출처는 Codeforces/AtCoder/프로그래머스 등 **살아있는 저지** 기준. BOJ 문제번호는 재공개 대비 **텍스트로 보존**(링크 금지). 출처별 링크 생성을 위해 `new-post.sh` 158행 BOJ 하드코딩 먼저 수정.
- 첫 배치: 기존 3개 개념글(정렬·DFS/BFS·DP)에 대해 풀이 6편(각 2편)을 먼저 작성해 `문제풀이` 카테고리·문제번호 태그 생태계 부트스트랩.
- 발행 시마다 로드맵 해당 단계 `예정`을 실제 링크로 교체 + "현재 공개된 글" 표에 행 추가.

---

## ⚡ 퀵윈 (30분 이내)

각 항목은 단독으로 30분 내 완료 가능하며 즉시 효과가 보입니다.

1. **CI htmlproofer 백슬래시 수정** — `pages-deploy.yml` 56·57행 `\-\-` 접두 제거(또는 스텝을 `run: bash tools/test.sh`로). 깨진 배포 게이트 복구. [S]
2. **배포된 로드맵 페이지 육안 확인** — `/roadmap/`가 470줄 풀버전으로 렌더되는지 실제 URL 확인(이미 커밋·푸시 완료). [S]
3. **글 3편에 `description` 추가** — SERP 스니펫 "개요" 한 단어 → 의미 있는 요약. [S]
4. **깨진 `twitter:site "@"` 제거** — `_data/contact.yml`·`share.yml` twitter 블록 정리. [S]
5. **Gemfile.lock 추적** — `.gitignore`에서 제거 후 `git add -f Gemfile.lock`. [S]
6. **`_config.yml` exclude에 `scripts` 추가** — 셸 스크립트 사이트 노출 차단. [S]
7. **GSC 인증 코드 입력** — `_config.yml` 43행 `webmaster_verifications.google`. [S]
8. **사이드바 아바타 지정** — 이미지 1장 추가 + 95행 `avatar:` 한 줄. [S]
9. **about.md 글쓴이 섹션 + 백준 표기 정리** — 소개 1~2줄 + GitHub/이메일/제보 안내, "문제 출처" 줄을 종료 사실에 맞게. [S]
10. **`new-post.sh` 158행 BOJ 하드코딩 수정** — 출처별 올바른 문제 URL(또는 BOJ는 텍스트). 신규 풀이글 깨진 링크 재생산 방지. [S]
11. **LICENSE 저작권 주체 확인** — 테마용 LICENSE 유지하되 글 콘텐츠 라이선스 한 줄 결정(about.md/footer). [S]
