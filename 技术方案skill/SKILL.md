---
name: usecase-diagram
description: Draw UML use case diagrams as SVG/PNG or write to Feishu whiteboard. Use this skill whenever the user wants to visualize roles and features, analyze business requirements, sort out system functions, write technical proposals, review code architecture, or break down problems — even if they don't explicitly say "use case diagram". Trigger on phrases like "画用例图", "业务分析", "功能梳理", "技术方案", "角色功能关系", "系统功能", "需求分析", "画个图分析一下".
---

# UML 业务用例图（Use Case Diagram）

适用于：业务需求分析、系统功能梳理、技术方案评审、代码架构分析、问题拆解等场景。不限于开发，任何需要"角色-功能"关系可视化的场景均可使用。

---

## 第一步：从上下文提取结构

在绘图前，先从用户描述中识别以下三层结构：

1. **角色（Actor）**：谁在使用系统？可以是人、外部系统、定时任务等。数量不限。
2. **域节点**：每个角色归属哪个业务域？（如"订单域"、"支付域"、"内容域"）。通常一个角色对应一个域。
3. **用例**：每个域下有哪些功能？标注每个用例的状态：已有 / 新增 / 改造。

> 角色和域的数量完全由场景决定，不要预设"一定有运营和用户"之类的固定结构。

---

## 第二步：计算坐标（绘图前必做）

### 固定列 x 坐标

| 列 | cx | 说明 |
|----|----|------|
| Actor 火柴人 | 60 | 头部圆心 x |
| 域节点 | 200 | 椭圆圆心 x |
| 一级用例 | 460 | 椭圆圆心 x |
| 二级用例 | 700 | 椭圆圆心 x |
| 三级用例 | 940 | 椭圆圆心 x |

列间距 240px，椭圆宽 rx=100，两列之间留 40px 空隙，连线不重叠。

### 行 y 坐标分配

**同列用例垂直间距 80px**（椭圆高 ry=28，上下各 28px，间隔 24px）。

从顶部留 80px 给标题，第一个用例从 y=100 开始，依次 +80：

```
第1个用例 y = 100
第2个用例 y = 180
第3个用例 y = 260
第4个用例 y = 340
...
```

多个角色/域之间，预留 ≥ 120px 垂直间距作为视觉分隔。

### 域节点 y = 其直连子用例 y 的中位数（核心规则）

**这是防止连线穿过节点的唯一正确做法。**

计算方法：
- 奇数个子用例：取中间那个的 y
- 偶数个子用例：取中间两个 y 的平均值

示例：
```
子用例 y = 100, 180, 260, 340
中位数 = (180 + 260) / 2 = 220
→ 域节点 cy = 220
```

域节点在垂直中心，斜线向上/向下扇出，**不会穿过任何节点**。

### Actor 火柴人 y 坐标

火柴人以"腰部"为参考点（记为 `W`），各部件相对 W 的偏移：

| 部件 | 坐标 |
|------|------|
| 头部圆心 | cy = W - 18 |
| 颈部起点（身体顶） | y1 = W |
| 身体终点（腰） | y2 = W + 40 |
| 手臂 | y = W + 18 |
| 左腿终点 | y2 = W + 70 |
| 右腿终点 | y2 = W + 70 |
| 名称文字 | y = W + 90 |

**Actor W 坐标 = 其对应域节点的 cy**（让火柴人腰部与域节点水平对齐）。

---

## 第三步：颜色标识体系

### 用例状态（固定，不随场景变化）

| 状态 | fill | stroke | 文字色 | 含义 |
|------|------|--------|--------|------|
| 已有 | `#f8f8f8` | `#bbbbbb` | `#222222` | 现有功能，本次不动 |
| 新增 | `white` | `#4a7fd4` | `#1a4a8a` | 本次新建的功能 |
| 改造 | `#fff8e6` | `#e07b00` | `#7a4a00` | 现有功能，本次有修改 |

> 场景不涉及"改造"时，只用"已有"和"新增"两种即可，不必强行区分。

### 域节点颜色（按角色出现顺序取用，循环）

