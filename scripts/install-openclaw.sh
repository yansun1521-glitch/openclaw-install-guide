#!/bin/bash

################################################################################
# OpenClaw 一键安装脚本
# 适用于中国大陆用户的新手友好型安装程序
# 
# 使用方法:
#   curl -fsSL https://raw.githubusercontent.com/your-username/your-repo/main/scripts/install-openclaw.sh | bash
#
# 或下载后执行:
#   chmod +x install-openclaw.sh
#   ./install-openclaw.sh
################################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

# 打印横幅
print_banner() {
    echo ""
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║              🦞 OpenClaw 一键安装程序 🦞                  ║"
    echo "║                                                           ║"
    echo "║     任何操作系统的 AI 代理网关 - 连接微信/Telegram/Discord   ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
}

# 检查系统要求
check_requirements() {
    log_step "检查系统要求..."
    
    # 检查操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
        log_info "检测到 macOS 系统"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
        log_info "检测到 Linux 系统"
    else
        log_error "不支持的操作系统：$OSTYPE"
        exit 1
    fi
    
    # 检查 Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v)
        log_info "已安装 Node.js: $NODE_VERSION"
        
        # 检查版本是否 >= 18
        NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
        if [ $NODE_MAJOR -lt 18 ]; then
            log_warning "Node.js 版本过低，需要 18+ (推荐 20+)"
            NEED_NODE=true
        else
            NEED_NODE=false
        fi
    else
        log_warning "未检测到 Node.js"
        NEED_NODE=true
    fi
    
    # 检查 npm
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm -v)
        log_info "已安装 npm: $NPM_VERSION"
    else
        log_warning "未检测到 npm"
        NEED_NODE=true
    fi
    
    # 检查 git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git -v | head -n1 | cut -d' ' -f3)
        log_info "已安装 git: $GIT_VERSION"
    else
        log_warning "未检测到 git"
        NEED_GIT=true
    fi
    
    echo ""
}

# 安装 Node.js
install_node() {
    if [[ "$NEED_NODE" != "true" ]]; then
        return
    fi
    
    log_step "安装 Node.js (LTS 版本)..."
    
    if [[ "$OS" == "macOS" ]]; then
        if command -v brew &> /dev/null; then
            log_info "使用 Homebrew 安装 Node.js..."
            brew install node@20
        else
            log_error "请先安装 Homebrew: https://brew.sh/"
            exit 1
        fi
    elif [[ "$OS" == "Linux" ]]; then
        # 使用 NodeSource
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
    
    log_success "Node.js 安装完成"
    echo ""
}

# 安装 git
install_git() {
    if [[ "$NEED_GIT" != "true" ]]; then
        return
    fi
    
    log_step "安装 git..."
    
    if [[ "$OS" == "macOS" ]]; then
        xcode-select --install 2>/dev/null || true
    elif [[ "$OS" == "Linux" ]]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    
    log_success "git 安装完成"
    echo ""
}

# 安装 OpenClaw
install_openclaw() {
    log_step "安装 OpenClaw..."
    
    # 使用国内镜像加速（如果在中国大陆）
    if command -v curl &> /dev/null; then
        # 测试网络连接
        if curl -s --connect-timeout 5 https://www.google.com > /dev/null 2>&1; then
            log_info "使用官方 npm 源"
        else
            log_info "检测到中国大陆网络，使用淘宝镜像源..."
            npm config set registry https://registry.npmmirror.com
        fi
    fi
    
    # 全局安装 OpenClaw
    npm install -g openclaw@latest
    
    if [ $? -eq 0 ]; then
        log_success "OpenClaw 安装成功"
        OPENCLAW_VERSION=$(openclaw --version 2>/dev/null || echo "未知")
        log_info "版本：$OPENCLAW_VERSION"
    else
        log_error "OpenClaw 安装失败"
        exit 1
    fi
    
    echo ""
}

# 运行引导向导
run_onboarding() {
    log_step "运行配置向导..."
    echo ""
    echo -e "${YELLOW}提示:${NC}"
    echo "  - 按照提示选择模型提供商"
    echo "  - 准备对应的 API Key"
    echo "  - 选择是否安装为系统服务"
    echo ""
    echo -e "${CYAN}即将启动 openclaw onboard...${NC}"
    echo ""
    
    # 询问是否立即运行 onboarding
    read -p "是否现在运行配置向导？[Y/n] " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        openclaw onboard
    else
        log_info "稍后可以手动运行：openclaw onboard"
    fi
    
    echo ""
}

