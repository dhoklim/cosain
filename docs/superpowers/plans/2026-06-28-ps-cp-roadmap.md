# PS/CP Algorithm Roadmap Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the short roadmap page with a beginner-to-BOJ-Diamond/Ruby and ICPC World Finals learning map.

**Architecture:** Keep one Chirpy page as the public entry point. Present a linear common core first, branch into six advanced tracks, then reunite the tracks through integrated problem solving and contest practice. Link only published posts; mark unpublished articles as `예정`.

**Tech Stack:** Jekyll, Chirpy 7.6.0, Markdown, Liquid, html-proofer

## Global Constraints

- Write the page in Korean and use C++17 as the assumed language.
- Keep `categories` and tags out of the roadmap page because it is a tab, not a post.
- Link the three published posts at `/posts/sorting-algorithms/`, `/posts/dfs-bfs/`, and `/posts/dynamic-programming/`.
- Do not create internal links for unpublished posts, tags, or categories.
- Keep tables narrow enough to read on mobile; put long explanations outside tables.
- Treat BOJ difficulty ranges as guidance, not guarantees.

---

### Task 1: Replace the roadmap content

**Files:**
- Modify: `_tabs/roadmap.md`

**Interfaces:**
- Consumes: the page front matter already used by Chirpy and the published post permalinks listed under Global Constraints
- Produces: one navigable roadmap page with a common core, advanced tracks, mastery criteria, contest practice, and publication order

- [x] **Step 1: Preserve the front matter and replace the introductory copy**

Keep the existing `title`, `icon`, and `order`. State that the roadmap starts with C++ fundamentals and extends to BOJ Diamond/Ruby and ICPC World Finals topics. Explain that steps 0–6 are sequential and steps 7–12 can be studied in parallel.

- [x] **Step 2: Add a compact overview table**

Create phases for 입문, 기반, 중급, 심화, 최상위, and 실전. Give each phase a stage range, typical BOJ difficulty, and one concrete outcome.

- [x] **Step 3: Add stages 0–6 as the common core**

Cover C++/complexity; basic data structures; brute force/backtracking; sorting/binary search; prefix sum/two pointers/sweeping; greedy/divide-and-conquer; DFS/BFS/basic DP. For each stage include prerequisites, topics, completion criteria, and article status. Use the three live links where applicable.

- [x] **Step 4: Add advanced tracks 7–12**

Create separate sections for graph; tree/query data structures; dynamic programming; strings; number theory/combinatorics; computational geometry/offline techniques. Within each track order topics from Gold/Platinum fundamentals to Diamond/Ruby material and identify prerequisites.

- [x] **Step 5: Add integrated mastery and contest practice**

Describe mixed-domain problem solving, proof and complexity writing, implementation templates, stress testing, upsolving, virtual contests, and ICPC team operation. Add measurable completion criteria instead of promising a rating.

- [x] **Step 6: Add a publication order**

List the next concept articles in an order that fills prerequisites: complexity/STL, basic data structures, recursion/backtracking, binary search, prefix sum/two pointers, greedy, shortest path, DSU/MST, topological sort, segment tree, and advanced DP.

### Task 2: Validate the finished page

**Files:**
- Test: `_tabs/roadmap.md`

**Interfaces:**
- Consumes: the completed Markdown page
- Produces: evidence that the page has valid whitespace, valid internal links, and a successful project test

- [x] **Step 1: Scan for invalid placeholders and links**

Run:

```bash
rg -n '작성 중|TODO|TBD|\]\(/(tags|categories|posts)/[^)]*\)' _tabs/roadmap.md
```

Expected: only the three published `/posts/` links appear; no `작성 중`, `TODO`, `TBD`, tag, or category links appear.

- [x] **Step 2: Check whitespace errors**

Run:

```bash
git diff --check
```

Expected: exit code 0 with no output.

- [x] **Step 3: Run the repository test**

Run:

```bash
bash tools/test.sh
```

Expected: Jekyll build and html-proofer finish successfully with exit code 0.

- [x] **Step 4: Review the final diff**

Run:

```bash
git diff -- _tabs/roadmap.md
```

Expected: only the approved roadmap page is replaced; its front matter remains valid.
