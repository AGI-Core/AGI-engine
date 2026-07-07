---
name: writing-tech-tutorials
description: Use when writing deep tutorials that explain existing code/modules for multi-level learners (novices + backend + veterans). Produces 3-9 markdown files with a mandatory 5-part rhythm (analogy → step-by-step → source links → 📦 extra knowledge → 💡 one-line takeaway).
---

# writing-tech-tutorials

给一段"已存在的代码 / 模块"，产出面向多层级学习者的深度讲解文档集。

---

## 1. Skill 定位与边界

### 做什么

- 深度讲解已有代码 / 模块 / 架构
- 强制固定 5 段式教学节奏
- 固定骨架 + 弹性内核章节数
- 三档阅读路径（小白 / 后端 / 速查）
- 产出 markdown（含 file:/// 源码链接）
- 内联 spec → plan → 逐 Task 实施

### 不做什么

- ❌ API 参考手册（属于其他文档 skill）
- ❌ 单纯 README 或 changelog
- ❌ Web 设计文档 / UI 稿
- ❌ 面向产品经理的介绍稿
- ❌ 自动上传任何平台
- ❌ 多语言翻译 / 图片渲染

---

## 2. 触发词

- 显式：`Use Skill: writing-tech-tutorials`
- 关键词：`写入门指南`、`讲解模块`、`面试拆解`、`写学习文档`、`把 XX 模块讲清楚`

---

## 3. 完整工作流（5 Phase）

### Phase 0 —— 探测

skill 加载时先探测目标环境：

- [ ] 目标模块的入口文件在哪？
- [ ] 项目主语言是什么？
- [ ] 有没有已存在的 `docs/` 目录约定？
- [ ] git 仓库是否可用？

如果 git 未就绪 → fail-fast，提示用户初始化 git 或换目录。

### Phase 1 —— 澄清（一次一问）

使用 `AskUserQuestion` 一次一问。**必问 6 问**：

1. 目标模块的准确路径是什么？
2. 受众定位（默认三档：小白 + 后端 + 老手；可覆盖）
3. 期望产出规模？
   - < 500 行代码 → 3-4 份（README + 00 + 01 + 02 + appendix-a）
   - 500-2000 行 → 6-7 份
   - > 2000 行 → 8-9 份
4. 面试 Q&A 附录题数（默认 ≥ 15，三档：开场 5 + 原理 8 + 拷打 5）
5. 源码链接锚定的 commit hash（默认 HEAD）
6. 额外的写作约束（英文？不能提竞品？...）

**用户要求跳过澄清 → 拒绝跳过**，重新问核心 3 问（受众 / 规模 / commit hash），其余可用默认。

### Phase 2 —— 写 `_spec.md`

- 路径：`<用户当前项目>/docs/learn/<topic>/_spec.md`
- 加载 skill 项目内 `templates/_spec.md.tpl`
- 按 Phase 1 的答案填充占位符
- 写完 commit（`docs(learn): add <topic> tutorial spec`）
- **HARD-GATE**：等用户批准，用户不批准就回到 Phase 2 重写

### Phase 3 —— 写 `_plan.md`

- 路径：`<用户当前项目>/docs/learn/<topic>/_plan.md`
- 加载 `templates/_plan.md.tpl`
- 按 spec 的章节骨架展开成 Task 1..N（每 Task 三步：写 → 自查 → commit）
- 最后一个 Task 固定是"跨章交叉审查"
- 写完 commit（`docs(learn): add <topic> tutorial plan`）
- **HARD-GATE**：等用户批准

**注意路径归属**：skill 每次触发时的产出（_spec / _plan / 章节 md）都写到**用户当前项目**的 `docs/learn/<topic>/`，不写到 skill 自己的仓库里。skill 仓库只存 SKILL.md / templates / references。

### Phase 4 —— 逐 Task 实施

对 Task 1..N-1（章节 Task）依次执行：

- **Step 1 写正文**：加载对应模板（`templates/README.md.tpl` / `00-intro.md.tpl` / `01-overview.md.tpl` / `chapter.md.tpl` / `appendix-a-interview-qa.md.tpl` / `appendix-b-code-index.md.tpl`），先读 `references/rhythm-checklist.md` 强化 5 段式约束，先读 `references/audience-guide.md` 明确受众策略，先读 `references/source-linking.md` 明确源码链接规范
- **Step 2 grep 自查**：读 `references/self-review-grep.md`，跑对应命令。不达标 → 补内容 → 再自查，最多 3 轮
- **Step 3 commit**：`docs(learn): add chapter <NN> (<title>)`

Task N（跨章交叉审查）：
- 读 `references/cross-review-checklist.md`
- 逐条 checkbox 走
- 全通过 → 打空 commit `docs(learn): finalize <topic> tutorial (v0.1.0)`

### Phase 5 —— 完成钩子（不阻塞）

emit **中性提示**：

> "✅ 完成：<N> 份 markdown 已写入 `docs/learn/<topic>/`。如需分发：
> - `git push` 到远程仓库
> - 上传到你使用的知识库 / wiki 平台
> - 转成 PDF / EPUB 供离线阅读
>
> skill 已完成本次任务，是否继续由你决定。"

**不点具体平台名 / 公司名 / 内部工具名。**

---

## 4. 硬约束

### 4.1 5 段式节奏

每章内核**必须**按顺序包含：
1. 类比开场
2. 一步步走
3. 贴源码定位
4. 📦 额外知识框（每章至少 1 个）
5. 💡 一句话记住（每章末尾恰好 1 个）

**详细规则见 `references/rhythm-checklist.md`。**

### 4.2 章节骨架

**固定 4 份**：README / 00-intro / 01-overview / appendix-a-interview-qa

