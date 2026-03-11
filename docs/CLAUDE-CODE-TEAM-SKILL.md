# Team 技能 - Claude Code 团队协作能力

> 让 Claude Code 具备团队管理和协作能力

---

## 🎯 功能概述

Team 技能让 Claude Code 能够：

- 👥 **管理团队成员** - 添加/移除成员，分配角色
- 📋 **分配任务** - 创建任务，分配给团队成员
- 📊 **跟踪进度** - 查看任务状态，生成进度报告
- 💬 **协作沟通** - 团队消息通知，讨论记录
- 📁 **知识共享** - 团队文档，代码审查

---

## 📦 安装步骤

### 步骤 1：创建技能目录

```bash
mkdir -p ~/.claude/skills/team
```

### 步骤 2：创建技能配置文件

创建 `~/.claude/skills/team/skill.json`：

```json
{
  "name": "team",
  "version": "1.0.0",
  "description": "团队协作和管理技能",
  "author": "yansun1521-glitch",
  "capabilities": [
    "member_management",
    "task_assignment",
    "progress_tracking",
    "team_communication",
    "code_review"
  ],
  "commands": [
    "team members",
    "team add",
    "team remove",
    "team task",
    "team status",
    "team report"
  ]
}
```

### 步骤 3：创建团队数据存储

创建 `~/.claude/skills/team/data/team.json`：

```json
{
  "members": [],
  "tasks": [],
  "roles": {
    "admin": [],
    "developer": [],
    "reviewer": []
  }
}
```

---

## 🛠️ 使用方法

### 成员管理

#### 查看团队成员

```
/team members
```

**输出示例**：
```
团队成员 (3):
- 张三 (admin) - zhangsan@example.com
- 李四 (developer) - lisi@example.com
- 王五 (reviewer) - wangwu@example.com
```

#### 添加成员

```
/team add 张三 zhangsan@example.com developer
```

**参数**：
- 姓名
- 邮箱
- 角色（admin/developer/reviewer）

#### 移除成员

```
/team remove 张三
```

### 任务管理

#### 创建任务

```
/team task create "实现用户登录功能" --assignee 张三 --priority high --due 2026-03-15
```

**参数**：
- 任务描述
- `--assignee` - 负责人
- `--priority` - 优先级（high/medium/low）
- `--due` - 截止日期

#### 查看任务

```
/team task list
/team task list --status pending
/team task list --assignee 张三
```

#### 更新任务状态

```
/team task update 1 --status in_progress
/team task update 1 --status done
```

**状态**：
- `pending` - 待处理
- `in_progress` - 进行中
- `review` - 审查中
- `done` - 已完成

### 进度跟踪

#### 查看团队状态

```
/team status
```

**输出示例**：
```
团队状态 - 2026-03-12

成员：3
任务总数：10
  - 待处理：3
  - 进行中：4
  - 审查中：1
  - 已完成：2

本周完成：5 任务
延期：1 任务
```

#### 生成报告

```
/team report --weekly
/team report --monthly
```

### 代码审查

#### 发起审查

```
/team review create "用户认证模块" --reviewer 王五 --files src/auth.py,src/login.py
```

#### 查看审查

```
/team review list
/team review 1
```

#### 提交审查意见

```
/team review comment 1 "代码整体不错，建议添加异常处理"
```

---

## 📊 数据结构

### 团队成员

```json
{
  "id": "1",
  "name": "张三",
  "email": "zhangsan@example.com",
  "role": "developer",
  "joinedAt": "2026-03-12",
  "active": true,
  "skills": ["Python", "JavaScript"],
  "load": 3  // 当前任务数
}
```

### 任务

```json
{
  "id": "1",
  "title": "实现用户登录功能",
  "description": "使用 OAuth 2.0 实现用户登录",
  "assignee": "张三",
  "creator": "李四",
  "priority": "high",
  "status": "in_progress",
  "createdAt": "2026-03-10",
  "dueDate": "2026-03-15",
  "completedAt": null,
  "tags": ["backend", "auth"],
  "files": ["src/auth.py"],
  "comments": []
}
```

### 审查

```json
{
  "id": "1",
  "title": "用户认证模块",
  "author": "张三",
  "reviewer": "王五",
  "status": "pending",
  "files": ["src/auth.py", "src/login.py"],
  "comments": [
    {
      "author": "王五",
      "comment": "代码整体不错",
      "timestamp": "2026-03-12T10:00:00Z"
    }
  ],
  "createdAt": "2026-03-11"
}
```

---

## 🔧 高级功能

### 自动化工作流

#### CI/CD 集成

```yaml
# .github/workflows/team-review.yml
on:
  pull_request:
    types: [opened]

jobs:
  assign-reviewer:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/github-script@v6
        with:
          script: |
            # 自动分配审查员
            const reviewer = await getAvailableReviewer();
            await assignReviewer(reviewer);
```

### 通知集成

#### 飞书通知

