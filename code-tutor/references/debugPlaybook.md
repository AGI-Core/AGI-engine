## 新手排错 SOP

当用户遇到报错时，按此流程引导排查。

### 第一步：看现象
- 完整报错信息是什么？
- 什么操作触发的？
- 能复现吗？

### 第二步：定位置
- 报错指向哪个文件、哪一行？
- 是编译时还是运行时？
- 是本地报错还是线上报错？

### 第三步：查上下文
- 这个文件/函数是做什么的？
- 最近改过什么？
- 有没有相关的 git diff？

### 第四步：找根因
- 是语法错误？
- 是类型错误？
- 是依赖缺失？
- 是环境配置问题？
- 是业务逻辑问题？

### 第五步：验证假设
- 加日志/print 确认变量值
- 注释掉可疑代码看是否消失
- 查官方文档或搜索报错信息

### 第六步：修复并复盘
- 写出修复方案
- 评估影响范围
- 跑测试验证
- 总结"为什么错 + 怎么避免"

---

## Go/tRPC 常见报错速查

| 报错关键词 | 可能原因 | 排查方向 |
|-----------|---------|---------|
| `undefined: xxx` | 函数/变量未定义 | 检查拼写、检查导入、检查是否在正确的包里 |
| `cannot use xxx as type yyy` | 类型不匹配 | 检查接口实现、检查参数类型 |
| `imported and not used` | 导入了包但没用 | 删掉没用的 import，或者用 `_` 占位 |
| `multiple-value in single-value context` | 多返回值没处理 | Go 函数返回多个值，需要都接收 |
| `nil pointer dereference` | 空指针 | 检查变量是否初始化、检查返回值是否为 nil |
| `deadline exceeded` | 超时 | 检查下游服务是否正常、检查超时配置 |
| `connection refused` | 连接被拒 | 检查目标服务是否启动、检查地址和端口 |
| `no such host` | DNS 解析失败 | 检查服务名是否正确、检查网络环境 |
| `redis: nil` | Redis 查不到数据 | key 不存在，检查 key 拼写、检查数据是否写入 |
| `proto: wrong wireType` | proto 序列化错误 | 检查 proto 版本是否一致、字段编号是否冲突 |
| `filter not found` | tRPC 拦截器未注册 | 检查 trpc_go.yaml 中 filter 配置 |
| `service not found` | 服务未注册 | 检查服务名是否正确、检查 naming 配置 |
| `go.sum mismatch` | 依赖校验失败 | 运行 `go mod tidy`，或检查 GOPROXY 配置 |
| `package xxx is not in GOROOT` | 包路径错误 | 检查 go.mod 中的 module 名、检查 import 路径 |
| `cannot find module providing package` | 依赖找不到 | 运行 `go mod tidy`、检查 GOPRIVATE 配置 |

---

## Go 项目排错工具箱

| 工具/方法 | 用途 | 使用场景 |
|-----------|------|---------|
| `log.ErrorContextf` | 打印错误日志 | 在可疑位置加日志，看变量值 |
| `fmt.Printf("%+v", obj)` | 打印结构体详情 | 看完整的结构体内容 |
| `go test -v -run TestXxx` | 跑单个测试 | 验证某个函数的行为 |
| `go build ./...` | 编译检查 | 快速发现语法和类型错误 |
| `go vet ./...` | 静态分析 | 发现潜在的代码问题 |
| `git diff` | 看改了什么 | 对比改动前后的差异 |
| `git log --oneline -10` | 看最近提交 | 找到最近谁改了什么 |
| `grep -r "关键词" .` | 全局搜索 | 找到某个函数/变量在哪里用了 |

---

## 环境问题排查

| 问题 | 排查步骤 |
|------|---------|
| 依赖拉不下来 | 1. 检查 GOPROXY 配置 → 2. 检查 GOPRIVATE 配置 → 3. 检查网络/VPN |
| 服务启动失败 | 1. 看报错日志 → 2. 检查配置文件路径 → 3. 检查端口是否被占用 |
| 本地跑不起来 | 1. 检查 Go 版本 → 2. `go mod tidy` → 3. 检查配置文件中的地址 |
| 调用下游失败 | 1. 检查 trpc_go.yaml 中的 client 配置 → 2. 检查服务名 → 3. 检查网络连通性 |

---

## 通用报错速查

| 报错关键词 | 可能原因 | 排查方向 |
|-----------|---------|---------|
| `undefined is not a function` | 调用了不存在的方法 | 检查拼写、检查导入 |
| `Cannot read property of null` | 访问了空对象的属性 | 检查数据是否正确加载 |
| `Module not found` | 依赖没装或路径错 | 检查 import 路径、运行 npm install |
| `CORS error` | 跨域被拦截 | 检查后端 CORS 配置 |
| `404 Not Found` | 接口地址错或服务没启动 | 检查 URL、检查服务状态 |
| `500 Internal Server Error` | 后端代码崩了 | 看后端日志 |
| `TypeError` | 类型不匹配 | 检查变量类型、检查接口返回 |
| `SyntaxError` | 语法写错了 | 检查括号、引号、逗号 |
