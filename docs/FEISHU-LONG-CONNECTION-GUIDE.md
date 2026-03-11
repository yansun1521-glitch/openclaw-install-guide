# 📘 飞书机器人 OpenClaw 长连接配置指南

> ⚠️ **安全提示**：本文档不包含真实凭证，请替换为你自己的配置

---

## 🔐 安全警告

**永远不要**将以下信息提交到 Git 仓库：

- ❌ App Secret
- ❌ API Key
- ❌ Token
- ❌ 密码

**正确做法**：

1. 使用环境变量
2. 使用 `.env` 文件（添加到 `.gitignore`）
3. 使用配置管理工具

---

## 📋 目录

1. [配置步骤](#配置步骤)
2. [飞书开放平台配置](#飞书开放平台配置)
3. [OpenClaw 配置](#openclaw 配置)
4. [权限配置](#权限配置)
5. [测试验证](#测试验证)
6. [故障排查](#故障排查)

---

## 配置步骤

### 第 1 步：获取飞书应用凭证

1. **访问飞书开放平台**
   - https://open.feishu.cn/app

2. **创建或选择应用**
   - 选择你的企业自建应用
   - 或创建新应用

3. **复制凭证**（不要分享！）
   - App ID: `cli_xxxxxxxxxxxx`
   - App Secret: `xxxxxxxxxxxxxxxx`

### 第 2 步：配置 OpenClaw

编辑配置文件：`~/.openclaw/openclaw.json`

```json5
{
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "你的 APP_ID",      // 替换为你的 App ID
          "appSecret": "你的 APP_SECRET",  // 替换为你的 App Secret
          "domain": "feishu",
          "connectionMode": "websocket"  // 使用 WebSocket 长连接
        }
      }
    }
  }
}
```

**或者使用环境变量**（推荐）：

```json5
{
  "env": {
    "FEISHU_APP_ID": "你的 APP_ID",
    "FEISHU_APP_SECRET": "你的 APP_SECRET"
  },
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "${FEISHU_APP_ID}",
          "appSecret": "${FEISHU_APP_SECRET}",
          "domain": "feishu",
          "connectionMode": "websocket"
        }
      }
    }
  }
}
```

### 第 3 步：重启 Gateway

```bash
openclaw gateway restart
```

---

## 飞书开放平台配置

### 1. 添加机器人

1. 访问 https://open.feishu.cn/app
2. 选择你的应用
3. 左侧菜单 → **机器人**
4. 点击 **添加机器人**
5. 填写信息：
   - 名称：`OpenClaw 助手`
   - 头像：上传 Logo
6. 点击 **完成**

### 2. 配置权限

左侧菜单 → **权限管理** → **申请权限**

#### 必需权限

| 权限名称 | 权限标识 | 用途 |
|---------|---------|------|
| 发送消息 | `im:message` | 发送和接收消息 |
| 群聊管理 | `im:chat` | 管理群聊会话 |
| 通讯录读取 | `contact:contact` | 获取用户信息 |

#### 可选权限

| 权限名称 | 权限标识 | 用途 |
|---------|---------|------|
| 文档读取 | `drive:file` | 读取飞书文档 |
| 表格读取 | `sheets:spreadsheet` | 读取飞书表格 |
| 日历管理 | `calendar:calendar` | 管理日程 |

### 3. 发布应用

1. 左侧菜单 → **版本管理与发布**
2. 点击 **创建版本**
3. 填写版本信息
4. 提交审核
5. 审核通过后发布

---

## OpenClaw 配置

### 配置文件位置

```
~/.openclaw/openclaw.json
```

### 完整配置示例

```json5
{
  // 环境变量（推荐方式）
  "env": {
    "FEISHU_APP_ID": "cli_xxxxxxxxxxxx",
    "FEISHU_APP_SECRET": "xxxxxxxxxxxxxxxx"
  },
  
  // 飞书频道配置
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "${FEISHU_APP_ID}",
          "appSecret": "${FEISHU_APP_SECRET}",
          "domain": "feishu",
          "connectionMode": "websocket"
        }
      },
      // DM 策略
      "dmPolicy": "pairing",  // pairing | allowlist | open | disabled
      // 群聊策略
      "groupPolicy": "mention",  // 需要@机器人
      "mentionPatterns": [
        "@OpenClaw",
        "机器人"
      ]
    }
  },
  
  // 代理配置
  "agents": {
    "defaults": {
      "model": {
        "primary": "zai/glm-5"
      }
    }
  }
}
```

### 配置多个飞书账号

```json5
{
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "${FEISHU_APP_ID_1}",
          "appSecret": "${FEISHU_APP_SECRET_1}",
          "connectionMode": "websocket"
        },
        "stock": {
          "appId": "${FEISHU_APP_ID_2}",
          "appSecret": "${FEISHU_APP_SECRET_2}",
          "connectionMode": "websocket"
        }
      }
    }
  }
}
```

---

## 权限配置

### 在飞书开放平台

1. 访问：https://open.feishu.cn/app
2. 选择应用 → 权限管理
3. 点击 **申请权限**
4. 搜索并添加所需权限
5. 提交申请
6. 等待管理员审批

### 权限说明

#### im:message（必需）

```
用途：发送和接收消息
- 发送文本消息
- 发送富文本消息
- 接收用户消息
- 读取消息历史
```

#### im:chat（必需）

```
用途：管理群聊会话
- 获取群聊信息
- 添加/移除群成员
- 设置群公告
```

---

## 测试验证

### 1. 检查连接状态

```bash
# 查看 Gateway 状态
openclaw gateway status

# 查看飞书频道
openclaw channels list
```

**预期输出**：
```
Channel: feishu
Status: connected
Account: default
Mode: websocket
```

### 2. 查看日志

```bash
# 实时查看日志
openclaw logs --follow | grep feishu
```

**成功输出**：
```
[Feishu] WebSocket connected
[Feishu] Account default authenticated
[Feishu] Listening for messages...
```

### 3. 发送测试消息

```bash
# 使用 CLI 发送
openclaw message --channel feishu --target "ou_xxx" "你好，这是测试消息"
```

### 4. 在飞书中测试

1. 打开飞书
2. 找到 `OpenClaw 助手` 机器人
3. 发送：`你好`
4. 应该立即收到 AI 回复

---

## 故障排查

### 问题 1：机器人无响应

**排查**：

```bash
# 检查 Gateway
openclaw gateway status

# 查看日志
openclaw logs | grep feishu | tail -50

# 检查连接
lsof -i :18789 | grep ESTABLISHED
```

**解决**：
```bash
openclaw gateway restart
```

### 问题 2：权限错误

**症状**：日志显示 `403 Forbidden`

**解决**：
1. 访问飞书开放平台
2. 检查权限是否已审批
3. 重新发布应用
4. 重启 Gateway

### 问题 3：WebSocket 断开

**症状**：日志显示 `WebSocket disconnected`

**解决**：
```bash
# 检查网络
ping open.feishu.cn

# 重启 Gateway
openclaw gateway restart
```

### 问题 4：认证失败

**症状**：日志显示 `401 Unauthorized`

**检查**：
```bash
# 验证配置
cat ~/.openclaw/openclaw.json | grep -A 10 feishu
```

**解决**：
1. 检查 App ID 和 Secret 是否正确
2. 检查是否有空格或特殊字符
3. 重新配置并重启

---

## 安全最佳实践

### 1. 使用环境变量

```bash
# ~/.openclaw/.env
FEISHU_APP_ID=cli_xxxxxxxxxxxx
FEISHU_APP_SECRET=xxxxxxxxxxxxxxxx
```

```json5
// ~/.openclaw/openclaw.json
{
  "env": {
    "FEISHU_APP_ID": "${FEISHU_APP_ID}",
    "FEISHU_APP_SECRET": "${FEISHU_APP_SECRET}"
  }
}
```

### 2. 添加到 .gitignore

```bash
# ~/.openclaw/.gitignore
.env
openclaw.json
*.secret
*.key
```

### 3. 不要提交敏感信息

```bash
# ❌ 错误：提交包含凭证的文件
git add openclaw.json
git commit -m "配置飞书"

# ✅ 正确：只提交配置模板
git add openclaw.example.json
git commit -m "添加配置示例"
```

### 4. 使用配置模板

创建 `openclaw.example.json`：

```json5
{
  "env": {
    "FEISHU_APP_ID": "你的 APP_ID",
    "FEISHU_APP_SECRET": "你的 APP_SECRET"
  },
  "channels": {
    "feishu": {
      "enabled": true,
      "accounts": {
        "default": {
          "appId": "${FEISHU_APP_ID}",
          "appSecret": "${FEISHU_APP_SECRET}",
          "connectionMode": "websocket"
        }
      }
    }
  }
}
```

---

## 快速命令参考

```bash
# 启动 Gateway
openclaw gateway --port 18789

# 重启 Gateway
openclaw gateway restart

# 查看状态
openclaw gateway status

# 查看飞书频道
openclaw channels list

# 查看日志
openclaw logs --follow | grep feishu

# 发送测试消息
openclaw message --channel feishu --target "ou_xxx" "测试"

# 重新登录
openclaw channels login feishu
```

---

## 相关文档

- [OpenClaw 飞书频道文档](https://docs.openclaw.ai/channels/feishu)
- [飞书开放平台文档](https://open.feishu.cn/document/)
- [配置安全指南](https://docs.openclaw.ai/gateway/configuration)

---

*最后更新：2026-03-12*
*⚠️ 本文档不包含真实凭证，请替换为你自己的配置*