| 序号 | 填充色 | 边框色 |
|------|--------|--------|
| 1 | `#7b5ea7`（紫） | 同填充色 |
| 2 | `#3a7bd5`（蓝） | 同填充色 |
| 3 | `#2e8b57`（绿） | 同填充色 |
| 4 | `#c0392b`（红） | 同填充色 |
| 5 | `#b07d2a`（棕） | 同填充色 |

域节点文字统一白色 `fill="white"`。

### 图例（右上角必须包含）

只列本图实际用到的颜色类型，未用到的不列。

---

## 第四步：连线规则（防穿线）

```
Actor → 域节点 → 一级用例 → 二级用例 → 三级用例
```

- **域节点只连第一列**，禁止跨列直连二级或三级用例
- 连线起点：当前列椭圆右边缘 `cx + rx`
- 连线终点：下一列椭圆左边缘 `cx - rx`
- 样式：`stroke="#cccccc" stroke-width="1"`，无箭头，无虚线
- 用例间顺序关联（如"开始→提交"）用**垂直线**连接，不斜穿

---

## SVG 模板片段

### 标题

```svg
<text x="750" y="44" text-anchor="middle" font-size="22" font-weight="bold" fill="#111" font-family="Noto Sans SC">系统名称 - 业务用例图</text>
```

### Actor 火柴人（W = 域节点 cy）

```svg
<circle cx="60" cy="[W-18]" r="18" fill="none" stroke="#333" stroke-width="2"/>
<line x1="60" y1="[W]" x2="60" y2="[W+40]" stroke="#333" stroke-width="2"/>
<line x1="35" y1="[W+18]" x2="85" y2="[W+18]" stroke="#333" stroke-width="2"/>
<line x1="60" y1="[W+40]" x2="38" y2="[W+70]" stroke="#333" stroke-width="2"/>
<line x1="60" y1="[W+40]" x2="82" y2="[W+70]" stroke="#333" stroke-width="2"/>
<text x="60" y="[W+90]" text-anchor="middle" font-size="14" fill="#222" font-family="Noto Sans SC">角色名</text>
```

### 域节点

```svg
<ellipse cx="200" cy="[域Y]" rx="90" ry="32" fill="[域色]" stroke="[域色]" stroke-width="1.5"/>
<text x="200" y="[域Y+5]" text-anchor="middle" font-size="13" fill="white" font-family="Noto Sans SC">域名称</text>
<line x1="78" y1="[域Y]" x2="108" y2="[域Y]" stroke="#aaaaaa" stroke-width="1.2"/>
```

### 用例椭圆

```svg
<!-- 已有 -->
<ellipse cx="[cx]" cy="[cy]" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
<text x="[cx]" y="[cy+5]" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">用例名</text>

<!-- 新增 -->
<ellipse cx="[cx]" cy="[cy]" rx="100" ry="28" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
<text x="[cx]" y="[cy+5]" text-anchor="middle" font-size="13" fill="#1a4a8a" font-family="Noto Sans SC">用例名</text>

<!-- 改造 -->
<ellipse cx="[cx]" cy="[cy]" rx="100" ry="28" fill="#fff8e6" stroke="#e07b00" stroke-width="1.5"/>
<text x="[cx]" y="[cy+5]" text-anchor="middle" font-size="13" fill="#7a4a00" font-family="Noto Sans SC">用例名</text>

<!-- 文字过长时拆两行（y 偏移 ±8） -->
<ellipse cx="[cx]" cy="[cy]" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
<text x="[cx]" y="[cy-3]" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">第一行</text>
<text x="[cx]" y="[cy+13]" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">第二行</text>
```

### 连线

```svg
<!-- 域→一级（斜线扇出，域在中位数） -->
<line x1="290" y1="[域Y]" x2="360" y2="[一级Y]" stroke="#cccccc" stroke-width="1"/>

<!-- 一级→二级 -->
<line x1="560" y1="[一级Y]" x2="600" y2="[二级Y]" stroke="#cccccc" stroke-width="1"/>

<!-- 二级→三级 -->
<line x1="800" y1="[二级Y]" x2="840" y2="[三级Y]" stroke="#cccccc" stroke-width="1"/>

<!-- 用例间顺序关联（垂直线，不斜穿） -->
<line x1="460" y1="[上用例cy+28]" x2="460" y2="[下用例cy-28]" stroke="#aaaaaa" stroke-width="1.2"/>
```

