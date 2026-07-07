# <TOPIC> 入门指南 实施计划

> 生成时间：<DATE>
> 基于 spec：[_spec.md](./_spec.md)
> 状态：待用户批准 / 已批准

**Goal:** 按 spec 落地一份完整的 <TOPIC> 入门指南，产出 `_spec.md`、`_plan.md`、`<TOPIC>.md` 三份 markdown。

**Architecture:** 默认单文件正文：Task 1 写 `<TOPIC>.md` → Task 2 做整体验收。每 Task 都按 Step 1 执行 → Step 2 自查 → Step 3 commit。

**Tech Stack:** Markdown + GitHub-flavored mermaid 图。不写代码、不跑测试。每 Task 用「DoD 自查 + grep 校验」代替单元测试。

---

## 全局约定

1. **代码引用格式**：`[basename](file:///绝对路径#Lstart-Lend)`，链接文字用 basename，**不加反引号**
2. **行号基准**：commit `<COMMIT_HASH>`。写时要再用 `Read` 确认偏移没变
3. **mermaid 图**：用 ` ```mermaid ` 代码块；样式统一 `graph TB / graph LR / sequenceDiagram` 三选一
4. **📦 额外知识框**：`> 📦 **额外知识：XXX**` 开头，整段引用块（`>` 前缀）
5. **💡 一句话记住**：全文末尾恰好 1 行，`> 💡 **一句话记住**：...`
6. **commit 格式**：`docs(learn): <简述>`
7. **每 Task 完成后立即 commit**，不积压
8. **不改 <TOPIC> 源码、不加测试代码**

---

## 文件结构

| 文件 | 状态 | 说明 |
| --- | --- | --- |
| `docs/learn/<TOPIC>/_spec.md` | 已创建 | 教程规格 |
| `docs/learn/<TOPIC>/_plan.md` | 当前文件 | 实施计划 |
| `docs/learn/<TOPIC>/<TOPIC>.md` | 待创建 | 单文件整合教程正文 |

---

## Task 1: 写单文件整合教程

**Files:**
- Create: `docs/learn/<TOPIC>/<TOPIC>.md`（目标 350-900 行）

- [ ] **Step 1: 写正文**

加载 `templates/tutorial.md.tpl`，按 spec 的正文结构填写：

1. 阅读路线
2. 类比开场
3. 全景图
4. 一步步走主流程
5. 核心对象和职责分工
6. 关键设计决策
7. 常见坑和扩展点
8. 面试 Q&A
9. 源码索引

- [ ] **Step 2: 自查**

```bash
FILE=docs/learn/<TOPIC>/<TOPIC>.md
wc -l "$FILE"
grep -c "📦" "$FILE"
grep -c "💡 \*\*一句话记住\*\*" "$FILE"
grep -c "file:///" "$FILE"
grep -c "^\`\`\`mermaid" "$FILE"
```

Expected: 行数 350-900；📦 ≥ 4；💡 = 1；file:/// ≥ 8；mermaid ≥ 1。

- [ ] **Step 3: Commit**

```bash
git add docs/learn/<TOPIC>/<TOPIC>.md
git commit -m "docs(learn): add <TOPIC> tutorial"
```

---

## Task 2: 整体验收

**Files:**
- Read only（不改任何文件）

- [ ] **Step 1: 术语一致性 grep 检查**

按 references/cross-review-checklist.md 跑术语一致性 grep 命令，范围是 `docs/learn/<TOPIC>/<TOPIC>.md`。

- [ ] **Step 2: 源码链接有效性**

对所有 `file:///` 引用做行号有效性 spot-check（抽 5-10 处 Read 一下）。

- [ ] **Step 3: 正文结构完整性**

确认 `<TOPIC>.md` 包含阅读路线、类比开场、全景图、主流程、职责分工、设计决策、坑点、Q&A、源码索引。

- [ ] **Step 4: 最终 commit**

```bash
git commit --allow-empty -m "docs(learn): finalize <TOPIC> tutorial (v0.1.0)"
```

<!-- Agent 填写指引：
1. <TOPIC>：目标模块名字
2. <COMMIT_HASH>：源码 commit
删除本注释再交付。
-->