# 创建快捷启动脚本
create_startup_script() {
    log_step "创建快捷启动脚本..."
    
    WORKSPACE_DIR="$HOME/.openclaw/workspace"
    SCRIPTS_DIR="$WORKSPACE_DIR/scripts"
    
    # 创建 scripts 目录
    mkdir -p "$SCRIPTS_DIR"
    
    # 创建启动脚本
    cat > "$SCRIPTS_DIR/start-openclaw.sh" << 'EOF'
#!/bin/bash
# OpenClaw 启动脚本

echo "🦞 启动 OpenClaw Gateway..."

# 检查是否已运行
if pgrep -f "openclaw gateway" > /dev/null; then
    echo "⚠️  Gateway 已经在运行中"
    openclaw gateway status
else
    echo "🚀 启动 Gateway..."
    openclaw gateway --port 18789
fi
EOF
    
    chmod +x "$SCRIPTS_DIR/start-openclaw.sh"
    
    # 创建停止脚本
    cat > "$SCRIPTS_DIR/stop-openclaw.sh" << 'EOF'
#!/bin/bash
# OpenClaw 停止脚本

echo "🦞 停止 OpenClaw Gateway..."
openclaw gateway stop
echo "✅ 已停止"
EOF
    
    chmod +x "$SCRIPTS_DIR/stop-openclaw.sh"
    
    log_success "启动脚本已创建"
    log_info "位置：$SCRIPTS_DIR/start-openclaw.sh"
    echo ""
}

# 显示安装后说明
show_post_install() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                           ║${NC}"
    echo -e "${GREEN}║              🎉 OpenClaw 安装完成！ 🎉                    ║${NC}"
    echo -e "${GREEN}║                                                           ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${CYAN}📚 下一步操作:${NC}"
    echo ""
    echo "  1️⃣  配置模型提供商"
    echo "     openclaw onboard"
    echo ""
    echo "  2️⃣  启动 Gateway"
    echo "     openclaw gateway --port 18789"
    echo "     或使用脚本：$HOME/.openclaw/workspace/scripts/start-openclaw.sh"
    echo ""
    echo "  3️⃣  连接聊天频道"
    echo "     openclaw channels login"
    echo ""
    echo "  4️⃣  打开控制界面"
    echo "     浏览器访问：http://127.0.0.1:18789"
    echo ""
    echo "  5️⃣  查看文档"
    echo "     https://docs.openclaw.ai"
    echo "     或查看本地文档：$HOME/.openclaw/workspace/docs/"
    echo ""
    
    echo -e "${YELLOW}📝 常用命令:${NC}"
    echo ""
    echo "  openclaw --help          # 查看所有命令"
    echo "  openclaw status          # 查看状态"
    echo "  openclaw models list     # 查看可用模型"
    echo "  openclaw models set      # 切换模型"
    echo "  openclaw doctor          # 诊断问题"
    echo "  openclaw logs            # 查看日志"
    echo ""
    
    echo -e "${CYAN}💡 提示:${NC}"
    echo ""
    echo "  - 配置保存在：~/.openclaw/openclaw.json"
    echo "  - 工作区目录：~/.openclaw/workspace"
    echo "  - 日志目录：~/.openclaw/logs"
    echo ""
}

# 备份旧配置
backup_config() {
    if [ -d "$HOME/.openclaw" ]; then
        log_info "检测到旧的 OpenClaw 配置"
        BACKUP_DIR="$HOME/.openclaw.backup.$(date +%Y%m%d_%H%M%S)"
        
        read -p "是否备份旧配置到 $BACKUP_DIR？[Y/n] " -n 1 -r
        echo ""
        
        if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
            cp -r "$HOME/.openclaw" "$BACKUP_DIR"
            log_success "配置已备份到：$BACKUP_DIR"
        fi
        echo ""
    fi
}

# 主函数
main() {
    print_banner
    
    echo -e "${YELLOW}本安装程序将:${NC}"
    echo "  ✓ 检查并安装 Node.js (如需要)"
    echo "  ✓ 检查并安装 git (如需要)"
    echo "  ✓ 安装 OpenClaw"
    echo "  ✓ 创建快捷启动脚本"
    echo "  ✓ 可选：运行配置向导"
    echo ""
    
    read -p "是否继续安装？[Y/n] " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ -n $REPLY ]]; then
        log_info "安装已取消"
        exit 0
    fi
    
    # 备份旧配置
    backup_config
    
    # 检查系统要求
    check_requirements
    
    # 安装依赖
    if [[ "$NEED_GIT" == "true" ]]; then
        install_git
    fi
    
    if [[ "$NEED_NODE" == "true" ]]; then
        install_node
    fi
    
    # 安装 OpenClaw
    install_openclaw
    
    # 创建启动脚本
    create_startup_script
    
    # 运行引导向导
    run_onboarding
    
    # 显示安装后说明
    show_post_install
}

# 捕获错误
trap 'log_error "安装过程中出错"; exit 1' ERR

# 运行主函数
main "$@"
