#!/bin/bash

################################################################################
# Claude Code Team Skill 安装脚本
################################################################################

set -e

echo "🦞 安装 Claude Code Team Skill..."
echo ""

# 创建目录结构
echo "📁 创建目录结构..."
mkdir -p ~/.claude/skills/team/{data,commands,notifications}

# 复制技能文件（如果是从其他位置运行）
if [ -f "$(dirname "$0")/team_skill.py" ]; then
    echo "📄 复制技能文件..."
    cp "$(dirname "$0")/team_skill.py" ~/.claude/skills/team/commands/
    cp "$(dirname "$0")/skill.json" ~/.claude/skills/team/
    cp "$(dirname "$0")/team.json" ~/.claude/skills/team/data/ 2>/dev/null || true
fi

# 设置权限
chmod +x ~/.claude/skills/team/commands/*.py 2>/dev/null || true

# 验证安装
echo ""
echo "✅ 验证安装..."
if [ -f ~/.claude/skills/team/skill.json ]; then
    echo "✅ skill.json 已创建"
else
    echo "❌ skill.json 创建失败"
    exit 1
fi

if [ -f ~/.claude/skills/team/data/team.json ]; then
    echo "✅ team.json 已创建"
else
    echo "❌ team.json 创建失败"
    exit 1
fi

# 完成
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║         🎉 Team Skill 安装完成！ 🎉                       ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "📚 使用方法："
echo ""
echo "  在 Claude Code 中使用："
echo "  /team members          - 查看团队成员"
echo "  /team add 姓名 邮箱 角色  - 添加成员"
echo "  /team task create ...  - 创建任务"
echo "  /team status           - 查看状态"
echo "  /team report           - 生成报告"
echo ""
echo "📖 完整文档："
echo "  https://github.com/yansun1521-glitch/openclaw-install-guide/blob/main/docs/CLAUDE-CODE-TEAM-SKILL.md"
echo ""
