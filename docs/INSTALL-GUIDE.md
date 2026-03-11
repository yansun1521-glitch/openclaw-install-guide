# 🦞 OpenClaw 新手安装指南

> 本指南专为**零基础新手**设计，跟着步骤一步步来，保证能成功安装！

---

## 📋 目录

1. [安装前准备](#安装前准备)
2. [方式一：一键安装脚本（推荐）](#方式一一键安装脚本推荐)
3. [方式二：手动安装](#方式二手动安装)
4. [方式三：使用 Homebrew（macOS）](#方式三使用-homebrewmacos)
5. [安装后配置](#安装后配置)
6. [常见问题](#常见问题)
7. [获取帮助](#获取帮助)

---

## 安装前准备

### 系统要求

| 系统 | 最低要求 | 推荐配置 |
|------|---------|---------|
| macOS | 10.15+ | macOS 12+ |
| Linux | Ubuntu 20.04+ | Ubuntu 22.04+ |
| Windows | WSL2 (Windows 11) | WSL2 + Ubuntu 22.04 |

### 需要的软件

- **Node.js**: 18+ (推荐 20+ LTS)
- **npm**: 8+ (随 Node.js 一起安装)
- **git**: 任意版本

### 检查是否已安装

打开终端（Terminal），依次输入以下命令：

```bash
# 检查 Node.js
node -v

# 检查 npm
npm -v

# 检查 git
git --version
```

如果显示版本号，说明已安装。如果显示 `command not found`，需要安装。

---

## 方式一：一键安装脚本（推荐）⭐

这是**最简单**的安装方式，适合所有新手！

### 步骤

**1. 打开终端**

- macOS: 按 `Cmd+Space`，输入 "Terminal"，回车
- Linux: 按 `Ctrl+Alt+T`
- Windows: 打开 WSL2 终端

**2. 下载并运行安装脚本**

```bash
# 下载安装脚本
curl -fsSL https://raw.githubusercontent.com/your-username/your-repo/main/scripts/install-openclaw.sh -o install-openclaw.sh

# 给脚本执行权限
chmod +x install-openclaw.sh

# 运行安装脚本
./install-openclaw.sh
```

**3. 按照提示操作**

脚本会自动：
- ✅ 检查并安装 Node.js（如需要）
- ✅ 检查并安装 git（如需要）
- ✅ 安装 OpenClaw
- ✅ 创建快捷启动脚本
- ✅ 可选：运行配置向导

**4. 完成！**

看到 🎉 OpenClaw 安装完成！ 的提示就成功了！

---

## 方式二：手动安装

如果你想了解每一步在做什么，可以选择手动安装。

### 步骤 1：安装 Node.js

#### macOS

```bash
# 使用 Homebrew（推荐）
brew install node@20

# 验证安装
node -v
npm -v
```

#### Linux (Ubuntu/Debian)

```bash
# 使用 NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 验证安装
node -v
npm -v
```

#### Windows (WSL2)

```bash
# 在 WSL2 中执行
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 步骤 2：安装 OpenClaw

```bash
# 全局安装 OpenClaw
npm install -g openclaw@latest

# 验证安装
openclaw --version
```

### 步骤 3：配置国内镜像（中国大陆用户）

```bash
# 使用淘宝 npm 镜像
npm config set registry https://registry.npmmirror.com
```

### 步骤 4：运行配置向导

```bash
# 启动交互式配置向导
openclaw onboard
```

按照提示：
1. 选择模型提供商（推荐：智谱 AI / Kimi / MiniMax）
2. 输入 API Key
3. 选择是否安装为系统服务

---

## 方式三：使用 Homebrew（macOS）

如果你使用的是 macOS 并且已经安装了 Homebrew：

```bash
# 添加 OpenClaw tap（如果有的话）
brew tap openclaw/openclaw

# 安装 OpenClaw
brew install openclaw

# 验证安装
openclaw --version
```

---

## 安装后配置

### 1. 启动 Gateway

```bash
# 前台运行
openclaw gateway --port 18789

# 后台运行
openclaw gateway start

# 查看状态
openclaw gateway status
```

### 2. 配置模型

```bash
# 查看可用模型
openclaw models list

# 设置模型
openclaw models set zai/glm-5

# 查看模型状态
openclaw models status
```

### 3. 连接聊天频道

#### WhatsApp

```bash
openclaw channels login whatsapp
# 扫描二维码
```

#### Telegram

```bash
openclaw channels login telegram
# 输入手机号和验证码
```

#### Discord

```bash
openclaw channels login discord
# 按照提示授权
```

### 4. 打开控制界面

浏览器访问：**http://127.0.0.1:18789**

在这里你可以：
- 💬 直接和 AI 对话
- ⚙️ 修改配置
- 📊 查看会话状态
- 📱 管理设备

### 5. 测试一下

```bash
# 发送测试消息
openclaw agent "你好，测试一下"
```

---

## 常见问题

### ❌ 问题 1：npm 安装很慢

**解决方案**：使用淘宝镜像

```bash
npm config set registry https://registry.npmmirror.com
npm install -g openclaw@latest
```

### ❌ 问题 2：权限错误 (EACCES)

**解决方案**：使用 sudo 或修复 npm 权限

```bash
# 方法 1：使用 sudo
sudo npm install -g openclaw@latest

# 方法 2：修复 npm 权限（推荐）
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
npm install -g openclaw@latest
```

### ❌ 问题 3：Gateway 启动失败

**解决方案**：检查端口占用

```bash
# 查看端口占用
lsof -i :18789

# 更换端口
openclaw gateway --port 18790
```

### ❌ 问题 4：找不到 openclaw 命令

**解决方案**：检查 PATH

```bash
# 查看 npm 全局安装路径
npm config get prefix

# 添加到 PATH（根据上面的路径）
export PATH=$(npm config get prefix)/bin:$PATH
echo 'export PATH=$(npm config get prefix)/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### ❌ 问题 5：API Key 配置后还是提示认证失败

**解决方案**：

1. 检查 API Key 是否正确
2. 重启 Gateway
3. 检查环境变量

```bash
# 查看配置
openclaw config get env

# 重启 Gateway
openclaw gateway restart

# 手动设置环境变量
export ZAI_API_KEY="sk-xxx"
openclaw gateway restart
```

### ❌ 问题 6：中国大陆访问慢

**解决方案**：使用国内模型厂商

```bash
# 推荐国内模型
openclaw models set zai/glm-5           # 智谱 AI
openclaw models set moonshot/kimi-k2.5  # Kimi
openclaw models set minimax/MiniMax-M2.5 # MiniMax
openclaw models set volcengine/doubao-seed-1-8-251228 # 火山引擎
```

---

## 获取帮助

### 官方文档

- 📖 [OpenClaw 文档](https://docs.openclaw.ai)
- 🚀 [快速开始](https://docs.openclaw.ai/start/getting-started)
- ⚙️ [配置指南](https://docs.openclaw.ai/gateway/configuration)

### 社区支持

- 💬 [Discord 社区](https://discord.com/invite/clawd)
- 🐙 [GitHub 仓库](https://github.com/openclaw/openclaw)
- 🛠️ [技能市场](https://clawhub.ai)

### 诊断命令

```bash
# 完整诊断
openclaw doctor

# 查看日志
openclaw logs --follow

# 查看状态
openclaw status

# 查看帮助
openclaw --help
```

---

## 下一步

安装完成后，建议阅读：

1. **[模型配置指南](./openclaw-china-models-config.md)** - 配置国内/国际模型
2. **[频道连接指南](https://docs.openclaw.ai/channels/index)** - 连接 WhatsApp/Telegram
3. **[技能使用指南](https://docs.openclaw.ai/cli/skills)** - 使用技能扩展功能

---

## 快捷命令速查表

```bash
# 安装
npm install -g openclaw@latest

# 启动
openclaw gateway --port 18789

# 配置
openclaw onboard
openclaw configure

# 模型
openclaw models list
openclaw models set <model>
openclaw models status

# 频道
openclaw channels login
openclaw channels list

# 诊断
openclaw doctor
openclaw logs
openclaw status

# 帮助
openclaw --help
openclaw <command> --help
```

---

*最后更新：2026-03-12*
*适用于 OpenClaw 最新版本*
