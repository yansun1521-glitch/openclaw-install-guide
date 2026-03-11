# 🧠 MEMORY.md - 长期记忆

> 重要的经验、教训、决策和知识 - 永久保存

---

## 📅 2026-03-12

### 🔐 安全教训：永远不要公开敏感凭证

**事件级别**：⚠️ 中等（已及时处理）

**问题**：在创建飞书配置指南文档时，不小心将真实的飞书凭证放入公开文档：
- 飞书 App ID
- 飞书 App Secret

**处理**：
1. ✅ 立即强制删除包含敏感信息的 Git 提交
2. ✅ 重新创建安全版本文档（使用占位符）
3. ✅ 添加安全警告和最佳实践说明
4. ✅ 记录教训到记忆

**核心原则**：

```
❌ 永远不要硬编码凭证
✅ 始终使用环境变量
✅ 始终使用占位符写文档
✅ 始终检查后再提交
```

**正确做法**：

```json5
// 使用环境变量
{
  "env": {
    "FEISHU_APP_ID": "${FEISHU_APP_ID}",
    "FEISHU_APP_SECRET": "${FEISHU_APP_SECRET}"
  }
}

// 文档中使用占位符
App ID: 你的 APP_ID
App ID: cli_xxxxxxxxxxxx
```

**检查清单**（发布前必查）：

- [ ] 是否包含真实的 API Key？
- [ ] 是否包含真实的 App Secret？
- [ ] 是否包含真实的 Token？
- [ ] 是否包含真实的密码？
- [ ] 是否包含真实的数据库连接字符串？
- [ ] 配置文件是否已添加到 .gitignore？

**相关文件**：
- `memory/security-lesson-2026-03-12.md` - 详细事件记录
- `docs/FEISHU-LONG-CONNECTION-GUIDE.md` - 安全版本的文档

---

## 📚 持久化知识

### 凭证管理最佳实践

1. **环境变量**
   - 使用 `.env` 文件管理敏感信息
   - 在配置中引用：`${VAR_NAME}`
   - `.env` 添加到 `.gitignore`

2. **配置模板**
   - 创建 `.example` 或 `.template` 文件
   - 使用占位符：`你的 XXX`、`xxx`
   - 提供清晰的说明

3. **文件权限**
   ```bash
   chmod 600 ~/.openclaw/openclaw.json
   chmod 600 ~/.openclaw/.env
   ```

4. **定期轮换**
   - 每 3-6 个月更换凭证
   - 发现泄露立即更换

### 文档安全规范

1. **使用占位符**
   - `你的 APP_ID`
   - `cli_xxxxxxxxxxxx`
   - `sk-xxx`

2. **添加安全警告**
   ```markdown
   > ⚠️ **安全提示**：不要将真实凭证提交到 Git
   ```

3. **提供示例而非真实值**
   - 示例：`"appId": "cli_xxxxxxxxxxxx"`
   - 而非：`"appId": "cli_a920378d2cf9dbca"`

### Git 安全检查

```bash
# 提交前检查
git diff --cached | grep -i "secret\|api_key\|password"

# 扫描历史
gitleaks detect --source . --verbose

# 检查敏感文件
grep -r "sk-" .
grep -r "cli_" .
grep -r "app_secret" .
```

---

## 🎯 重要决策

### 文档发布原则

**决定**：所有公开文档不得包含真实凭证

**原因**：
- 保护用户安全
- 避免凭证泄露
- 建立信任

**执行**：
- 文档审查流程
- 自动化检查工具
- 持续教育和提醒

---

## 💡 关键洞察

1. **安全无小事** - 一次疏忽可能导致严重后果
2. **快速响应** - 发现问题立即处理
3. **记录教训** - 避免重复犯错
4. **预防优于补救** - 建立检查流程

---

*最后更新：2026-03-12*
*记忆版本：1.0*
*状态：✅ 活跃*
