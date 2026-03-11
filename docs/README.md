# 📚 OpenClaw 文档索引

> 快速找到你需要的文档！

---

## 🚀 新手入门（必读）

| 文档 | 说明 | 适合人群 |
|------|------|---------|
| [README.md](../README.md) | 工作区首页，快速了解 OpenClaw | 所有人 |
| [INSTALL-GUIDE.md](./INSTALL-GUIDE.md) | 安装指南，多种安装方式 | 新手 |
| [STEP-BY-STEP-INSTALL.md](./STEP-BY-STEP-INSTALL.md) | 超详细分步安装教程 | 零基础新手 |
| [openclaw-china-models-config.md](./openclaw-china-models-config.md) | 全球模型配置指南 | 所有人 |

---

## 📖 官方文档

### 快速开始
- [Getting Started](https://docs.openclaw.ai/start/getting-started) - 官方快速开始
- [Wizard](https://docs.openclaw.ai/start/wizard) - 配置向导
- [Control UI](https://docs.openclaw.ai/web/control-ui) - 控制界面

### 配置指南
- [Configuration](https://docs.openclaw.ai/gateway/configuration) - 配置概览
- [Configuration Reference](https://docs.openclaw.ai/gateway/configuration-reference) - 完整配置项
- [Configuration Examples](https://docs.openclaw.ai/gateway/configuration-examples) - 配置示例

### 模型相关
- [Model Providers](https://docs.openclaw.ai/concepts/model-providers) - 模型提供商
- [Models CLI](https://docs.openclaw.ai/concepts/models) - 模型命令
- [Model Failover](https://docs.openclaw.ai/concepts/model-failover) - 模型故障转移

### 频道连接
- [Channels Overview](https://docs.openclaw.ai/channels/index) - 频道概览
- [WhatsApp](https://docs.openclaw.ai/channels/whatsapp)
- [Telegram](https://docs.openclaw.ai/channels/telegram)
- [Discord](https://docs.openclaw.ai/channels/discord)
- [Slack](https://docs.openclaw.ai/channels/slack)
- [Feishu](https://docs.openclaw.ai/channels/feishu)

### 自动化
- [Cron Jobs](https://docs.openclaw.ai/automation/cron-jobs) - 定时任务
- [Hooks](https://docs.openclaw.ai/automation/hooks) - Webhooks
- [Heartbeat](https://docs.openclaw.ai/gateway/heartbeat) - 心跳任务

### CLI 命令
- [CLI Reference](https://docs.openclaw.ai/cli/index) - 完整命令参考
- [onboard](https://docs.openclaw.ai/cli/onboard) - 配置向导
- [gateway](https://docs.openclaw.ai/cli/gateway) - 网关管理
- [models](https://docs.openclaw.ai/cli/models) - 模型管理
- [channels](https://docs.openclaw.ai/cli/channels) - 频道管理
- [doctor](https://docs.openclaw.ai/cli/doctor) - 诊断工具

---

## 🛠️ 本地文档

### 安装相关
- [INSTALL-GUIDE.md](./INSTALL-GUIDE.md) - 安装指南
- [STEP-BY-STEP-INSTALL.md](./STEP-BY-STEP-INSTALL.md) - 分步教程

### 配置相关
- [openclaw-china-models-config.md](./openclaw-china-models-config.md) - 模型配置指南

### 脚本工具
- [install-openclaw.sh](../scripts/install-openclaw.sh) - 一键安装脚本
- [start-openclaw.sh](../scripts/start-openclaw.sh) - 启动脚本
- [stop-openclaw.sh](../scripts/stop-openclaw.sh) - 停止脚本

---

## 🎯 按主题查找

### 安装和配置
1. [INSTALL-GUIDE.md](./INSTALL-GUIDE.md) - 安装指南
2. [STEP-BY-STEP-INSTALL.md](./STEP-BY-STEP-INSTALL.md) - 分步教程
3. [openclaw-china-models-config.md](./openclaw-china-models-config.md) - 模型配置
4. [Configuration](https://docs.openclaw.ai/gateway/configuration) - 官方配置指南

### 模型和 API
1. [Model Providers](https://docs.openclaw.ai/concepts/model-providers) - 模型提供商
2. [Models CLI](https://docs.openclaw.ai/concepts/models) - 模型命令
3. [openclaw-china-models-config.md](./openclaw-china-models-config.md) - 配置指南

### 频道连接
1. [Channels Overview](https://docs.openclaw.ai/channels/index) - 概览
2. [Channel Troubleshooting](https://docs.openclaw.ai/channels/troubleshooting) - 故障排查

### 故障排查
1. [Doctor](https://docs.openclaw.ai/cli/doctor) - 诊断命令
2. [Troubleshooting](https://docs.openclaw.ai/channels/troubleshooting) - 频道故障排查
3. [INSTALL-GUIDE.md#常见问题](./INSTALL-GUIDE.md#常见问题) - 安装常见问题

### 自动化
1. [Cron Jobs](https://docs.openclaw.ai/automation/cron-jobs) - 定时任务
2. [Hooks](https://docs.openclaw.ai/automation/hooks) - Webhooks
3. [Heartbeat](https://docs.openclaw.ai/gateway/heartbeat) - 心跳

---

## 🎓 学习路径

### 第 1 天：安装和基础
- ✅ 阅读 [README.md](../README.md)
- ✅ 按照 [INSTALL-GUIDE.md](./INSTALL-GUIDE.md) 安装
- ✅ 运行 `openclaw onboard` 配置

### 第 2 天：连接频道
- ✅ 阅读 [Channels Overview](https://docs.openclaw.ai/channels/index)
- ✅ 连接 WhatsApp/Telegram/Discord
- ✅ 测试消息收发

### 第 3 天：模型配置
- ✅ 阅读 [Model Providers](https://docs.openclaw.ai/concepts/model-providers)
- ✅ 配置合适的模型
- ✅ 设置 fallback 模型

### 第 4 天：自动化
- ✅ 阅读 [Cron Jobs](https://docs.openclaw.ai/automation/cron-jobs)
- ✅ 设置定时任务
- ✅ 配置心跳检查

### 第 5 天：进阶使用
- ✅ 探索 [Skills](https://docs.openclaw.ai/cli/skills)
- ✅ 配置多代理
- ✅ 自定义工作流

---

## 💡 快速参考

### 常用命令

```bash
# 安装
npm install -g openclaw@latest

# 启动
openclaw gateway --port 18789

# 配置
openclaw onboard

# 模型
openclaw models list
openclaw models set <model>

# 频道
openclaw channels login

# 诊断
openclaw doctor
openclaw logs
```

### 重要路径

```
~/.openclaw/
├── openclaw.json      # 主配置
├── .env               # 环境变量
├── workspace/         # 工作区
│   ├── docs/         # 文档
│   ├── scripts/      # 脚本
│   └── memory/       # 记忆
└── logs/              # 日志
```

### 重要端口

- **18789** - Gateway 默认端口
- **Control UI** - http://127.0.0.1:18789

---

## 🆘 获取帮助

### 遇到问题？

1. **查看文档** - 本索引中的相关文档
2. **运行诊断** - `openclaw doctor`
3. **查看日志** - `openclaw logs --follow`
4. **搜索 Issue** - [GitHub Issues](https://github.com/openclaw/openclaw/issues)

### 社区支持

- 💬 [Discord 社区](https://discord.com/invite/clawd)
- 🐙 [GitHub Discussions](https://github.com/openclaw/openclaw/discussions)
- 📖 [官方文档](https://docs.openclaw.ai)

---

## 📝 文档贡献

如果你发现文档有问题或想改进：

1. Fork 仓库
2. 修改文档
3. 提交 Pull Request

或者直接提交 Issue 告诉我们！

---

*最后更新：2026-03-12*
*文档版本：1.0*
