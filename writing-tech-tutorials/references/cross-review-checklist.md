# 跨章交叉审查清单

> 全部章节写完后跑这份清单。目标：确保多份文档"看起来像一份"，术语统一、链接有效、章节间概念呼应。
> 建议用 checkbox 逐条走，全部打勾才算 skill 完成。

---

## 1. 术语一致性

同一个概念在不同章有不同叫法是最常见的破坏"整体感"的坑。

- [ ] **命名风格统一**：`small-to-big` / `Small-to-Big` / `small_to_big` 三种写法只留一种
- [ ] **中英文选择一致**：某个概念是用"重排"还是"rerank"要全文一致
- [ ] **首次出现有解释**：新术语第一次出现时用类比或 📦 解释；后续章节直接使用不再解释

### grep 检查命令示例

```bash
# 找同一概念的多种写法
grep -rn "small-to-big\|small_to_big\|Small-to-Big\|SmallToBig" docs/learn/<topic>/

# 找中英文混用
grep -rn "重排\|rerank\|Rerank\|重排序" docs/learn/<topic>/
```

出现多种写法就统一到一种再自查。

---

## 2. 源码链接有效性

- [ ] **所有 file:/// 链接都能打开**：抽 5-10 处，用 `Read` 或 IDE 点开验证
- [ ] **行号准确**：链接指向的那几行确实是文档在讨论的内容
- [ ] **basename 匹配**：链接文字里的 basename 和路径末尾一致

### grep 检查命令

```bash
# 提取所有 file:/// 引用
grep -oE "file:///[^)]+" docs/learn/<topic>/*.md | sort -u

# 抽 5-10 处 spot-check：Read 打开确认行号
```

---

## 3. README 相对链接完整性

- [ ] **章节索引里的每个 `./XX-YYY.md` 都真的存在**
- [ ] **术语速查表里"详见 X 章"的每个引用都真的在那一章讲过**

### grep 检查命令

```bash
# 章节相对链接
grep -oE "\./[a-zA-Z0-9_-]+\.md" docs/learn/<topic>/README.md | sort -u | while read f; do
    [ -f "docs/learn/<topic>/${f#./}" ] || echo "MISSING: $f"
done
```

---

## 4. 章节间概念呼应

- [ ] **前一章解释过的名词，后一章直接用**（不要重新解释）
- [ ] **前一章埋的伏笔，后一章要接**（比如 01 章说"决策 4 会展开讲"，04 章确实要展开）
- [ ] **📦 里补的背景，主线里不再重复解释**

### 手动检查

- 抽 3 章，读一遍，感觉"这章有没有假设读过前面的章节"
- 如果某章可以跳读也不影响，说明呼应弱（这不算问题，取决于你的定位）

---

## 5. 术语速查表覆盖

- [ ] README 的术语速查表里**每个术语**都在某一章的 📦 里详解过
- [ ] 反过来：主要 📦 里的术语，都在术语速查表里列了

### 手动检查

- 打开 README 的术语表
- 逐条搜正文（`grep -rn "术语"` ）
- 找到讲得最详细的那一章，写在"详见 X 章"栏

---

## 6. Q&A 附录引用是否指向正文

- [ ] appendix-a 每题的**代码引用**都能落到正文讲过的地方
- [ ] appendix-a 每题**没有引入新概念**（有的话应该在正文加一段）

### 手动检查

- 逐题读参考回答
- 如果读到某个术语不确定"正文讲过没"，去正文 grep 一下

---

## 7. 阅读路径可行性

- [ ] 按 🐤 小白线（全读）走一遍，不掉队
- [ ] 按 🦾 后端线（跳读）走一遍，能建立心智模型
- [ ] 按 ⚡ 速查线走一遍，能拿到面试要点

### 手动检查

- 不要"重新读一遍"，那是作者视角
- 找一个跟目标受众类似的同事，让他读完给反馈
- 如果没有同事，问自己："如果我 2 周前不知道这个模块，现在按这条路径能懂吗？"

---

## 8. 敏感信息扫描

- [ ] 全局跑一次自定义敏感词表扫描
- [ ] 特别注意生成的目录路径 / 用户名 / commit hash 里的信息

### grep 检查命令

```bash
grep -rEi "<你自己项目的敏感词表>" \
    --include="*.md" docs/learn/<topic>/ || echo "PASS"
```

---

## 一键跑全套（示例脚本）

```bash
#!/bin/bash
# cross_review.sh <topic>
TOPIC=$1
BASE="docs/learn/$TOPIC"

echo "=== 1. 章节相对链接完整性 ==="
grep -oE "\./[a-zA-Z0-9_-]+\.md" "$BASE/README.md" | sort -u | while read f; do
    [ -f "$BASE/${f#./}" ] || echo "MISSING: $f"
done
echo "PASS 若无输出"

echo ""
echo "=== 2. 术语一致性（自定义命令，需你补充关键词） ==="
# grep -rn "关键词1\|关键词2" $BASE/

echo ""
echo "=== 3. 源码链接总数 ==="
grep -rc "file:///" "$BASE/" | grep -v ":0"

echo ""
echo "=== 4. 敏感词 ==="
# grep -rEi "..." "$BASE/" --include="*.md" || echo "PASS"
```

---

## 交叉审查通过 → skill 完成

全部 checkbox 打勾 → 跑一次 `git log --oneline` 确认所有章节都 commit 了 → emit 完成钩子（Phase 5）→ skill 结束。
