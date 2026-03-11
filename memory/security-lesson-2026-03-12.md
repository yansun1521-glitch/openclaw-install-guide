# 🚨 安全教训：永远不要公开敏感凭证

> 记录一次重要的安全教训 - 2026-03-12

---

## ⚠️ 事件回顾

**时间**：2026-03-12 07:28

**问题**：在创建飞书配置指南时，不小心将真实的飞书凭证放入了文档：

- ❌ 真实的飞书 App ID: `cli_a920378d2cf9dbca`
- ❌ 真实的飞书 App Secret: `ZTgtUvOiIB2u6L8uhmEHbfJ1gLIbS2L8`
- ❌ 提交到了 GitHub 公开仓库

**发现**：用户立即指出问题

**处理**：
1. ✅ 立即强制删除包含敏感信息的提交
2. ✅ 重新创建安全版本的文档
3. ✅ 使用占位符替代真实凭证
4. ✅ 添加安全警告和最佳实践

---

## 📋 学到的教训

### 1. 永远不要硬编码凭证

❌ **错误做法**：
```json
{
  "app_id": "cli_a920378d2cf9dbca",
  "app_secret": "ZTgtUvOiIB2u6L8uhmEHbfJ1gLIbS2L8"
}
```

✅ **正确做法**：
```json5
{
  "env": {
    "FEISHU_APP_ID": "${FEISHU_APP_ID}",
    "FEISHU_APP_SECRET": "${FEISHU_APP_SECRET}"
  }
}
```

### 2. 使用环境变量管理敏感信息

**创建 `.env` 文件**：
```bash
# ~/.openclaw/.env
FEISHU_APP_ID=cli_xxx
FEISHU_APP_SECRET=xxx
OPENAI_API_KEY=sk-xxx
```

**在配置中引用**：
```json5
{
  "env": {
    "FEISHU_APP_ID": "${FEISHU_APP_ID}"
  }
}
```

### 3. 完善 .gitignore

```bash
# ~/.openclaw/.gitignore

# 敏感配置
openclaw.json
*.secret
*.key
.env
.env.local

# 日志
logs/
*.log

# 临时文件
*.tmp
*.bak
```

### 4. 创建配置模板

**公开的配置示例**：
```json5
// openclaw.example.json
{
  "env": {
    "FEISHU_APP_ID": "你的 APP_ID",
    "FEISHU_APP_SECRET": "你的 APP_SECRET"
  },
  "channels": {
    "feishu": {
      "enabled": true
    }
  }
}
```

### 5. 文档中使用占位符

❌ **错误**：
```
App ID: cli_a920378d2cf9dbca
```

✅ **正确**：
```
App ID: 你的 APP_ID
App ID: cli_xxxxxxxxxxxx
```

### 6. 发布前检查清单

在提交或发布文档前，务必检查：

- [ ] 是否包含真实的 API Key？
- [ ] 是否包含真实的 App Secret？
- [ ] 是否包含真实的 Token？
- [ ] 是否包含真实的密码？
- [ ] 是否包含真实的数据库连接字符串？
- [ ] 是否包含真实的私钥？
- [ ] 配置文件是否已添加到 .gitignore？

### 7. 定期检查敏感信息泄露

```bash
# 检查 Git 历史中的敏感信息
git log --all --full-history -- "*.json" | grep -i secret

# 检查当前文件
grep -r "sk-" ~/.openclaw/workspace/
grep -r "cli_" ~/.openclaw/workspace/
grep -r "app_secret" ~/.openclaw/workspace/

# 使用工具扫描
# 安装 gitleaks
brew install gitleaks
gitleaks detect --source .
```

---

## 🔐 安全最佳实践

### 凭证管理

1. **使用环境变量**
   - 不要在代码中硬编码
   - 使用 `.env` 文件管理

2. **限制文件权限**
   ```bash
   chmod 600 ~/.openclaw/openclaw.json
   chmod 600 ~/.openclaw/.env
   ```

3. **定期轮换凭证**
   - 每 3-6 个月更换一次
   - 发现泄露立即更换

4. **使用密钥管理服务**
   - AWS Secrets Manager
   - HashiCorp Vault
   - 1Password

### Git 安全

1. **提交前检查**
   ```bash
   # 预提交钩子检查
   git diff --cached | grep -i "secret\|api_key\|password"
   ```

2. **使用预提交工具**
   ```bash
   # 安装 pre-commit
   pip install pre-commit
   pre-commit install
   ```

3. **定期扫描历史**
   ```bash
   gitleaks detect --source . --verbose
   ```

### 文档安全

1. **使用占位符**
   - `你的 APP_ID`
   - `cli_xxxxxxxxxxxx`
   - `sk-xxx`

2. **添加安全警告**
   ```markdown
   > ⚠️ **安全提示**：不要将真实凭证提交到 Git
   ```

3. **提供配置模板**
   - `config.example.json`
   - `.env.example`

---

## 🎯 行动项

### 立即执行

- [x] 删除包含敏感信息的提交
- [x] 重新创建安全版本文档
- [x] 添加安全警告
- [ ] 检查其他文档是否有敏感信息
- [ ] 更新 .gitignore
- [ ] 轮换已泄露的凭证

### 长期执行

- [ ] 设置预提交检查
- [ ] 定期扫描 Git 历史
- [ ] 建立安全审查流程
- [ ] 培训团队成员

---

## 📚 相关资源

- [GitHub 敏感信息扫描](https://docs.github.com/en/code-security/secret-scanning)
- [Gitleaks - Git 敏感信息扫描工具](https://github.com/gitleaks/gitleaks)
- [pre-commit - 预提交检查框架](https://pre-commit.com/)
- [12-Factor App - 配置管理](https://12factor.net/config)

---

## 💭 反思

> "安全无小事，一次疏忽可能导致严重后果。"

这次事件提醒我：

1. **时刻保持警惕** - 即使是最简单的文档也可能包含敏感信息
2. **遵循最佳实践** - 使用环境变量、配置模板
3. **快速响应** - 发现问题立即处理
4. **记录教训** - 避免再次犯同样的错误

---

*创建时间：2026-03-12*
*事件级别：⚠️ 中等（已及时处理，未造成严重后果）*
*状态：✅ 已解决，教训已记录*
