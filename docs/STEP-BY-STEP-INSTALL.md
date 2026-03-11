# 🦞 OpenClaw 超详细安装教程（带图解说明）

> 本教程专为**完全零基础**的新手设计，每个步骤都有详细说明！

---

## 📖 教程目录

1. [第一步：准备工作](#第一步准备工作)
2. [第二步：安装 Node.js](#第二步安装-nodejs)
3. [第三步：安装 OpenClaw](#第三步安装-openclaw)
4. [第四步：配置模型](#第四步配置模型)
5. [第五步：启动服务](#第五步启动服务)
6. [第六步：连接聊天工具](#第六步连接聊天工具)
7. [第七步：开始使用](#第七步开始使用)

---

## 第一步：准备工作

### 1.1 打开终端

#### macOS
1. 按 `Cmd + Space` 打开 Spotlight 搜索
2. 输入 `Terminal` 或 `终端`
3. 按回车打开

#### Linux
- Ubuntu/Debian: 按 `Ctrl + Alt + T`
- 其他发行版：在应用菜单中搜索 "Terminal"

#### Windows (WSL2)
1. 打开 Microsoft Store
2. 搜索 "Ubuntu"
3. 安装后打开

### 1.2 检查系统

在终端中输入以下命令（一行一行输入）：

```bash
# 查看操作系统
uname -a

# 查看内存
free -h

# 查看磁盘空间
df -h
```

**说明**：
- macOS 会显示 `Darwin`
- Linux 会显示 `Linux`
- 确保磁盘空间至少有 1GB 可用

### 1.3 检查是否已安装 Node.js

```bash
node -v
```

**可能的结果**：

✅ **已安装**：显示版本号，如 `v20.11.0`
- 如果版本 >= 18，可以直接跳到第二步
- 如果版本 < 18，需要升级

❌ **未安装**：显示 `command not found`
- 继续下一步安装 Node.js

---

## 第二步：安装 Node.js

Node.js 是运行 OpenClaw 的基础环境。

### 2.1 macOS 安装方法

#### 方法 A：使用 Homebrew（推荐）

```bash
# 检查是否已安装 Homebrew
brew --version

# 如果未安装，先安装 Homebrew（复制整行命令）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 Node.js 20 LTS
brew install node@20

# 验证安装
node -v
npm -v
```

#### 方法 B：从官网下载

1. 访问 https://nodejs.org/
2. 点击绿色的 "LTS" 按钮下载
3. 双击下载的 `.pkg` 文件
4. 按照安装向导完成安装
5. 重新打开终端，验证：
   ```bash
   node -v
   npm -v
   ```

### 2.2 Linux 安装方法

```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 验证安装
node -v
npm -v
```

### 2.3 Windows (WSL2) 安装方法

```bash
# 在 WSL2 终端中执行
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs

# 验证安装
node -v
npm -v
```

### ✅ 验证成功

如果看到类似输出，说明安装成功：

```
v20.11.0
10.2.4
```

---

## 第三步：安装 OpenClaw

### 3.1 配置国内镜像（中国大陆用户）

如果你在中国大陆，使用淘宝镜像可以大幅加速安装：

```bash
npm config set registry https://registry.npmmirror.com
```

### 3.2 安装 OpenClaw

```bash
# 全局安装 OpenClaw
npm install -g openclaw@latest
```

**安装过程说明**：

```
npm WARN ... (警告信息，可以忽略)
npm WARN ...
+ openclaw@x.x.x  (显示版本号)
added xx packages in xxs  (显示安装时间)
```

**可能遇到的问题**：

#### 问题 1：权限错误

```
npm ERR! Error: EACCES: permission denied
```

**解决方案**：

```bash
# 使用 sudo 安装
sudo npm install -g openclaw@latest
```

#### 问题 2：安装很慢

**解决方案**：

```bash
# 确认使用了淘宝镜像
npm config get registry

# 如果不是淘宝镜像，重新设置
npm config set registry https://registry.npmmirror.com

# 重新安装
npm install -g openclaw@latest
```

### 3.3 验证安装

```bash
# 查看版本
openclaw --version

# 查看帮助
openclaw --help
```

**成功输出示例**：

```
openclaw/1.x.x darwin-x64 node-v20.11.0

Usage: openclaw [command]

Commands:
  onboard      配置向导
  gateway      启动网关
  models       模型管理
  channels     频道管理
  ...
```

---

## 第四步：配置模型

### 4.1 运行配置向导

```bash
openclaw onboard
```

### 4.2 按照提示操作

#### 步骤 1：选择安装模式

```
? 选择安装模式 (Use arrow keys)
❯ 快速安装 (推荐)
  自定义安装
  仅配置
```

选择 **快速安装**，按回车。

#### 步骤 2：选择模型提供商

```
? 选择模型提供商 (Use arrow keys)
❯ 智谱 AI (GLM) - 国内推荐
  月之暗面 (Kimi) - 国内推荐
  MiniMax - 国内推荐
  OpenAI - 国际
  Anthropic - 国际
  Google - 国际
  其他...
```

**推荐选择**：
- 中国大陆用户：**智谱 AI** 或 **Kimi**
- 国际用户：**OpenAI** 或 **Anthropic**

#### 步骤 3：输入 API Key

```
? 输入 API Key: [hidden]
```

**如何获取 API Key**：

**智谱 AI**：
1. 访问 https://open.bigmodel.cn/
2. 注册/登录账号
3. 进入「API Key 管理」
4. 点击「创建 API Key」
5. 复制 Key，粘贴到终端

**Kimi**：
1. 访问 https://platform.moonshot.cn/
2. 注册/登录账号
3. 进入「API Key 管理」
4. 创建并复制 Key

**注意**：输入时不会显示字符，这是正常的！

#### 步骤 4：选择默认模型

```
? 选择默认模型 (Use arrow keys)
❯ glm-5
  glm-4
  glm-3-turbo
```

选择 **glm-5**（最强模型），按回车。

#### 步骤 5：是否安装为系统服务

```
? 是否安装为系统服务？(Y/n)
```

- 选择 `Y`：开机自动启动（推荐）
- 选择 `n`：手动启动

### 4.3 配置完成

看到以下提示说明配置成功：

```
✅ 配置完成！
模型：zai/glm-5
工作区：~/.openclaw/workspace
```

---

## 第五步：启动服务

### 5.1 启动 Gateway

```bash
# 前台运行（可以看到实时日志）
openclaw gateway --port 18789
```

**成功启动输出**：

```
🦞 OpenClaw Gateway
版本：1.x.x
端口：18789
工作区：/Users/xxx/.openclaw/workspace

✅ Gateway 已启动
控制界面：http://127.0.0.1:18789
按 Ctrl+C 停止
```

### 5.2 后台运行（可选）

如果你想让 Gateway 在后台运行：

```bash
# 安装为系统服务
openclaw gateway install

# 启动服务
openclaw gateway start

# 查看状态
openclaw gateway status

# 停止服务
openclaw gateway stop
```

### 5.3 访问控制界面

1. 打开浏览器（Chrome/Safari/Edge）
2. 访问：**http://127.0.0.1:18789**
3. 看到控制界面说明成功！

**控制界面功能**：
- 💬 聊天窗口
- ⚙️ 配置管理
- 📊 会话状态
- 📱 设备管理

---

## 第六步：连接聊天工具

### 6.1 WhatsApp

```bash
openclaw channels login whatsapp
```

**步骤**：
1. 终端会显示二维码
2. 打开手机 WhatsApp
3. 设置 → 已连接设备 → 连接设备
4. 扫描二维码
5. 等待连接成功提示

### 6.2 Telegram

```bash
openclaw channels login telegram
```

**步骤**：
1. 输入手机号（带国家代码，如 +8613800138000）
2. 获取验证码（Telegram 会发送消息）
3. 输入验证码
4. 连接成功

### 6.3 Discord

```bash
openclaw channels login discord
```

**步骤**：
1. 终端会显示授权链接
2. 复制链接到浏览器打开
3. 登录 Discord 并授权
4. 连接成功

### 6.4 飞书 (Feishu)

```bash
openclaw channels login feishu
```

**步骤**：
1. 需要飞书开放平台应用凭证
2. 输入 App ID 和 App Secret
3. 连接成功

---

## 第七步：开始使用

### 7.1 发送测试消息

```bash
# 使用 CLI 测试
openclaw agent "你好，请介绍一下自己"
```

**预期输出**：

```
🤖 AI 回复：

你好！我是你的 AI 助手，基于 OpenClaw 运行。
我可以帮助你：
- 回答问题和查询信息
- 编写和审查代码
- 管理日程和提醒
- 连接各种聊天工具
...
```

### 7.2 在聊天工具中测试

1. 打开你连接的聊天工具（WhatsApp/Telegram 等）
2. 发送消息：`你好`
3. 等待 AI 回复
4. 成功！🎉

### 7.3 常用操作

#### 切换模型

```bash
# 查看所有可用模型
openclaw models list

# 切换到其他模型
openclaw models set moonshot/kimi-k2.5
```

#### 查看配置

```bash
# 查看当前配置
openclaw config get agents.defaults.model

# 查看完整配置
cat ~/.openclaw/openclaw.json
```

#### 查看日志

```bash
# 实时查看日志
openclaw logs --follow

# 查看最近的日志
openclaw logs --lines 50
```

#### 诊断问题

```bash
# 运行诊断
openclaw doctor

# 查看状态
openclaw status
```

---

## 🎉 恭喜！安装完成！

现在你已经成功安装了 OpenClaw，可以：

✅ 在聊天工具中和 AI 对话
✅ 使用各种技能扩展功能
✅ 配置自动化任务
✅ 连接更多设备和服务

---

## 📚 下一步学习

1. **[模型配置指南](./openclaw-china-models-config.md)** - 了解更多模型
2. **[技能使用](https://docs.openclaw.ai/cli/skills)** - 学习使用技能
3. **[自动化任务](https://docs.openclaw.ai/automation/cron-jobs)** - 设置定时任务
4. **[多代理配置](https://docs.openclaw.ai/concepts/multi-agent)** - 配置多个 AI

---

## 🆘 遇到问题？

### 快速排查

```bash
# 1. 检查 Gateway 状态
openclaw gateway status

# 2. 检查模型配置
openclaw models status

# 3. 运行诊断
openclaw doctor

# 4. 查看日志
openclaw logs --follow
```

### 获取帮助

- 📖 [完整文档](https://docs.openclaw.ai)
- 💬 [Discord 社区](https://discord.com/invite/clawd)
- 🐙 [GitHub Issues](https://github.com/openclaw/openclaw/issues)

---

*最后更新：2026-03-12*
*适用于 OpenClaw 最新版本*
