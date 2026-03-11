# OpenClaw 安装知识库（结构化版）

> 结构化数据格式，方便 AI 工具快速读取和学习

---

## 📊 系统要求

```json
{
  "os": {
    "supported": ["macOS", "Linux", "WSL2"],
    "minimum": {
      "macOS": "10.15",
      "Linux": "Ubuntu 20.04",
      "WSL2": "Windows 11"
    },
    "recommended": {
      "macOS": "12+",
      "Linux": "Ubuntu 22.04",
      "WSL2": "Ubuntu 22.04"
    }
  },
  "dependencies": {
    "nodejs": {
      "required": true,
      "minimum_version": 18,
      "recommended_version": 20,
      "check_command": "node -v"
    },
    "npm": {
      "required": true,
      "minimum_version": 8,
      "check_command": "npm -v"
    },
    "git": {
      "required": false,
      "recommended": true,
      "check_command": "git --version"
    }
  },
  "disk_space": {
    "minimum_gb": 1,
    "recommended_gb": 5
  }
}
```

---

## 🛠️ 安装命令库

### Node.js 安装

```json
{
  "nodejs_installation": {
    "macOS": {
      "homebrew": {
        "command": "brew install node@20",
        "prerequisite": "brew --version",
        "install_homebrew": "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
      },
      "website": {
        "url": "https://nodejs.org/",
        "file_type": "pkg"
      }
    },
    "linux": {
      "nodesource": {
        "command": "curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs",
        "verification": "node -v && npm -v"
      }
    },
    "wsl2": {
      "command": "curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs",
      "note": "在 WSL2 终端中执行"
    }
  }
}
```

### OpenClaw 安装

```json
{
  "openclaw_installation": {
    "one_click": {
      "description": "一键安装脚本（推荐新手）",
      "commands": [
        "curl -fsSL https://raw.githubusercontent.com/your-username/your-repo/main/scripts/install-openclaw.sh -o install-openclaw.sh",
        "chmod +x install-openclaw.sh",
        "./install-openclaw.sh"
      ],
      "features": [
        "自动检测依赖",
        "自动选择镜像源",
        "错误处理",
        "进度提示"
      ]
    },
    "manual": {
      "description": "手动安装（适合有经验用户）",
      "steps": [
        {
          "step": 1,
          "name": "配置镜像",
          "command": "npm config set registry https://registry.npmmirror.com",
          "region": "中国大陆"
        },
        {
          "step": 2,
          "name": "安装",
          "command": "npm install -g openclaw@latest"
        },
        {
          "step": 3,
          "name": "验证",
          "command": "openclaw --version"
        }
      ]
    },
    "homebrew": {
      "description": "Homebrew 安装（仅 macOS）",
      "commands": [
        "brew tap openclaw/openclaw",
        "brew install openclaw"
      ],
      "platform": "macOS"
    }
  }
}
```

---

## 🎯 模型配置

### 推荐模型（按地区）

```json
{
  "model_recommendations": {
    "china": {
      "primary": {
        "provider": "智谱 AI",
        "model": "zai/glm-5",
        "env_var": "ZAI_API_KEY",
        "website": "https://open.bigmodel.cn/",
        "reason": "访问快、价格低、中文好"
      },
      "alternatives": [
        {
          "provider": "月之暗面",
          "model": "moonshot/kimi-k2.5",
          "env_var": "MOONSHOT_API_KEY",
          "website": "https://platform.moonshot.cn/",
          "reason": "长文本处理强"
        },
        {
          "provider": "MiniMax",
          "model": "minimax/MiniMax-M2.5",
          "env_var": "MINIMAX_API_KEY",
          "website": "https://platform.minimax.io/",
          "reason": "代码能力强"
        }
      ]
    },
    "international": {
      "primary": {
        "provider": "OpenAI",
        "model": "openai/gpt-5.1-codex",
        "env_var": "OPENAI_API_KEY",
        "website": "https://platform.openai.com/",
        "reason": "最强综合能力"
      },
      "alternatives": [
        {
          "provider": "Anthropic",
          "model": "anthropic/claude-opus-4-6",
          "env_var": "ANTHROPIC_API_KEY",
          "website": "https://console.anthropic.com/",
          "reason": "代码和写作优秀"
        },
        {
          "provider": "Google",
          "model": "google/gemini-3-pro-preview",
          "env_var": "GEMINI_API_KEY",
          "website": "https://aistudio.google.com/",
          "reason": "多模态能力强"
        }
      ]
    }
  }
}
```

### 配置命令

```json
{
  "configuration_commands": {
    "onboarding": "openclaw onboard",
    "set_model": "openclaw models set <provider/model>",
    "list_models": "openclaw models list",
    "check_status": "openclaw models status",
    "configure": "openclaw configure"
  }
}
```

---

## ▶️ 启动命令

```json
{
  "startup_commands": {
    "foreground": {
      "command": "openclaw gateway --port 18789",
      "description": "前台运行（推荐新手）",
      "stop": "Ctrl+C"
    },
    "background": {
      "commands": [
        "openclaw gateway install",
        "openclaw gateway start"
      ],
      "description": "后台运行（推荐老手）",
      "check_status": "openclaw gateway status",
      "stop": "openclaw gateway stop"
    },
    "control_ui": {
      "url": "http://127.0.0.1:18789",
      "description": "浏览器访问控制界面"
    }
  }
}
```

