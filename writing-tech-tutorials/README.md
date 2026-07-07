# writing-tech-tutorials

一个 Agent Skill，帮你把"已存在的代码 / 模块"写成面向多层级学习者的深度讲解文档集。

## 特色

- **强制 5 段式教学节奏**：类比 → 一步步走 → 贴源码 → 📦 额外知识 → 💡 一句话记住
- **三档阅读路径**：小白线 / 后端线 / 速查线，一份文档服务多类读者
- **内联 spec → plan → 逐 Task 实施**：不依赖外部 skill，独立可用
- **每章 grep 自查 + 跨章交叉审查**：产出质量有底线
- **强产出结构**：README + 内核章 + 面试 Q&A 附录 + 代码索引附录

## 效果预览

一份"HTTP 服务器"模块讲解的 `00-intro.md` 节选：

> **0.1 一个真实场景**
> 新来的同事问"我们的 HTTP 服务器是怎么处理请求的"，同事们说不清楚——因为它跨越了 Router / Middleware / Handler 三层...
>
> **0.2 类比**
> HTTP 服务器就像一个餐厅前台：Router 是引位员（把客人引到对应桌），Middleware 是服务员（上菜前擦一下桌子），Handler 是厨师（真正做菜）。
>
> ...
>
> > 📦 **额外知识：什么是 TCP？**
> > TCP 是"打电话"式的通信协议——先握手确认对方在线，再一段一段传数据，每段都要对方确认收到。HTTP 就跑在 TCP 之上。
>
> > 💡 **一句话记住**：HTTP 服务器 = 监听端口 + 分发请求 + 返回响应。

## 兼容性

适用于支持 Skill 规范的 Agent 环境。`install.sh` 会优先安装到 Codex 的 skill 加载路径（`$CODEX_HOME/skills` 或 `~/.codex/skills`），同时兼容 `~/._agent-cn/skills`、`~/.trae-cn/skills`、`~/.claude/skills`。也可以通过环境变量 `SKILL_INSTALL_ROOT` 指定安装目录。

## 安装

```bash
git clone git@github.com:AGI-Core/AGI-engine.git
cd AGI-engine/writing-tech-tutorials
./install.sh
```

安装后请新开 Agent 会话或重启 Agent，让 skill 列表刷新。

自定义安装位置：

```bash
SKILL_INSTALL_ROOT=~/my-skills ./install.sh
```

## 卸载

```bash
./uninstall.sh
```

## 触发

在支持 skill 的 Agent 里发送：

- `Use Skill: writing-tech-tutorials` （显式触发）
- 或使用触发词：`写入门指南` / `讲解模块` / `面试拆解` / `写学习文档`

## 产出示例

skill 会在**用户当前项目**下生成：

```
docs/learn/<你的模块>/
├── _spec.md                          # 需求 spec
├── _plan.md                          # 实施 plan
├── README.md                         # 导航 + 三档阅读路径
├── 00-intro.md                       # 5 分钟建立直觉
├── 01-overview.md                    # 全景图 + 组件分工
├── 02-<核心>.md                      # 内核章（弹性）
├── 03-<核心>.md
├── 04-design-decisions.md            # 设计决策深潜
├── 05-pitfalls-and-extensions.md     # 坑 + 扩展
├── appendix-a-interview-qa.md        # 面试 Q&A（≥15 题）
└── appendix-b-code-index.md          # 代码索引
```

## 版本

v0.1.0

## License

MIT
