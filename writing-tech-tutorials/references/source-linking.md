# 源码链接规范（file:/// 用法）

> 这份文档规定所有源码引用的**格式、行号锚定、常见错误**。所有章节写代码引用前必读。

## 唯一正确格式

```markdown
[<basename>](file:///<绝对路径>#L<start>-L<end>)
```

举例：

```markdown
[splitter.go](file:///Users/xxx/project/internal/rag/splitter.go#L45-L58)
```

**关键点**：

1. 链接文字用 basename（`splitter.go`），不用完整路径
2. **不加反引号**（❌ `` [`splitter.go`](...) ``）
3. `file:///` 必须是三个斜杠（file:/ + 绝对路径开头的 /）
4. 行号用 `#L<start>-L<end>` 格式
5. 单行也写成 `#L45-L45` 或 `#L45`

---

## 好例子 vs 坏例子

### ✅ good：单行引用

```markdown
配置默认值定义在 [config.go](file:///abs/path/config.go#L23) 里。
```

### ✅ good：行范围引用

```markdown
核心切分算法在 [splitter.go](file:///abs/path/splitter.go#L45-L58)：

（贴代码块）

**为什么这么做**：...
```

### ✅ good：整个函数

```markdown
`Query` 方法定义见 [rag.go](file:///abs/path/rag.go#L100-L145)——包含 5 步流程。
```

### ❌ bad：加了反引号

```markdown
[`splitter.go`](file:///...)
```

**问题**：反引号让 markdown 渲染器把链接文字当成代码，样式错乱。

### ❌ bad：只写文本没链接

```markdown
在 splitter.go 大概第 45 行附近...
```

**问题**：读者要自己搜文件、自己数行，可复现性差。

### ❌ bad：相对路径

```markdown
[splitter.go](../src/splitter.go)
```

**问题**：相对路径依赖当前打开位置。file:/// 绝对路径在 IDE 里可以直接点开。

### ❌ bad：老式 line 42 写法

```markdown
splitter.go 的 `Split` 函数（line 45-58）...
```

**问题**：不是链接，读者要自己打开 IDE 定位。

### ❌ bad：链接指向删掉的行

```markdown
[old_helper.go](file:///abs/path/old_helper.go#L10)
```

**问题**：文件已删除。写完必须做交叉审查。

---

## 单行 vs 行范围的选择

| 场景 | 用哪个 |
| --- | --- |
| 引用一个变量定义 | 单行 `#L23` |
| 引用一个函数体 | 行范围 `#L45-L58` |
| 引用一个 struct | 行范围 `#L10-L20` |
| 引用一个多层嵌套的复杂逻辑 | 行范围（覆盖到 nested 部分） |
| 只想说"这个概念在这个文件里" | 无锚点 `[filename](file:///...)` |

**原则**：读者点开链接后能**恰好看到你在讲的那段**。多贴几行没关系，少贴到断章要修。

---

## 行号锚定 commit

**为什么要锚定 commit**：源码会变，行号会飘。锚定 commit 后读者知道文档写作时看的是哪个版本。

### 在 README.md 里明确标出 commit hash

```markdown
## 阅读约定

- 源码引用形如 `basename Lstart-Lend`，行号基于 commit `abc1234`；
  文件结构后续若有变动，请按"文件名 + 函数名"定位。
```

### 每章末尾（可选）加提示

```markdown
> ⚠️ 注意：本章代码引用基于 commit `abc1234`。若你在读时源码有变动，
> 优先用文件名 + 函数名定位，行号可能已经飘移。
```

### 有条件的话用 GitHub 永久链接

如果项目有对应的 GitHub 仓库，也可以在 file:/// 之外补一份 GitHub `blob` 链接（`https://github.com/xxx/yyy/blob/<commit>/path/file.go#L45-L58`）—— GitHub 链接对**没克隆代码的读者**更友好，file:/// 链接对**已经克隆代码的读者**更方便（IDE 里可以直接跳）。

---

## 行号飘移的应对

写完文档后，如果源码 refactor 了，行号飘移，处理策略：

### 策略 A：跟着 refactor 更新链接

- 优点：文档保鲜
- 缺点：refactor 频繁时维护成本高

### 策略 B：只更新概念，不追行号

- 保留链接文本 `basename Lxx-Lyy`
- 加一句"若行号已飘移，用函数名 XxxFunc 定位"
- 优点：低维护
- 缺点：读者需要自己定位

### 策略 C（推荐）：v0.1 用策略 A，锁定 commit

- 文档发布时打 tag 记录 commit
- 后续大 refactor → 出 v0.2 版本文档，重新走一遍源码链接
- 老 tag 保留原状（有历史价值）

---

## 每章最少几个链接？

- README.md：0 个（导航文档，用相对链接跳章节即可）
- 00-intro.md：≥ 1 个（大概率是"我们的实现在这个文件"这种）
- 01-overview.md：≥ 5 个（组件表 + 架构图里每个组件都要有链接）
- 内核章：≥ 8 个（每步至少 1 个）
- appendix-a：≥ 5 个（每题的核心引用）
- appendix-b：≥ 10 个（这就是代码索引，每个文件一行）

**具体阈值见 [self-review-grep.md](./self-review-grep.md)。**