### 图例

```svg
<rect x="1100" y="60" width="280" height="[按实际行数计算]" rx="8" fill="white" stroke="#cccccc" stroke-width="1.2"/>
<text x="1240" y="90" text-anchor="middle" font-size="14" font-weight="bold" fill="#222" font-family="Noto Sans SC">图例</text>
<!-- 每行间距 50px，从 y=120 开始 -->
<ellipse cx="1190" cy="120" rx="70" ry="22" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
<text x="1190" y="125" text-anchor="middle" font-size="12" fill="#222" font-family="Noto Sans SC">已有用例</text>
<ellipse cx="1190" cy="170" rx="70" ry="22" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
<text x="1190" y="175" text-anchor="middle" font-size="12" fill="#1a4a8a" font-family="Noto Sans SC">新增用例</text>
<ellipse cx="1190" cy="220" rx="70" ry="22" fill="#fff8e6" stroke="#e07b00" stroke-width="1.5"/>
<text x="1190" y="225" text-anchor="middle" font-size="12" fill="#7a4a00" font-family="Noto Sans SC">改造用例</text>
<!-- 域节点颜色按实际用到的列出 -->
<ellipse cx="1190" cy="270" rx="70" ry="22" fill="#7b5ea7" stroke="#7b5ea7" stroke-width="1.5"/>
<text x="1190" y="275" text-anchor="middle" font-size="12" fill="white" font-family="Noto Sans SC">角色A域</text>
```

---

## 完整参考示例

**场景**：两个角色（角色A / 角色B），各自一个域，含已有/新增/改造三种用例状态，一级+二级层级。

**坐标推导**：
- 角色A 一级用例：y = 100, 180, 260 → 域A cy = 180，Actor W = 180
- 角色B 一级用例：y = 460, 540, 620, 700 → 域B cy = (540+620)/2 = 580，Actor W = 580
- 角色B 二级用例（从 y=460 的一级延伸）：y = 460, 540