---

## ✅ 验证步骤

```json
{
  "verification_steps": [
    {
      "step": 1,
      "name": "检查 Gateway 状态",
      "command": "openclaw gateway status",
      "expected": "running"
    },
    {
      "step": 2,
      "name": "CLI 测试",
      "command": "openclaw agent \"你好，请介绍一下自己\"",
      "expected": "收到 AI 回复"
    },
    {
      "step": 3,
      "name": "控制界面",
      "action": "浏览器访问 http://127.0.0.1:18789",
      "expected": "能看到控制界面"
    },
    {
      "step": 4,
      "name": "聊天工具测试",
      "action": "在 WhatsApp/Telegram 发送消息",
      "expected": "收到 AI 回复"
    }
  ]
}
```

---

## 🐛 故障排查

```json
{
  "troubleshooting": {
    "npm_slow": {
      "symptom": "npm install 卡住或超时",
      "diagnosis": "npm config get registry",
      "solution": [
        "npm config set registry https://registry.npmmirror.com",
        "npm install -g openclaw@latest"
      ]
    },
    "permission_denied": {
      "symptom": "Error: EACCES: permission denied",
      "solution": [
        "sudo npm install -g openclaw@latest"
      ],
      "alternative": [
        "mkdir ~/.npm-global",
        "npm config set prefix '~/.npm-global'",
        "echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc",
        "source ~/.bashrc"
      ]
    },
    "command_not_found": {
      "symptom": "command not found: openclaw",
      "diagnosis": "npm config get prefix",
      "solution": [
        "export PATH=$(npm config get prefix)/bin:$PATH",
        "echo 'export PATH=$(npm config get prefix)/bin:$PATH' >> ~/.bashrc",
        "source ~/.bashrc"
      ]
    },
    "gateway_failed": {
      "symptom": "Gateway 启动失败",
      "diagnosis": [
        "lsof -i :18789",
        "openclaw logs"
      ],
      "solution": [
        "openclaw gateway --port 18790",
        "kill -9 $(lsof -t -i :18789)"
      ]
    },
    "auth_failed": {
      "symptom": "API Key 认证失败",
      "diagnosis": "openclaw models status",
      "solution": [
        "检查 API Key 是否正确（无空格）",
        "重新运行 openclaw onboard",
        "检查 API Key 是否有余额"
      ]
    }
  }
}
```

---

## 💬 交互流程

```json
{
  "interaction_flow": {
    "greeting": "你好！我是 OpenClaw 安装助手 🦞\n\nOpenClaw 是一个 AI 代理网关，可以让你在微信、Telegram、Discord 等聊天工具中使用 AI。\n\n安装大约需要 5-10 分钟，我会一步步引导你。\n\n准备好了吗？（是/否）",
    "steps": [
      {
        "id": 1,
        "name": "系统检测",
        "instruction": "请在终端运行：uname -a\n\n然后把输出结果发给我。",
        "success": "✅ 检测到 {os} 系统",
        "next": "依赖检查"
      },
      {
        "id": 2,
        "name": "依赖检查",
        "instruction": "请运行：node -v && npm -v",
        "success": "✅ Node.js {version} 已安装",
        "next": "安装 OpenClaw"
      },
      {
        "id": 3,
        "name": "安装 OpenClaw",
        "instruction": "请运行：npm install -g openclaw@latest",
        "success": "✅ OpenClaw 安装成功",
        "next": "配置模型"
      },
      {
        "id": 4,
        "name": "配置模型",
        "instruction": "请运行：openclaw onboard",
        "success": "✅ 模型配置完成",
        "next": "启动服务"
      },
      {
        "id": 5,
        "name": "启动服务",
        "instruction": "请运行：openclaw gateway --port 18789",
        "success": "✅ Gateway 已启动",
        "next": "功能验证"
      },
      {
        "id": 6,
        "name": "功能验证",
        "instruction": "请运行：openclaw agent \"你好\"",
        "success": "✅ 测试成功",
        "next": "完成"
      }
    ],
    "completion": "🎉 恭喜！OpenClaw 安装完成！\n\n你现在可以：\n- 在聊天工具中和 AI 对话\n- 使用各种技能扩展功能\n- 配置自动化任务\n\n有任何问题随时问我！"
  }
}
```

---

## 📚 文档索引

```json
{
  "documentation": {
    "main": {
      "title": "工作区首页",
      "file": "README.md",
      "audience": "所有用户"
    },
    "installation": {
      "title": "安装指南",
      "file": "INSTALL-GUIDE.md",
      "audience": "新手"
    },
    "step_by_step": {
      "title": "分步教程",
      "file": "STEP-BY-STEP-INSTALL.md",
      "audience": "零基础新手"
    },
    "models": {
      "title": "模型配置指南",
      "file": "openclaw-china-models-config.md",
      "audience": "所有用户"
    },
    "ai_protocol": {
      "title": "AI 助手协议",
      "file": "AI-INSTALL-PROTOCOL.md",
      "audience": "AI 编程助手"
    },
    "index": {
      "title": "文档索引",
      "file": "docs/README.md",
      "audience": "所有用户"
    }
  }
}
```

---

*版本：1.0*
*格式：Markdown + JSON 结构化数据*
*适用于：AI 编程助手快速读取*