```python
# skills/team/notifications/feishu.py
def notify_task_assigned(member, task):
    """任务分配通知"""
    message = {
        "msg_type": "interactive",
        "card": {
            "header": {
                "title": {
                    "tag": "plain_text",
                    "content": "新任务分配"
                }
            },
            "elements": [
                {
                    "tag": "div",
                    "text": {
                        "tag": "lark_md",
                        "content": f"**任务**: {task['title']}\n**优先级**: {task['priority']}\n**截止**: {task['dueDate']}"
                    }
                }
            ]
        }
    }
    send_to_feishu(member['email'], message)
```

#### 邮件通知

```python
# skills/team/notifications/email.py
def send_email_notification(member, subject, body):
    """发送邮件通知"""
    import smtplib
    from email.mime.text import MIMEText
    
    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = 'team@example.com'
    msg['To'] = member['email']
    
    # 发送邮件
    with smtplib.SMTP('smtp.example.com') as server:
        server.send_message(msg)
```

---

## 📋 最佳实践

### 1. 定期同步

```bash
# 每日站会
/team status --daily

# 每周报告
/team report --weekly
```

### 2. 合理分配

- 检查成员负载：`/team members --load`
- 避免过度分配
- 考虑技能匹配

### 3. 及时更新

- 任务状态变化立即更新
- 完成后标记为 done
- 遇到问题及时沟通

### 4. 代码审查

- 每个 PR 至少一个审查员
- 24 小时内完成审查
- 建设性反馈

---

## 🔐 权限管理

### 角色权限

| 权限 | admin | developer | reviewer |
|------|-------|-----------|----------|
| 添加成员 | ✅ | ❌ | ❌ |
| 移除成员 | ✅ | ❌ | ❌ |
| 创建任务 | ✅ | ✅ | ✅ |
| 分配任务 | ✅ | ❌ | ❌ |
| 审查代码 | ✅ | ✅ | ✅ |
| 合并代码 | ✅ | ❌ | ✅ |
| 查看报告 | ✅ | ✅ | ✅ |

### 权限检查

```python
def check_permission(user, action):
    """检查用户权限"""
    role = get_user_role(user)
    permissions = {
        'admin': ['all'],
        'developer': ['create_task', 'review_code'],
        'reviewer': ['create_task', 'review_code', 'merge_code']
    }
    
    if role == 'admin':
        return True
    
    return action in permissions[role]
```

---

## 📈 指标和报告

### 团队效率指标

```json
{
  "velocity": {
    "current_week": 15,
    "last_week": 12,
    "trend": "+25%"
  },
  "quality": {
    "bugs_this_week": 2,
    "code_review_time": "4.5h",
    "merge_success_rate": "98%"
  },
  "load": {
    "average_tasks_per_member": 3.5,
    "overloaded_members": 1,
    "available_members": 2
  }
}
```

### 报告模板

```markdown
# 团队周报 - {week}

## 完成情况
- 完成任务：{completed_tasks}
- 进行中：{in_progress_tasks}
- 延期：{overdue_tasks}

## 成员表现
{member_performance}

## 问题和建议
{issues_and_suggestions}

## 下周计划
{next_week_plan}
```

---

## 🎓 示例场景

### 场景 1：新成员入职

```bash
# 1. 添加成员
/team add 赵六 zhaoliu@example.com developer

# 2. 分配导师
/team task create "指导赵六熟悉项目" --assignee 张三

# 3. 分配入门任务
/team task create "修复文档 typo" --assignee 赵六 --priority low
```

### 场景 2：冲刺规划

```bash
# 1. 创建冲刺任务
/team task create "实现支付功能" --assignee 张三 --due 2026-03-20
/team task create "编写单元测试" --assignee 李四 --due 2026-03-18

# 2. 查看冲刺状态
/team status --sprint

# 3. 每日检查
/team status --daily
```

### 场景 3：代码审查流程

```bash
# 1. 发起审查
/team review create "支付模块" --reviewer 王五 --files src/payment.py

# 2. 审查员查看
/team review 1

# 3. 提交意见
/team review comment 1 "逻辑正确，建议添加日志"

# 4. 作者修复后
/team review update 1 --status done
```

---

## 🔗 集成扩展

### GitHub 集成

```yaml
# .github/actions/team-sync/action.yml
name: 'Team Sync'
description: '同步 GitHub 和 Team 技能'
runs:
  using: 'node20'
  main: 'dist/index.js'
```

### Jira 集成

```python
# 同步 Jira 任务到 Team 技能
def sync_jira_tasks():
    jira_tasks = jira.search_issues('assignee = currentUser()')
    for issue in jira_tasks:
        create_team_task({
            'title': issue.fields.summary,
            'assignee': issue.fields.assignee.displayName,
            'due': issue.fields.duedate
        })
```

---

## 📚 相关资源

- [Claude Code 技能开发文档](https://docs.anthropic.com/claude-code/skills)
- [团队协作最佳实践](https://www.atlassian.com/agile/team-management)
- [代码审查指南](https://google.github.io/eng-practices/review/)

---

*版本：1.0.0*
*作者：yansun1521-glitch*
*创建时间：2026-03-12*
