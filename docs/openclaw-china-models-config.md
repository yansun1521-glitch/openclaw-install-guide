# OpenClaw 全球模型厂商 API Key 配置指南

本文档整理了 OpenClaw 支持的全球主流模型厂商配置方法，包括中国和国际厂商。

---

## 🚀 快速开始

### 第一步：安装 OpenClaw

```bash
# 使用 npm 全局安装
npm install -g openclaw@latest

# 验证安装
openclaw --version
```

### 第二步：运行引导向导

```bash
# 交互式配置向导（推荐新手）
openclaw onboard

# 或安装为系统服务
openclaw onboard --install-daemon
```

### 第三步：配置模型

```bash
# 方式 1：使用向导选择模型
openclaw configure

# 方式 2：直接设置模型
openclaw models set <provider/model>

# 方式 3：编辑配置文件
# 编辑 ~/.openclaw/openclaw.json
```

### 第四步：启动 Gateway

```bash
# 前台运行
openclaw gateway --port 18789

# 后台运行（如果已安装 daemon）
openclaw gateway start

# 查看状态
openclaw gateway status
```

### 第五步：验证配置

```bash
# 查看当前模型配置
openclaw models status

# 查看所有可用模型
openclaw models list

# 测试对话
openclaw agent "你好，测试一下"
```

---

## 📁 配置文件说明

### 配置文件位置

- **主配置**：`~/.openclaw/openclaw.json`
- **模型配置**：`~/.openclaw/agents/<agentId>/models.json`
- **环境变量**：`~/.openclaw/.env`

### 配置文件结构

```json5
{
  // 环境变量（推荐在此管理 API Key）
  "env": {
    "ANTHROPIC_API_KEY": "sk-ant-...",
    "OPENAI_API_KEY": "sk-...",
    "ZAI_API_KEY": "sk-..."
  },
  
  // 代理配置（可选）
  "gateway": {
    "port": 18789,
    "bind": "127.0.0.1"
  },
  
  // 代理默认配置
  "agents": {
    "defaults": {
      "workspace": "~/.openclaw/workspace",
      "model": {
        "primary": "anthropic/claude-opus-4-6",
        "fallbacks": ["openai/gpt-5.1-codex"]
      },
      "models": {
        "anthropic/claude-opus-4-6": { "alias": "Opus" },
        "openai/gpt-5.1-codex": { "alias": "Codex" }
      }
    }
  },
  
  // 自定义模型提供商（可选）
  "models": {
    "mode": "merge",
    "providers": {
      "moonshot": {
        "baseUrl": "https://api.moonshot.ai/v1",
        "apiKey": "${MOONSHOT_API_KEY}",
        "api": "openai-completions"
      }
    }
  },
  
  // 频道配置（以 WhatsApp 为例）
  "channels": {
    "whatsapp": {
      "enabled": true,
      "dmPolicy": "pairing"
    }
  }
}
```

### 常用配置命令

```bash
# 查看配置
openclaw config get agents.defaults.model
openclaw config get channels

# 修改配置
openclaw config set agents.defaults.model.primary "anthropic/claude-opus-4-6"
openclaw config set agents.defaults.heartbeat.every "30m"

# 删除配置
openclaw config unset agents.defaults.model.fallbacks

# 热重载配置（Gateway 会自动重载，无需重启）
openclaw gateway reload
```

---

## 🔐 API Key 管理

### 方式一：环境变量文件（推荐）

创建 `~/.openclaw/.env` 文件：

```bash
# 编辑环境变量文件
echo "ANTHROPIC_API_KEY=sk-ant-..." >> ~/.openclaw/.env
echo "OPENAI_API_KEY=sk-..." >> ~/.openclaw/.env
echo "ZAI_API_KEY=sk-..." >> ~/.openclaw/.env

# 重启 Gateway 使环境变量生效
openclaw gateway restart
```

### 方式二：直接在配置文件中

编辑 `~/.openclaw/openclaw.json`：

```json5
{
  "env": {
    "ANTHROPIC_API_KEY": "sk-ant-...",
    "OPENAI_API_KEY": "sk-..."
  }
}
```

### 方式三：使用 CLI 配置

