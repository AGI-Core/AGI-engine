# 每章自查 grep 命令

> 每写完一章，把这份文档里的命令跑一遍。达标才 commit。
> 阈值参见 [_spec.md](../_spec.md) 第 7 节。

## 阈值总表

| 章节 | 行数 | 📦 | 💡 | file:/// | mermaid |
| --- | --- | --- | --- | --- | --- |
| README.md | 60-90 | 0 | 0 | 0 | 0 |
| 00-intro.md | 150-220 | ≥ 3 | 1 | ≥ 1 | ≥ 1 |
| 01-overview.md | 200-300 | ≥ 3 | 1 | ≥ 5 | ≥ 2 |
| 内核章 | 250-450 | ≥ 2 | 1 | ≥ 8 | 视需要 |
| 04-design-decisions | 300-500 | ≥ 2 | 1 | ≥ 8 | 0 |
| 05-pitfalls-and-extensions | 200-350 | ≥ 1 | 1 | ≥ 5 | 0 |
| appendix-a | 300-500 | 视需要 | 0 | ≥ 5 | 0 |
| appendix-b | 60-120 | 0 | 0 | ≥ 10 | 0 |

---

## 通用命令（每章都跑）

设 `<file>` 为章节文件路径，比如 `docs/learn/rag/00-intro.md`：

```bash
FILE=<file>

# 1. 行数
wc -l $FILE

# 2. 📦 数量
grep -c "📦" $FILE

# 3. 💡 一句话记住数量（应该恰好 1）
grep -c "💡 \*\*一句话记住\*\*" $FILE

# 4. file:/// 源码链接数量
grep -c "file:///" $FILE

# 5. 二级标题数量（通常应该 = 5，5 段式）
grep -c "^## " $FILE
```

---

## 章节专项命令

### README.md 专项

```bash
FILE=docs/learn/<topic>/README.md

# 章节相对链接是否都存在
grep -oE "\./[a-zA-Z0-9_-]+\.md" $FILE | sort -u | while read f; do
    [ -f "docs/learn/<topic>/${f#./}" ] || echo "MISSING: $f"
done

# 是否包含三档阅读路径
grep -cE "小白线|后端线|速查线" $FILE
# Expected: ≥ 3
```

### 01-overview.md 专项

```bash
FILE=docs/learn/<topic>/01-overview.md

# mermaid 图数量
grep -c "^\`\`\`mermaid" $FILE
# Expected: ≥ 2
```

### 04-design-decisions.md 专项

```bash
FILE=docs/learn/<topic>/04-design-decisions.md

# 决策数量
grep -c "^## 决策" $FILE
# Expected: 与 spec 里"决策数量"字段一致（通常 5-10）

# 每个决策 5 段式（现象/类比/怎么做/不这样会怎样/一句话）
# 手工 spot-check 3 个决策，确认结构对
```

### appendix-a-interview-qa.md 专项

```bash
FILE=docs/learn/<topic>/appendix-a-interview-qa.md

# Q 数量
grep -c "^### Q" $FILE
# Expected: ≥ 15

# 三档标题命中
grep -cE "开场|原理|拷打" $FILE
# Expected: ≥ 3
```

### appendix-b-code-index.md 专项

```bash
FILE=docs/learn/<topic>/appendix-b-code-index.md

# file:/// 数量（每个源码文件一条）
grep -c "file:///" $FILE
# Expected: ≥ 10（覆盖所有关键源码文件）
```

---

## 敏感词扫描（每章必跑）

```bash
FILE=docs/learn/<topic>/<chapter>.md

# 检查是否泄露公司内部信息、内部平台名（本 skill 严格禁止敏感信息，产出章节里也应避免）
grep -rEi "<你自己项目的敏感词表>" $FILE || echo "PASS"
```

---

## 自查失败的补救

### 📦 数量不够怎么办

- 找章节里最"术语密集"的那段，抽出一个术语放 📦 里详解
- 如果全章都很扁平，看看是不是漏了某个背景概念（读的时候小白肯定问的那个）

### 💡 一句话记住数量 ≠ 1 怎么办

- 0 个：章末补一行 `> 💡 **一句话记住**：...`
- \> 1 个：找出多余的合并成 1 句，放章末

### file:/// 数量不够怎么办

- 找章节里"提到某个文件但没链接"的地方
- 每个 step 至少一个链接
- 每个组件表格里的组件都要有链接

### 行数太少怎么办

- 检查每一段是不是缺"为什么这么做"的解释
- 检查是不是每步都有代码引用
- 是不是缺了 📦 补充背景
- 快速判断行数是否够：`wc -l $FILE` 对比阈值表
- **不要通过灌水凑行数**——如果内容确实少，说明章节切分需要合并

### mermaid 图数量不够怎么办（01-overview 专项）

- 至少 1 张架构图（组件关系）
- 至少 1 张数据流图（请求怎么走）
- 有的话再加 1 张状态图 / 时序图

---

## 一键跑全章自查（示例脚本）

```bash
#!/bin/bash
# self_review.sh <topic>
TOPIC=$1
BASE="docs/learn/$TOPIC"

for f in "$BASE"/README.md "$BASE"/00-intro.md "$BASE"/01-overview.md "$BASE"/appendix-a-interview-qa.md "$BASE"/appendix-b-code-index.md; do
    if [ -f "$f" ]; then
        echo "=== $f ==="
        wc -l "$f"
        echo "📦: $(grep -c "📦" "$f")"
        echo "💡: $(grep -c "💡 \*\*一句话记住\*\*" "$f")"
        echo "file:///: $(grep -c "file:///" "$f")"
        echo "mermaid: $(grep -c "^\`\`\`mermaid" "$f")"
        echo ""
    fi
done
```

保存后 `bash self_review.sh <topic>` 一键跑。
