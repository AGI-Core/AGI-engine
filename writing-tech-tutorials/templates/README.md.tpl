# <TOPIC_TITLE> 入门指南

> 这是一份面向**初次接触 <TOPIC>** 的开发者的深度讲解。读完它，你应该能在面试里把"我们的 <TOPIC> 是怎么做的"这件事讲清楚、讲出亮点、扛住"为什么这样设计"的追问。

## 这份文档是给谁看的

- **A 类·小白**：<AUDIENCE_A>
- **B 类·后端**：<AUDIENCE_B>
- **C 类·老手**：<AUDIENCE_C>

不论你是哪一类，**全文不预设你已经知道 <TOPIC> 领域的任何概念**。出现的每一个生词都会先用类比讲一遍、再贴源码、再用一句"📦 额外知识框"补背景。

## <TOPIC> 在项目里的位置

<POSITION_INTRO>

关键源码目录：

```
<SOURCE_TREE>
```

## 推荐阅读路径

| 读者类型 | 时间预算 | 推荐顺序 |
| --- | --- | --- |
| 🐤 **小白线**（从零开始） | <TIME_BUDGET_A> | 00 → 01 → 02 → ... → 附录 A → 附录 B |
| 🦾 **后端线**（懂基础不懂 <TOPIC>） | <TIME_BUDGET_B> | 00 → 01 → <CORE_CHAPTER>（重点） → 04 → 附录 A |
| ⚡ **速查线**（面试前临阵磨枪） | <TIME_BUDGET_C> | 01（看图） → 04 → 附录 A |

## 章节索引

<CHAPTER_INDEX>

## 阅读约定

- 📦 **额外知识框**：补充 <TOPIC> 通用背景概念，不读不影响主线，但读了能补足学院派背景。
- 💡 **一句话记住**：每章末尾的速记，面试前再过一眼。
- 源码引用形如 `basename Lstart-Lend`，行号基于 commit `<COMMIT_HASH>`；文件结构后续若有变动，请按"文件名 + 函数名"定位。
- 引用代码块时统一用对应语言标记，方便 IDE 着色。

## 一图速查的术语

| 术语 | 一句话理解 | 在哪一章详细讲 |
| --- | --- | --- |
<TERM_TABLE_ROWS>

## 不在本文范围内

<OUT_OF_SCOPE>

## 反馈

发现错别字、链接失效、概念讲错，请直接在仓库提 issue 或 PR；引用本文档时麻烦带上 commit hash，文档迭代时不至于歧义。

<!-- Agent 填写指引：
1. <TOPIC> / <TOPIC_TITLE>：目标模块的简称与全称
2. <AUDIENCE_A/B/C>：三类读者
3. <POSITION_INTRO>：一段话说 <TOPIC> 在整个项目里扮演什么角色
4. <SOURCE_TREE>：关键源码目录树（4-8 行）
5. <TIME_BUDGET_A/B/C>：三档时间预算，如 3h / 90min / 30min
6. <CORE_CHAPTER>：内核最重要的一章的编号，如"03"
7. <CHAPTER_INDEX>：markdown 列表，格式 "- [00 XXX](./00-intro.md)"
8. <TERM_TABLE_ROWS>：术语速查表的行
9. <OUT_OF_SCOPE>：明确说不讲什么，防止读者期望不匹配
10. <COMMIT_HASH>：源码 commit
删除本注释再交付。
-->