```bash
# 通过 onboarding 配置
openclaw onboard --auth-choice anthropic-api-key
openclaw onboard --auth-choice openai-api-key

# 通过 models auth 配置
openclaw models auth login --provider <provider>
```

### 安全建议

1. **不要**将 API Key 提交到 Git 仓库
2. 使用 `.env` 文件管理敏感信息
3. 定期轮换 API Key
4. 为不同用途创建不同的 API Key
5. 设置用量告警

---

## 🛠️ 故障排查

### 常见问题

#### 1. "Model is not allowed"

**原因**：模型不在允许列表中

**解决**：
```bash
# 添加模型到允许列表
openclaw config set agents.defaults.models["anthropic/claude-opus-4-6"] '{"alias":"Opus"}'

# 或清除允许列表
openclaw config unset agents.defaults.models
```

#### 2. "Missing auth" / 认证失败

**原因**：API Key 未配置或已过期

**解决**：
```bash
# 检查认证状态
openclaw models status

# 重新认证
openclaw models auth login --provider <provider>

# 检查环境变量
echo $ANTHROPIC_API_KEY
cat ~/.openclaw/.env
```

#### 3. Gateway 无法启动

**原因**：配置文件错误

**解决**：
```bash
# 检查配置
openclaw doctor

# 自动修复
openclaw doctor --fix

# 查看日志
openclaw logs

# 验证 JSON 语法
cat ~/.openclaw/openclaw.json | jq .
```

#### 4. 模型响应慢或超时

**原因**：网络问题或模型负载高

**解决**：
```bash
# 配置 fallback 模型
openclaw models fallbacks add openai/gpt-5.1-codex

# 检查网络
curl -I https://api.anthropic.com

# 使用国内镜像或聚合网关
openclaw models set kilocode/kilo/auto
```

### 诊断命令

```bash
# 完整诊断
openclaw doctor

# 查看 Gateway 状态
openclaw gateway status

# 查看实时日志
openclaw logs --follow

# 查看会话状态
openclaw sessions list

# 查看模型状态
openclaw models status

# 网络连通性测试
openclaw health
```

---

## 📋 目录

