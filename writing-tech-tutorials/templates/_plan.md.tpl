# <TOPIC> 入门指南 实施计划

> 生成时间：<DATE>
> 基于 spec：[_spec.md](./_spec.md)
> 状态：待用户批准 / 已批准

**Goal:** 按 spec 落地一份完整的 <TOPIC> 入门指南，产出 <N> 份 markdown 文档。

**Architecture:** 每 Task 独立完成一个章节：Step 1 写正文 → Step 2 grep 自查 → Step 3 commit。全部章节写完后跑跨章交叉审查。

**Tech Stack:** Markdown + GitHub-flavored mermaid 图。不写代码、不跑测试。每 Task 用「DoD 自查 + grep 校验」代替单元测试。

---

## 全局约定

1. **代码引用格式**：`[basename](file:///绝对路径#Lstart-Lend)`，链接文字用 basename，**不加反引号**
2. **行号基准**：commit `<COMMIT_HASH>`。写时要再用 `Read` 确认偏移没变
3. **mermaid 图**：用 ` ```mermaid ` 代码块；样式统一 `graph TB / graph LR / sequenceDiagram` 三选一
4. **📦 额外知识框**：`> 📦 **额外知识：XXX**` 开头，整段引用块（`>` 前缀）
5. **💡 一句话记住**：每章末尾恰好 1 行，`> 💡 **一句话记住**：...`
6. **commit 格式**：`docs(learn): <章节简述>`
7. **每 Task 完成后立即 commit**，不积压
8. **不改 <TOPIC> 源码、不加测试代码**

---

## 文件结构

<FILE_STRUCTURE_TABLE>

---

<CHAPTER_TASKS>

---

## Task <FINAL>: 跨章交叉审查

**Files:**
- Read only（不改任何文件）

- [ ] **Step 1: 术语一致性 grep 检查**

按 references/cross-review-checklist.md 跑术语一致性 grep 命令。

- [ ] **Step 2: 源码链接有效性**

对所有 `file:///` 引用做行号有效性 spot-check（抽 5-10 处 Read 一下）。

- [ ] **Step 3: README 相对链接完整性**

```bash
grep -oE "\./[a-zA-Z0-9_-]+\.md" docs/learn/<TOPIC>/README.md | sort -u | while read f; do
    [ -f "docs/learn/<TOPIC>/${f#./}" ] || echo "MISSING: $f"
done
```

Expected: 无 MISSING。

- [ ] **Step 4: 章节间概念呼应**

按 references/cross-review-checklist.md 逐条检查。

- [ ] **Step 5: 最终 commit**

```bash
git commit --allow-empty -m "docs(learn): finalize <TOPIC> tutorial (v0.1.0)"
```

<!-- Agent 填写指引：
1. <TOPIC>：目标模块名字
2. <N>：总章节数（含 README + 附录）
3. <COMMIT_HASH>：源码 commit
4. <FILE_STRUCTURE_TABLE>：从 spec 第 4 节展开的文件结构表
5. <CHAPTER_TASKS>：根据 spec 展开的 Task 1..N-1，每 Task 三步走
6. <FINAL>：跨章审查那个 Task 的编号（= N）
删除本注释再交付。

Task 展开示范（Task 2 举例）：
## Task 2: 第 0 章 —— 开篇 5 分钟

**Files:**
- Create: `docs/learn/<TOPIC>/00-intro.md`（目标 150-220 行）

- [ ] **Step 1: 写正文**
按 templates/00-intro.md.tpl 骨架填写，5 段式硬约束：
- 0.1 一个真实场景
- 0.2 类比开场
- 0.3 <TOPIC> 一句话讲清
- 0.4 📦 额外知识框（≥ 3 个）
- 0.5 💡 一句话记住

- [ ] **Step 2: 自查**
Run: wc -l + grep -c "📦" + grep -c "💡"
Expected: 行数 150-220；📦 ≥ 3；💡 = 1。

- [ ] **Step 3: Commit**
git add docs/learn/<TOPIC>/00-intro.md
git commit -m "docs(learn): add chapter 00 (5-min intro)"
-->
