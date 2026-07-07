# 附录 B —— <TOPIC> 代码索引

> 目标：给你一张地图，让你打开代码后知道从哪读、每个文件对应哪一章。

## 文件 → 章节映射

| 源码文件 | 讲了什么 | 详见章节 |
| --- | --- | --- |
<FILE_CHAPTER_MAP_ROWS>

<!--
Agent 提示：
每行格式：
| [<basename>](file:///<path>) | 一句话说这个文件干嘛 | [<chapter-title>](./<chapter>.md) |
每个源码文件都应该有对应的讲解章节
-->

## 上层调用链

<TOPIC> 的入口谁在调？往上追：

```
<UPSTREAM_CHAIN>
```

关键调用点：

- <UPSTREAM_CALL_1>：[<basename>](file:///<path>#L<line>)
- <UPSTREAM_CALL_2>：[<basename>](file:///<path>#L<line>)
- <UPSTREAM_CALL_3>：[<basename>](file:///<path>#L<line>)

## 下游依赖

<TOPIC> 依赖了哪些东西？往下追：

```
<DOWNSTREAM_CHAIN>
```

关键依赖：

- <DEP_1>：[<basename>](file:///<path>#L<line>)
- <DEP_2>：[<basename>](file:///<path>#L<line>)
- <DEP_3>：[<basename>](file:///<path>#L<line>)
- <DEP_4>：[<basename>](file:///<path>#L<line>)

## 推荐阅读顺序（打开 IDE 边读代码边看文档）

1. **入口**：先打开 [<basename>](file:///<path>) —— 看整个 <TOPIC> 的对外接口
2. **核心**：再打开 [<basename>](file:///<path>) —— 主要业务逻辑在这
3. **配套**：再打开 [<basename>](file:///<path>) —— 辅助模块
4. **测试**：翻一下 [<basename>](file:///<path>) —— 从测试用例反推使用姿势
5. **配置**：最后看 [<basename>](file:///<path>) —— 了解可调参数

<!--
Agent 提示：
- 5 步阅读顺序要覆盖 <TOPIC> 全部核心代码
- 每一步都给一个具体文件 + 一句话理由
- file:/// 链接必须能落到实际文件
-->