```svg
<svg xmlns="http://www.w3.org/2000/svg" width="1500" height="820" viewBox="0 0 1500 820">
  <rect width="1500" height="820" fill="white"/>
  <text x="750" y="44" text-anchor="middle" font-size="22" font-weight="bold" fill="#111" font-family="Noto Sans SC">系统名称 - 业务用例图</text>

  <!-- ===== 角色A ===== -->
  <!-- Actor W=180，头部 cy=162 -->
  <circle cx="60" cy="162" r="18" fill="none" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="180" x2="60" y2="220" stroke="#333" stroke-width="2"/>
  <line x1="35" y1="198" x2="85" y2="198" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="220" x2="38" y2="250" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="220" x2="82" y2="250" stroke="#333" stroke-width="2"/>
  <text x="60" y="270" text-anchor="middle" font-size="14" fill="#222" font-family="Noto Sans SC">角色A</text>

  <!-- 域A cy=180（子用例 y=100/180/260，中位数=180） -->
  <ellipse cx="200" cy="180" rx="90" ry="32" fill="#7b5ea7" stroke="#7b5ea7" stroke-width="1.5"/>
  <text x="200" y="185" text-anchor="middle" font-size="13" fill="white" font-family="Noto Sans SC">域A</text>
  <line x1="78" y1="180" x2="108" y2="180" stroke="#aaaaaa" stroke-width="1.2"/>

  <!-- 角色A 一级用例 -->
  <ellipse cx="460" cy="100" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="460" y="105" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">已有功能甲</text>

  <ellipse cx="460" cy="180" rx="100" ry="28" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
  <text x="460" y="185" text-anchor="middle" font-size="13" fill="#1a4a8a" font-family="Noto Sans SC">新增功能乙</text>

  <ellipse cx="460" cy="260" rx="100" ry="28" fill="#fff8e6" stroke="#e07b00" stroke-width="1.5"/>
  <text x="460" y="265" text-anchor="middle" font-size="13" fill="#7a4a00" font-family="Noto Sans SC">改造功能丙</text>

  <!-- 域A→一级（斜线扇出） -->
  <line x1="290" y1="180" x2="360" y2="100" stroke="#cccccc" stroke-width="1"/>
  <line x1="290" y1="180" x2="360" y2="180" stroke="#cccccc" stroke-width="1"/>
  <line x1="290" y1="180" x2="360" y2="260" stroke="#cccccc" stroke-width="1"/>

  <!-- 新增功能乙→二级 -->
  <ellipse cx="700" cy="180" rx="100" ry="28" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
  <text x="700" y="185" text-anchor="middle" font-size="13" fill="#1a4a8a" font-family="Noto Sans SC">子功能1</text>
  <line x1="560" y1="180" x2="600" y2="180" stroke="#cccccc" stroke-width="1"/>

  <!-- ===== 角色B（与角色A间距120px：260+120=380起） ===== -->
  <!-- Actor W=580，头部 cy=562 -->
  <circle cx="60" cy="562" r="18" fill="none" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="580" x2="60" y2="620" stroke="#333" stroke-width="2"/>
  <line x1="35" y1="598" x2="85" y2="598" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="620" x2="38" y2="650" stroke="#333" stroke-width="2"/>
  <line x1="60" y1="620" x2="82" y2="650" stroke="#333" stroke-width="2"/>
  <text x="60" y="670" text-anchor="middle" font-size="14" fill="#222" font-family="Noto Sans SC">角色B</text>

  <!-- 域B cy=580（子用例 y=460/540/620/700，中位数=(540+620)/2=580） -->
  <ellipse cx="200" cy="580" rx="90" ry="32" fill="#3a7bd5" stroke="#3a7bd5" stroke-width="1.5"/>
  <text x="200" y="585" text-anchor="middle" font-size="13" fill="white" font-family="Noto Sans SC">域B</text>
  <line x1="78" y1="580" x2="108" y2="580" stroke="#aaaaaa" stroke-width="1.2"/>

  <!-- 角色B 一级用例 -->
  <ellipse cx="460" cy="460" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="460" y="465" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">已有功能A</text>

  <ellipse cx="460" cy="540" rx="100" ry="28" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
  <text x="460" y="545" text-anchor="middle" font-size="13" fill="#1a4a8a" font-family="Noto Sans SC">新增功能B</text>

  <ellipse cx="460" cy="620" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="460" y="618" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">已有功能C</text>
  <text x="460" y="634" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">（两行示例）</text>

  <ellipse cx="460" cy="700" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="460" y="705" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">已有功能D</text>

  <!-- 域B→一级（斜线扇出） -->
  <line x1="290" y1="580" x2="360" y2="460" stroke="#cccccc" stroke-width="1"/>
  <line x1="290" y1="580" x2="360" y2="540" stroke="#cccccc" stroke-width="1"/>
  <line x1="290" y1="580" x2="360" y2="620" stroke="#cccccc" stroke-width="1"/>
  <line x1="290" y1="580" x2="360" y2="700" stroke="#cccccc" stroke-width="1"/>

  <!-- 已有功能A→二级 -->
  <ellipse cx="700" cy="460" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="700" y="465" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">子功能X</text>

  <ellipse cx="700" cy="540" rx="100" ry="28" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="700" y="545" text-anchor="middle" font-size="13" fill="#222" font-family="Noto Sans SC">子功能Y</text>

  <!-- 已有功能A(460,460)→二级，460在中位数(460+540)/2=500，斜线扇出 -->
  <line x1="560" y1="460" x2="600" y2="460" stroke="#cccccc" stroke-width="1"/>
  <line x1="560" y1="460" x2="600" y2="540" stroke="#cccccc" stroke-width="1"/>

  <!-- 新增功能B→已有功能C（顺序关联，垂直线） -->
  <line x1="460" y1="568" x2="460" y2="592" stroke="#aaaaaa" stroke-width="1.2"/>

  <!-- ===== 图例 ===== -->
  <rect x="1100" y="60" width="280" height="290" rx="8" fill="white" stroke="#cccccc" stroke-width="1.2"/>
  <text x="1240" y="90" text-anchor="middle" font-size="14" font-weight="bold" fill="#222" font-family="Noto Sans SC">图例</text>
  <ellipse cx="1190" cy="120" rx="70" ry="22" fill="#f8f8f8" stroke="#bbbbbb" stroke-width="1.5"/>
  <text x="1190" y="125" text-anchor="middle" font-size="12" fill="#222" font-family="Noto Sans SC">已有用例</text>
  <ellipse cx="1190" cy="170" rx="70" ry="22" fill="white" stroke="#4a7fd4" stroke-width="1.5"/>
  <text x="1190" y="175" text-anchor="middle" font-size="12" fill="#1a4a8a" font-family="Noto Sans SC">新增用例</text>
  <ellipse cx="1190" cy="220" rx="70" ry="22" fill="#fff8e6" stroke="#e07b00" stroke-width="1.5"/>
  <text x="1190" y="225" text-anchor="middle" font-size="12" fill="#7a4a00" font-family="Noto Sans SC">改造用例</text>
  <ellipse cx="1190" cy="270" rx="70" ry="22" fill="#7b5ea7" stroke="#7b5ea7" stroke-width="1.5"/>
  <text x="1190" y="275" text-anchor="middle" font-size="12" fill="white" font-family="Noto Sans SC">角色A域</text>
  <ellipse cx="1190" cy="320" rx="70" ry="22" fill="#3a7bd5" stroke="#3a7bd5" stroke-width="1.5"/>
  <text x="1190" y="325" text-anchor="middle" font-size="12" fill="white" font-family="Noto Sans SC">角色B域</text>
</svg>
```