### 中国厂商
1. [阿里云百炼 (通义千问/Qwen)](#阿里云百炼通义千问 qwen)
2. [字节火山引擎 (Doubao/豆包)](#字节火山引擎 doubao)
3. [智谱 AI (GLM/Z.AI)](#智谱 ai-glmzai)
4. [月之暗面 (Kimi/Moonshot)](#月之暗面 kimimoonshot)
5. [MiniMax (M2.5)](#minimax-m25)

### 国际厂商
6. [OpenAI (GPT/Codex)](#openai-gptcodex)
7. [Anthropic (Claude)](#anthropic-claude)
8. [Google (Gemini)](#google-gemini)
9. [Hugging Face (多模型聚合)](#hugging-face 多模型聚合)
10. [OpenRouter (多模型聚合)](#openrouter 多模型聚合)
11. [Kilo Gateway (聚合网关)](#kilo-gateway 聚合网关)
12. [其他国际厂商](#其他国际厂商)

---

## 🇨🇳 中国厂商

### 阿里云百炼 (通义千问/Qwen)

#### 方式一：OAuth 免费额度（推荐）

Qwen 提供 OAuth 免费访问，每日 2000 次请求限额。

**步骤：**

```bash
# 1. 启用 Qwen OAuth 插件
openclaw plugins enable qwen-portal-auth

# 2. 重启 Gateway
openclaw gateway restart

# 3. 登录认证
openclaw models auth login --provider qwen-portal --set-default
```

**可用模型：**
- `qwen-portal/coder-model` - Qwen Coder 代码模型
- `qwen-portal/vision-model` - Qwen Vision 视觉模型

**切换模型：**
```bash
openclaw models set qwen-portal/coder-model
```

#### 方式二：API Key 配置

编辑 `~/.openclaw/openclaw.json`：

```json5
{
  env: { 
    DASHSCOPE_API_KEY: "sk-xxx" // 从阿里云百炼控制台获取
  },
  agents: {
    defaults: {
      model: { primary: "dashscope/qwen-max" }
    }
  },
  models: {
    mode: "merge",
    providers: {
      dashscope: {
        baseUrl: "https://dashscope.aliyuncs.com/compatible-mode/v1",
        apiKey: "${DASHSCOPE_API_KEY}",
        api: "openai-completions",
        models: [
          {
            id: "qwen-max",
            name: "Qwen Max",
            contextWindow: 32768,
            maxTokens: 8192
          },
          {
            id: "qwen-plus",
            name: "Qwen Plus",
            contextWindow: 131072,
            maxTokens: 8192
          }
        ]
      }
    }
  }
}
```

**获取 API Key：**
1. 访问 https://bailian.console.aliyun.com/
2. 登录阿里云账号
3. 进入「API-KEY 管理」
4. 创建新的 API Key

---

### 字节火山引擎 (Doubao/豆包)

#### 配置方法

```bash
# CLI 一键配置
openclaw onboard --auth-choice volcengine-api-key
```

或设置环境变量：
```bash
export VOLCANO_ENGINE_API_KEY="your-api-key"
```

**配置示例：**
```json5
{
  env: { VOLCANO_ENGINE_API_KEY: "your-api-key" },
  agents: {
    defaults: {
      model: { primary: "volcengine/doubao-seed-1-8-251228" }
    }
  }
}
```

**可用模型：**
- `volcengine/doubao-seed-1-8-251228` - Doubao Seed 1.8
- `volcengine/doubao-seed-code-preview-251028` - 代码模型
- `volcengine/kimi-k2-5-260127` - Kimi K2.5
- `volcengine/glm-4-7-251222` - GLM 4.7
- `volcengine/deepseek-v3-2-251201` - DeepSeek V3.2

**代码专用模型 (volcengine-plan)：**
- `volcengine-plan/ark-code-latest`
- `volcengine-plan/doubao-seed-code`
- `volcengine-plan/kimi-k2.5`
- `volcengine-plan/glm-4.7`

**获取 API Key：**
1. 访问 https://www.volcengine.com/
2. 注册/登录火山引擎账号
3. 进入「访问控制」→「API Key 管理」
4. 创建 API Key

---

### 智谱 AI (GLM/Z.AI)

#### 配置方法

```bash
# CLI 一键配置
openclaw onboard --auth-choice zai-api-key
```

或设置环境变量：
```bash
export ZAI_API_KEY="your-api-key"
```

**配置示例：**
```json5
{
  env: { ZAI_API_KEY: "your-api-key" },
  agents: {
    defaults: {
      model: { primary: "zai/glm-5" }
    }
  }
}
```

**可用模型：**
- `zai/glm-5` - GLM-5 最新模型
- `zai/glm-4` - GLM-4
- `zai/glm-3-turbo` - GLM-3 Turbo

**别名支持：**
- `z.ai/*` 和 `z-ai/*` 会自动规范化为 `zai/*`

**获取 API Key：**
1. 访问 https://open.bigmodel.cn/
2. 注册/登录智谱 AI 账号
3. 进入「API Key 管理」
4. 创建 API Key

---

### 月之暗面 (Kimi/Moonshot)

#### 配置方法

Kimi 使用 OpenAI 兼容接口，需配置为自定义提供商。

**配置示例：**
```json5
{
  env: { MOONSHOT_API_KEY: "sk-xxx" },
  agents: {
    defaults: {
      model: { primary: "moonshot/kimi-k2.5" }
    }
  },
  models: {
    mode: "merge",
    providers: {
      moonshot: {
        baseUrl: "https://api.moonshot.ai/v1",
        apiKey: "${MOONSHOT_API_KEY}",
        api: "openai-completions",
        models: [
          { id: "kimi-k2.5", name: "Kimi K2.5" },
          { id: "kimi-k2-0905-preview", name: "Kimi K2 0905 Preview" },
          { id: "kimi-k2-turbo-preview", name: "Kimi K2 Turbo" },
          { id: "kimi-k2-thinking", name: "Kimi K2 Thinking" }
        ]
      }
    }
  }
}
```

**可用模型：**
- `moonshot/kimi-k2.5`
- `moonshot/kimi-k2-0905-preview`
- `moonshot/kimi-k2-turbo-preview`
- `moonshot/kimi-k2-thinking`
- `moonshot/kimi-k2-thinking-turbo`

**Kimi Coding (Anthropic 兼容)：**
```json5
{
  env: { KIMI_API_KEY: "sk-xxx" },
  agents: {
    defaults: {
      model: { primary: "kimi-coding/k2p5" }
    }
  }
}
```

**获取 API Key：**
1. 访问 https://platform.moonshot.cn/
2. 注册/登录月之暗面账号
3. 进入「API Key 管理」
4. 创建 API Key

---

### MiniMax (M2.5)

#### 方式一：OAuth Coding Plan（推荐）

```bash
# 1. 启用 MiniMax OAuth 插件
openclaw plugins enable minimax-portal-auth

# 2. 重启 Gateway
openclaw gateway restart

# 3. 登录认证
openclaw onboard --auth-choice minimax-portal
```

登录时会提示选择 endpoint：
- **Global** - 国际用户 (`api.minimax.io`)
- **CN** - 国内用户 (`api.minimaxi.com`)

#### 方式二：API Key 配置

```json5
{
  env: { MINIMAX_API_KEY: "sk-xxx" },
  agents: {
    defaults: {
      model: { primary: "minimax/MiniMax-M2.5" }
    }
  },
  models: {
    mode: "merge",
    providers: {
      minimax: {
        baseUrl: "https://api.minimax.io/anthropic",
        apiKey: "${MINIMAX_API_KEY}",
        api: "anthropic-messages",
        models: [
          {
            id: "MiniMax-M2.5",
            name: "MiniMax M2.5",
            reasoning: true,
            contextWindow: 200000,
            maxTokens: 8192,
            cost: { input: 0.3, output: 1.2, cacheRead: 0.03, cacheWrite: 0.12 }
          },
          {
            id: "MiniMax-M2.5-highspeed",
            name: "MiniMax M2.5 Highspeed",
            reasoning: true,
            contextWindow: 200000,
            maxTokens: 8192,
            cost: { input: 0.3, output: 1.2, cacheRead: 0.03, cacheWrite: 0.12 }
          }
        ]
      }
    }
  }
}
```

**可用模型：**
- `minimax/MiniMax-M2.5`
- `minimax/MiniMax-M2.5-highspeed` (高速版)

**获取 API Key：**
1. 访问 https://platform.minimax.io/
2. 注册/登录 MiniMax 账号
3. 进入「API Key 管理」
4. 创建 API Key

---

## 🌍 国际厂商

### OpenAI (GPT/Codex)

#### 方式一：API Key

```bash
# CLI 一键配置
openclaw onboard --auth-choice openai-api-key
```

或设置环境变量：
```bash
export OPENAI_API_KEY="sk-..."
```

**配置示例：**
```json5
{
  env: { OPENAI_API_KEY: "sk-..." },
  agents: {
    defaults: {
      model: { primary: "openai/gpt-5.1-codex" }
    }
  }
}
```

**可用模型：**
- `openai/gpt-5.1-codex`
- `openai/gpt-5.2`
- `openai/gpt-4.1`

#### 方式二：OAuth (ChatGPT Plus)

```bash
# 使用 Codex OAuth
openclaw onboard --auth-choice openai-codex
# 或
openclaw models auth login --provider openai-codex
```

**可用模型：**
- `openai-codex/gpt-5.3-codex`

**获取 API Key：**
1. 访问 https://platform.openai.com/
2. 登录 OpenAI 账号
3. 进入「API Keys」
4. 创建新的 API Key

---

### Anthropic (Claude)

#### 方式一：API Key（推荐）

```bash
# CLI 一键配置
openclaw onboard --auth-choice anthropic-api-key
```

或设置环境变量：
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
```

**配置示例：**
```json5
{
  env: { ANTHROPIC_API_KEY: "sk-ant-..." },
  agents: {
    defaults: {
      model: { primary: "anthropic/claude-opus-4-6" }
    }
  }
}
```

**可用模型：**
- `anthropic/claude-opus-4-6` - 最强模型
- `anthropic/claude-sonnet-4-5` - 平衡性能和成本
- `anthropic/claude-haiku-3-5` - 快速轻量

#### 方式二：Setup Token (Claude Code 订阅)

⚠️ **注意：** Anthropic 可能限制订阅用户在外部工具中使用，请确认当前条款。

```bash
# 获取 setup-token
claude setup-token

# 配置到 OpenClaw
openclaw models auth paste-token --provider anthropic
```

**获取 API Key：**
1. 访问 https://console.anthropic.com/
2. 登录 Anthropic 账号
3. 进入「Keys」
4. 创建新的 API Key

---

### Google (Gemini)

#### 方式一：API Key

```bash
# CLI 一键配置
openclaw onboard --auth-choice gemini-api-key
```

或设置环境变量：
```bash
export GEMINI_API_KEY="..."
```

**配置示例：**
```json5
{
  env: { GEMINI_API_KEY: "..." },
  agents: {
    defaults: {
      model: { primary: "google/gemini-3-pro-preview" }
    }
  }
}
```

**可用模型：**
- `google/gemini-3-pro-preview` - 最强模型
- `google/gemini-3-flash-preview` - 快速模型
- `google/gemini-2.5-pro` - 稳定版

#### 方式二：Vertex AI (企业级)

使用 Google Cloud ADC 认证，无需 API Key。

```bash
# 确保已安装 gcloud 并登录
gcloud auth application-default login
```

**配置示例：**
```json5
{
  agents: {
    defaults: {
      model: { primary: "google-vertex/gemini-3-pro-preview" }
    }
  }
}
```

#### 方式三：OAuth (Gemini CLI / Antigravity)

⚠️ **注意：** 非官方集成，可能违反 Google 条款，建议使用非关键账号。

```bash
# 启用 Antigravity 插件
openclaw plugins enable google-antigravity-auth
openclaw models auth login --provider google-antigravity --set-default

# 或 Gemini CLI 插件
openclaw plugins enable google-gemini-cli-auth
openclaw models auth login --provider google-gemini-cli --set-default
```

**获取 API Key：**
1. 访问 https://aistudio.google.com/
2. 登录 Google 账号
3. 进入「API Keys」
4. 创建新的 API Key

---

### Hugging Face (多模型聚合)

Hugging Face Inference Providers 提供 OpenAI 兼容接口，可访问 DeepSeek、Llama、Qwen 等多种模型。

#### 配置方法

```bash
# CLI 一键配置
openclaw onboard --auth-choice huggingface-api-key
```

或设置环境变量：
```bash
export HUGGINGFACE_HUB_TOKEN="hf_..."
# 或
export HF_TOKEN="hf_..."
```

**配置示例：**
```json5
{
  env: { HUGGINGFACE_HUB_TOKEN: "hf_..." },
  agents: {
    defaults: {
      model: { primary: "huggingface/deepseek-ai/DeepSeek-R1" }
    }
  }
}
```

**可用模型：**

| 模型 | 模型引用 |
|------|---------|
| DeepSeek R1 | `huggingface/deepseek-ai/DeepSeek-R1` |
| DeepSeek V3.2 | `huggingface/deepseek-ai/DeepSeek-V3.2` |
| Qwen3 8B | `huggingface/Qwen/Qwen3-8B` |
| Qwen2.5 7B Instruct | `huggingface/Qwen/Qwen2.5-7B-Instruct` |
| Qwen3 32B | `huggingface/Qwen/Qwen3-32B` |
| Llama 3.3 70B Instruct | `huggingface/meta-llama/Llama-3.3-70B-Instruct` |
| Llama 3.1 8B Instruct | `huggingface/meta-llama/Llama-3.1-8B-Instruct` |
| GLM 4.7 | `huggingface/zai-org/GLM-4.7` |
| Kimi K2.5 | `huggingface/moonshotai/Kimi-K2.5` |

**策略后缀：**
- `:fastest` - 最高速度（路由器自动选择）
- `:cheapest` - 最低成本（路由器自动选择）
- `:together` / `:sambanova` - 强制指定后端

**示例：**
```bash
openclaw models set huggingface/Qwen/Qwen3-8B:cheapest
```

**获取 Token：**
1. 访问 https://huggingface.co/settings/tokens
2. 创建 Fine-grained Token
3. 勾选权限：**Make calls to Inference Providers**
4. 复制 Token

---

### OpenRouter (多模型聚合)

OpenRouter 提供统一的 API 访问多家模型。

#### 配置方法

```bash
# CLI 一键配置
openclaw onboard --auth-choice openrouter-api-key
```

或设置环境变量：
```bash
export OPENROUTER_API_KEY="sk-or-..."
```

**配置示例：**
```json5
{
  env: { OPENROUTER_API_KEY: "sk-or-..." },
  agents: {
    defaults: {
      model: { primary: "openrouter/anthropic/claude-sonnet-4-5" }
    }
  }
}
```

**扫描免费模型：**
```bash
# 扫描 OpenRouter 免费模型
openclaw models scan --provider openrouter

# 设置默认模型
openclaw models scan --set-default
```

**可用模型：**
- `openrouter/anthropic/claude-sonnet-4-5`
- `openrouter/openai/gpt-5.2`
- `openrouter/google/gemini-3-pro-preview`
- `openrouter/moonshotai/kimi-k2`
- `openrouter/meta-llama/llama-3.3-70b-instruct`
- 等等...

**获取 API Key：**
1. 访问 https://openrouter.ai/
2. 登录账号
3. 进入「Keys」
4. 创建新的 API Key

---

### Kilo Gateway (聚合网关)

Kilo Gateway 提供统一 API，可访问多家模型（包括国内厂商）。

#### 配置方法

```bash
# CLI 一键配置
openclaw onboard --kilocode-api-key <your-kilocode-api-key>
```

或设置环境变量：
```bash
export KILOCODE_API_KEY="your-kilocode-api-key"
```

**配置示例：**
```json5
{
  env: { KILOCODE_API_KEY: "your-kilocode-api-key" },
  agents: {
    defaults: {
      model: { primary: "kilocode/kilo/auto" }
    }
  }
}
```

**可用模型：**
- `kilocode/kilo/auto` - 智能路由（默认）
- `kilocode/anthropic/claude-sonnet-4`
- `kilocode/openai/gpt-5.2`
- `kilocode/google/gemini-3-pro-preview`
- `kilocode/zai/glm-5` (智谱 GLM)
- `kilocode/moonshot/kimi-k2.5` (Kimi)
- 等等...

**特点：**
- 单一 API Key 访问多家模型
- 智能路由自动选择最佳模型
- 支持国内模型（GLM、Kimi 等）

**获取 API Key：**
1. 访问 https://app.kilo.ai
2. 注册/登录账号
3. 进入「API Keys」
4. 生成新的 API Key

---

### 其他国际厂商

#### Vercel AI Gateway

```bash
openclaw onboard --auth-choice ai-gateway-api-key
```

**环境变量：** `AI_GATEWAY_API_KEY`

**模型引用：** `vercel-ai-gateway/anthropic/claude-opus-4.6`

---

#### xAI (Grok)

```bash
# 设置环境变量
export XAI_API_KEY="xai-..."
```

**模型引用：** `xai/grok-2`

---

#### Mistral AI

```bash
openclaw onboard --auth-choice mistral-api-key
```

**环境变量：** `MISTRAL_API_KEY`

**可用模型：**
- `mistral/mistral-large-latest`
- `mistral/mistral-medium`
- `mistral/open-mistral-nemo`

---

#### Groq

```bash
# 设置环境变量
export GROQ_API_KEY="gsk_..."
```

**模型引用：** `groq/llama-3.3-70b-versatile`

---

#### Cerebras

```bash
# 设置环境变量
export CEREBRAS_API_KEY="..."
```

**可用模型：**
- `cerebras/zai-glm-4.7` (GLM-4.7)
- `cerebras/zai-glm-4.6` (GLM-4.6)

---

#### GitHub Copilot

```bash
# 设置环境变量
export COPILOT_GITHUB_TOKEN="ghp_..."
# 或
export GH_TOKEN="ghp_..."
```

**模型引用：** `github-copilot/gpt-4-copilot`

---

#### OpenCode Zen

```bash
openclaw onboard --auth-choice opencode-zen
```

**环境变量：** `OPENCODE_API_KEY` 或 `OPENCODE_ZEN_API_KEY`

**模型引用：** `opencode/claude-opus-4-6`

---

## 📝 快速对照表

### 中国厂商

| 厂商 | 提供商名称 | 环境变量 | 推荐模型 | 认证方式 |
|------|-----------|---------|---------|---------|
| 阿里云 Qwen | `qwen-portal` | - | `qwen-portal/coder-model` | OAuth |
| 阿里云百炼 | `dashscope` | `DASHSCOPE_API_KEY` | `qwen-max` | API Key |
| 字节火山引擎 | `volcengine` | `VOLCANO_ENGINE_API_KEY` | `doubao-seed-1-8-251228` | API Key |
| 智谱 AI | `zai` | `ZAI_API_KEY` | `glm-5` | API Key |
| 月之暗面 Kimi | `moonshot` | `MOONSHOT_API_KEY` | `kimi-k2.5` | API Key |
| MiniMax | `minimax` | `MINIMAX_API_KEY` | `MiniMax-M2.5` | OAuth/API Key |

### 国际厂商

| 厂商 | 提供商名称 | 环境变量 | 推荐模型 | 认证方式 |
|------|-----------|---------|---------|---------|
| OpenAI | `openai` | `OPENAI_API_KEY` | `gpt-5.1-codex` | API Key/OAuth |
| OpenAI Codex | `openai-codex` | - | `gpt-5.3-codex` | OAuth |
| Anthropic | `anthropic` | `ANTHROPIC_API_KEY` | `claude-opus-4-6` | API Key/Token |
| Google Gemini | `google` | `GEMINI_API_KEY` | `gemini-3-pro-preview` | API Key |
| Google Vertex | `google-vertex` | - | `gemini-3-pro-preview` | ADC |
| Hugging Face | `huggingface` | `HUGGINGFACE_HUB_TOKEN` | `deepseek-ai/DeepSeek-R1` | Token |
| OpenRouter | `openrouter` | `OPENROUTER_API_KEY` | `anthropic/claude-sonnet-4-5` | API Key |
| Kilo Gateway | `kilocode` | `KILOCODE_API_KEY` | `kilo/auto` | API Key |
| Vercel AI | `vercel-ai-gateway` | `AI_GATEWAY_API_KEY` | `anthropic/claude-opus-4.6` | API Key |
| xAI (Grok) | `xai` | `XAI_API_KEY` | `grok-2` | API Key |
| Mistral | `mistral` | `MISTRAL_API_KEY` | `mistral-large-latest` | API Key |
| Groq | `groq` | `GROQ_API_KEY` | `llama-3.3-70b-versatile` | API Key |
| OpenCode Zen | `opencode` | `OPENCODE_API_KEY` | `claude-opus-4-6` | API Key |

---

## 🔧 通用配置命令

```bash
# 查看当前配置的模型
openclaw models list

# 查看模型状态（含认证信息）
openclaw models status

# 切换模型
openclaw models set <provider/model>

# 设置图片模型
openclaw models set-image <provider/model>

# 查看配置
openclaw config get agents.defaults.model

# 设置主模型
openclaw models set <provider/model> --set-default

# 重新认证
openclaw models auth login --provider <provider>

# 添加模型别名
openclaw models aliases add <alias> <provider/model>

# 添加 fallback 模型
openclaw models fallbacks add <provider/model>

# 扫描 OpenRouter 免费模型
openclaw models scan --provider openrouter
```

---

## 📋 配置示例：多模型 Fallback

```json5
{
  env: {
    ANTHROPIC_API_KEY: "sk-ant-...",
    OPENAI_API_KEY: "sk-...",
    GEMINI_API_KEY: "..."
  },
  agents: {
    defaults: {
      model: {
        primary: "anthropic/claude-opus-4-6",
        fallbacks: [
          "openai/gpt-5.1-codex",
          "google/gemini-3-pro-preview"
        ]
      },
      models: {
        "anthropic/claude-opus-4-6": { alias: "Opus" },
        "openai/gpt-5.1-codex": { alias: "Codex" },
        "google/gemini-3-pro-preview": { alias: "Gemini" }
      }
    }
  }
}
```

---

## 📋 配置示例：国内 + 国际混合

```json5
{
  env: {
    ZAI_API_KEY: "sk-...",           // 智谱 GLM
    MOONSHOT_API_KEY: "sk-...",      // Kimi
    ANTHROPIC_API_KEY: "sk-ant-..."  // Claude
  },
  agents: {
    defaults: {
      model: {
        primary: "anthropic/claude-opus-4-6",
        fallbacks: [
          "zai/glm-5",
          "moonshot/kimi-k2.5"
        ]
      }
    }
  }
}
```

---

## ⚠️ 注意事项

1. **API Key 安全**：不要将 API Key 提交到 Git 仓库
2. **模型别名**：模型引用格式为 `provider/model-id`
3. **热重载**：修改配置后 Gateway 会自动重载（部分设置需重启）
4. **Fallback 配置**：建议配置备用模型以防主模型不可用
5. **用量监控**：定期查看各平台的用量和余额
6. **Rate Limit**：注意各平台的请求频率限制
7. **区域限制**：部分国内厂商可能需要国内 IP 访问

---

## 📚 参考链接

- OpenClaw 官方文档：https://docs.openclaw.ai
- OpenClaw GitHub：https://github.com/openclaw/openclaw
- ClawHub 技能市场：https://clawhub.ai
- OpenClaw 模型提供商文档：https://docs.openclaw.ai/concepts/model-providers

---

## 📊 配置流程图

```
┌─────────────────┐
│  安装 OpenClaw  │
│  npm install -g │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  运行 onboarding│
│  openclaw onboard│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  选择认证方式   │
│  API Key / OAuth│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  配置模型       │
│  openclaw models│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  启动 Gateway   │
│  openclaw gateway│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  连接聊天频道   │
│  WhatsApp/Telegram│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  开始使用       │
│  发送消息测试   │
└─────────────────┘
```

---

## 📚 学习资源

### 官方文档
- [OpenClaw 快速开始](https://docs.openclaw.ai/start/getting-started)
- [配置指南](https://docs.openclaw.ai/gateway/configuration)
- [模型提供商](https://docs.openclaw.ai/concepts/model-providers)
- [CLI 参考](https://docs.openclaw.ai/cli/index)

### 社区
- [Discord 社区](https://discord.com/invite/clawd)
- [GitHub 仓库](https://github.com/openclaw/openclaw)
- [ClawHub 技能市场](https://clawhub.ai)

### 视频教程
- Bilibili：搜索 "OpenClaw 教程"
- YouTube：搜索 "OpenClaw setup"

---

## 💡 最佳实践

### 模型选择策略

| 使用场景 | 推荐模型 | 理由 |
|---------|---------|------|
| 代码生成 | `anthropic/claude-opus-4-6` 或 `openai/gpt-5.1-codex` | 最强代码能力 |
| 日常对话 | `anthropic/claude-sonnet-4-5` 或 `zai/glm-5` | 性价比高 |
| 快速响应 | `groq/llama-3.3-70b` 或 `google/gemini-flash` | 低延迟 |
| 长文档处理 | `moonshot/kimi-k2.5` 或 `minimax/MiniMax-M2.5` | 大上下文 |
| 多模态 | `google/gemini-3-pro` 或 `qwen-portal/vision-model` | 视觉能力强 |
| 低成本 | `huggingface/:cheapest` 或 `openrouter/:free` | 价格最优 |

### 成本控制

1. **设置用量告警**：在各平台设置月度预算
2. **使用 Fallback**：主模型失败时自动切换到便宜模型
3. **缓存常用回复**：减少重复调用
4. **选择合适模型**：简单任务用轻量模型

### 性能优化

1. **配置本地缓存**：减少网络请求
2. **使用 WebSocket**：降低延迟
3. **启用流式输出**：提升用户体验
4. **合理设置超时**：避免长时间等待

---

*文档生成时间：2026-03-12*
*适用于 OpenClaw 最新版本*
