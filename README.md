# 🦞 OpenClaw 工作区

> 你的个人 AI 代理网关 - 连接微信、Telegram、Discord 等聊天工具

---

## 🚀 快速开始

### 我是新手，怎么安装？

👉 **查看 [安装指南](docs/INSTALL-GUIDE.md)** - 专为零基础设计！

### 一键安装（推荐）

```bash
# 下载安装脚本
curl -fsSL https://raw.githubusercontent.com/your-username/your-repo/main/scripts/install-openclaw.sh -o install-openclaw.sh

# 运行安装
chmod +x install-openclaw.sh
./install-openclaw.sh
```

### 手动安装

```bash
# 安装 OpenClaw
npm install -g openclaw@latest

# 配置
openclaw onboard

# 启动
openclaw gateway --port 18789
```

---

## 📚 文档目录

### 新手必读

| 文档 | 说明 |
|------|------|
| [📖 安装指南](docs/INSTALL-GUIDE.md) | 零基础安装教程 |
| [🌍 模型配置指南](docs/openclaw-china-models-config.md) | 配置国内/国际模型 |
| [⚙️ 快速开始](https://docs.openclaw.ai/start/getting-started) | 官方快速开始 |

### 进阶文档

| 文档 | 说明 |
|------|------|
| [配置参考](https://docs.openclaw.ai/gateway/configuration) | 完整配置项 |
| [频道连接](https://docs.openclaw.ai/channels/index) | 连接聊天工具 |
| [技能使用](https://docs.openclaw.ai/cli/skills) | 使用技能 |
| [CLI 命令](https://docs.openclaw.ai/cli/index) | 命令参考 |

---

## 💡 我能用 OpenClaw 做什么？

### 🤖 个人助理

- 💬 在微信/Telegram 中和 AI 聊天
- 📅 管理日程和提醒
- 📰 获取新闻摘要
- 🌤️ 查询天气

### 💻 编程助手

- 📝 代码生成和审查
- 🐛 调试帮助
- 📖 文档查询
- 🔧 自动化脚本

### 📊 数据分析

- 📈 股票价格跟踪
- 💰 财务报表分析
- 📉 数据可视化
- 🔍 信息搜索

### 🏠 智能家居

- 📷 查看监控摄像头
- 🔔 接收通知
- 🎵 控制音乐播放
- 💡 智能家居控制

---

## 🛠️ 常用命令

```bash
# 启动 Gateway
openclaw gateway --port 18789

# 查看状态
openclaw status

# 配置模型
openclaw models set zai/glm-5

# 连接频道
openclaw channels login

# 打开控制界面
# 浏览器访问 http://127.0.0.1:18789

# 诊断问题
openclaw doctor

# 查看日志
openclaw logs --follow
```

---

## 📁 目录结构

```
~/.openclaw/
├── workspace/          # 工作区目录
│   ├── docs/          # 文档
│   ├── scripts/       # 脚本
│   ├── skills/        # 技能
│   └── memory/        # 记忆
├── openclaw.json      # 主配置文件
├── .env               # 环境变量（API Key 等）
└── logs/              # 日志
```

---

## 🌍 支持的模型

### 中国厂商

- 🇨🇳 **智谱 AI** - GLM-5
- 🇨🇳 **月之暗面** - Kimi K2.5
- 🇨🇳 **MiniMax** - M2.5
- 🇨🇳 **阿里云** - Qwen
- 🇨🇳 **字节火山引擎** - Doubao

### 国际厂商

- 🇺🇸 **OpenAI** - GPT-5/Codex
- 🇺🇸 **Anthropic** - Claude Opus/Sonnet
- 🇺🇸 **Google** - Gemini
- 🇪🇺 **Hugging Face** - 多模型聚合
- 🌐 **Kilo Gateway** - 聚合网关

👉 查看 [完整模型列表](docs/openclaw-china-models-config.md)

---

## 💬 支持的聊天工具

- ✅ WhatsApp
- ✅ Telegram
- ✅ Discord
- ✅ Slack
- ✅ Signal
- ✅ iMessage (macOS)
- ✅ 飞书 (Feishu)
- ✅ 微信 (通过企业微信)
- ✅ LINE
- ✅ 更多...

---

## 🔐 安全提示

1. **保护 API Key** - 不要提交到 Git
2. **使用环境变量** - 敏感信息放在 `.env` 文件
3. **定期轮换密钥** - 提高安全性
4. **限制访问** - 配置 `allowFrom` 白名单

---

## 🆘 需要帮助？

### 遇到问题？

1. 运行诊断：`openclaw doctor`
2. 查看日志：`openclaw logs`
3. 阅读文档：[安装指南](docs/INSTALL-GUIDE.md)
4. 查看常见问题：[FAQ](docs/INSTALL-GUIDE.md#常见问题)

### 社区支持

- 💬 [Discord 社区](https://discord.com/invite/clawd)
- 🐙 [GitHub Issues](https://github.com/openclaw/openclaw/issues)
- 📖 [官方文档](https://docs.openclaw.ai)

---

## 🎯 下一步

1. ✅ 安装 OpenClaw
2. ✅ 配置模型（推荐国内模型）
3. ✅ 连接聊天频道
4. ✅ 打开控制界面测试
5. ✅ 开始使用！

---

## 📄 许可证

MIT License - 查看 [LICENSE](LICENSE) 文件

---

**🦞 Happy Clawing!**

有任何问题，欢迎在 Discord 社区提问或提交 GitHub Issue。