---

## 防穿线检查清单（生成 SVG 前逐条验证）

1. **域节点 cy = 其直连一级子用例 cy 的中位数**（误差 < 5px）
2. **域节点只连第一列**，不跨列连线
3. **连线起点 = 当前列 cx + rx**，终点 = 下一列 cx - rx
4. **同列用例间距 ≥ 60px**（避免椭圆重叠）
5. **用例间顺序关联用垂直线**，不斜穿其他节点
6. **图例只列本图实际用到的颜色**

---

## 渲染与交付

```bash
# 渲染 PNG
npx -y @larksuite/whiteboard-cli@^0.2.10 -i diagram.svg -o diagram.png -f svg

# 检查（0 errors 即可，warnings 可接受）
npx -y @larksuite/whiteboard-cli@^0.2.10 -i diagram.svg -f svg --check

# 写入飞书白板（有 lark-cli 时）
npx -y @larksuite/whiteboard-cli@^0.2.10 -i diagram.svg --to openapi --format json \
  | lark-cli whiteboard +update \
    --whiteboard-token <token> \
    --source - --input_format raw \
    --idempotent-token usecase-$(date +%s) \
    --overwrite --yes --as user
```

---

## 常见坑

| 坑 | 原因 | 正确做法 |
|----|------|---------|
| 连线穿过节点 | 域节点不在子用例垂直中心 | 域节点 cy = 子用例 cy 中位数 |
| 域节点连接右列 | 域直连二级，线穿过一级 | 域只连一级，层级逐列传递 |
| 主干线穿节点 | 用竖干+横支树形连线 | 域节点直接斜线到每个一级子用例 |
| 层级不清晰 | 所有用例都从域节点连出 | 二级从一级连出，体现父子关系 |
| 文字溢出椭圆 | 文字过长 | 拆成两个 `<text>` 标签，y 偏移 ±8 |
| 改造色与域色混淆 | 都用橙色 | 改造用 `#e07b00`，域节点第5个用 `#b07d2a` |
| 飞书白板空白 | idempotent-token 重复 | 每次写入用新的 token（`date +%s`） |
| Actor 位置偏 | W 坐标算错 | Actor W = 对应域节点 cy |