**强推荐 1 份**：appendix-b-code-index

**弹性 2-6 份**：内核章（02-XX / 03-XX / 04-XX ...）

### 4.3 源码链接

- 格式：`[basename](file:///绝对路径#Lstart-Lend)`
- 链接文字用 basename，**不加反引号**
- 详细规则见 `references/source-linking.md`

### 4.4 自查阈值

| 章节 | 行数 | 📦 | 💡 | file:/// | mermaid |
| --- | --- | --- | --- | --- | --- |
| README.md | 60-90 | 0 | 0 | 0 | 0 |
| 00-intro.md | 150-220 | ≥ 3 | 1 | ≥ 1 | ≥ 1 |
| 01-overview.md | 200-300 | ≥ 3 | 1 | ≥ 5 | ≥ 2 |
| 内核章 | 250-450 | ≥ 2 | 1 | ≥ 8 | 视需要 |
| appendix-a | 300-500 | 视需要 | 0 | ≥ 5 | 0 |
| appendix-b | 60-120 | 0 | 0 | ≥ 10 | 0 |

**详细命令见 `references/self-review-grep.md`。**

---

## 5. 反模式（不要这么做）

- ❌ 直接跳过 Phase 1 澄清就开写
- ❌ 一口气写完全部章节，最后统一自查（要每 Task 三步走）
- ❌ 不 commit 就进下一个 Task
- ❌ 用相对路径做源码链接
- ❌ 章节里出现"这个熟练开发者应该知道..."（假设失效就劝退小白）
- ❌ 把 spec/plan 放到 skill 自己的仓库里
- ❌ Phase 5 提示里出现具体公司名 / 平台名 / 内部工具名
- ❌ 用脚本渲染文档正文（文档质量的核心在 Agent 的语言能力，脚本模板化只出干瘪骨架）

---

## 6. 常见问答

### Q1: 如果模块很小（< 200 行代码），还需要 3-4 份文档吗？

如果模块真的极小（一两个函数），可以只出 README + 单章合并版。但 skill 默认是"深度讲解"，太小的模块可能不适合本 skill。

### Q2: 章节里 mermaid 图不够怎么办？

01-overview 至少 2 张。其他章节视需要。硬凑图不如少画——图要能"背下来"才有价值。

### Q3: 用户中途 cancel 怎么办？

保留已 commit 的章节，`_plan.md` 里标记未完成的 Task。下次触发 skill 时先读 `_plan.md`，从未完成 Task 继续。

### Q4: 找不到目标模块的路径怎么办？

Phase 0 探测阶段就 fail-fast，问用户"目标模块在哪个路径"，不猜测。

### Q5: 用户要求写英文文档怎么办？

Phase 1 第 6 问"额外写作约束"里让用户明确，模板里的中文提示相应换成英文。

### Q6: skill 需要哪些运行时依赖？

- Agent 内置工具（Read / Write / Edit / Grep / Glob / Shell / AskUserQuestion / TaskCreate）
- `git` 命令行工具
- 无第三方脚本 / 无 MCP 依赖

### Q7: 我可以扩展 skill 加自己的模板吗？

可以。fork 本 skill 项目，往 `templates/` 加自己的 `.tpl`，往 SKILL.md 里加对应的加载指令即可。

### Q8: 写完的文档怎么发布到知识库？

skill 不做。Phase 5 emit 提示后，你手动用 `git push` 或其他知识库平台的工具 / skill 发布。

---

## 7. 完成条件

skill 认定完成的判据：

- [ ] Phase 1 六问已回答
- [ ] Phase 2 `_spec.md` 已写、用户已批准
- [ ] Phase 3 `_plan.md` 已写、用户已批准
- [ ] Phase 4 全部 Task 完成（写 → 自查 → commit 各三步走过）
- [ ] 跨章交叉审查通过
- [ ] Phase 5 完成钩子已 emit

任一未满足 → skill 处于 in-progress，不能声称完成。

---

## 8. 失败处理

| 场景 | skill 行为 |
| --- | --- |
| 用户要求跳过 Phase 1 澄清 | 拒绝跳过，重新问核心 3 问 |
| 用户对 spec 不批准 | 回到 Phase 2 重写，不进 Phase 3 |
| 某章 grep 自查不达标 | 补内容 → 再自查，最多 3 轮，仍不达标停下问用户 |
| git 未安装 / 无 git 仓库 | Phase 0 fail-fast，提示用户初始化 |
| 用户中途 cancel | 保留已 commit 的章节，允许下次继续 |
| 找不到目标模块 | Phase 0 问用户"目标模块在哪个路径" |

---

## 9. 版本

- v0.1.0（当前）
- 后续扩展见 `_spec.md` 第 17 节（`--fast` 模式 / 增量更新 / CLI 检查工具 / 自动术语表）

---

## 附：加载顺序总结

Agent 触发 skill 后按以下顺序读文件：

```
Phase 0: SKILL.md（本文件）
Phase 1: SKILL.md 第 3.1 节 6 问清单
Phase 2:
  - templates/_spec.md.tpl
  - references/audience-guide.md（澄清受众策略）
Phase 3:
  - templates/_plan.md.tpl
Phase 4 每个章节 Task:
  - 对应模板（templates/README.md.tpl / 00-intro.md.tpl / 01-overview.md.tpl / chapter.md.tpl / appendix-a-interview-qa.md.tpl / appendix-b-code-index.md.tpl）
  - references/rhythm-checklist.md（写作节奏）
  - references/audience-guide.md（受众策略）
  - references/source-linking.md（源码链接规范）
  - references/self-review-grep.md（自查命令）
Phase 4 最后:
  - references/cross-review-checklist.md
Phase 5: emit 完成提示
```
