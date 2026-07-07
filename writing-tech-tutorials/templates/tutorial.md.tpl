# <TOPIC> 深度讲解

> 源码基准：`<COMMIT_HASH>`
> 目标读者：小白 / 后端 / 老手三档共读

## 0. 阅读路线

| 读者 | 建议读法 |
| --- | --- |
| 小白 | 从 1 读到最后，先建立类比，再看源码 |
| 后端 | 重点读 2 / 3 / 4 / 5，关注数据流和边界 |
| 老手 | 先看 2 的全景图，再看 6 的设计决策和 7 的 Q&A |

## 1. 类比开场

用一个生活化类比解释 <TOPIC> 像什么，以及它解决什么问题。

> 📦 **额外知识：<TERM>**
> 解释第一个必须知道的背景概念。

## 2. 全景图

用 1-2 张 mermaid 图讲清楚组件关系和主流程。

```mermaid
graph LR
    A["用户输入"] --> B["入口/路由"]
    B --> C["核心模块"]
    C --> D["结果输出"]
```

## 3. 一步步走主流程

### Step 1：<STEP_TITLE>

先用一句话解释这一步在干嘛，再贴源码定位。

- 源码：[<basename>](file:///<absolute-path>#Lstart-Lend)

### Step 2：<STEP_TITLE>

- 源码：[<basename>](file:///<absolute-path>#Lstart-Lend)

> 📦 **额外知识：<TERM>**
> 解释第二个背景概念。

## 4. 核心对象和职责分工

| 对象 / 文件 | 职责 | 源码 |
| --- | --- | --- |
| <NAME> | <WHAT_IT_DOES> | [<basename>](file:///<absolute-path>#Lstart-Lend) |

## 5. 关键设计决策

### 决策 1：<DECISION>

讲清楚为什么这样设计、不这样会怎样、对维护者有什么影响。

> 📦 **额外知识：<TERM>**
> 解释第三个背景概念。

## 6. 常见坑和扩展点

- 坑 1：<PITFALL>
- 扩展点 1：<EXTENSION>

## 7. 面试 Q&A

### Q1：<QUESTION>

回答要包含：一句话结论、源码定位、追问点。

### Q2：<QUESTION>

回答要包含：一句话结论、源码定位、追问点。

## 8. 源码索引

| 文件 | 这份教程里讲了什么 |
| --- | --- |
| [<basename>](file:///<absolute-path>#Lstart-Lend) | <SUMMARY> |

> 💡 **一句话记住**：<TOPIC> 的核心就是：<ONE_SENTENCE>

<!-- Agent 填写指引：
1. 保留单文件结构，不拆 README / 00-intro / appendix。
2. 全文只保留 1 个 💡，放在文末。
3. 至少 4 个 📦，至少 8 个 file:/// 源码链接，至少 1 个 mermaid 图。
4. 删除本注释再交付。
-->
