#!/bin/bash

# SuperAgent Zero Global Installation Script
# Installs the AI superintelligence framework globally for use in any project

set -e  # Exit on any error

# Configuration
INSTALL_DIR="$HOME/.superagent-zero"
REPO_URL="https://github.com/Gravicity/SuperAgent-Zero.git"
VERSION="1.0.0"

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Output functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    local missing=()
    
    # Check for required commands
    command -v git >/dev/null 2>&1 || missing+=("git")
    command -v node >/dev/null 2>&1 || missing+=("node")
    
    # Check Node.js version
    if command -v node >/dev/null 2>&1; then
        local node_version=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$node_version" -lt 18 ]; then
            missing+=("node v18+")
        fi
    fi
    
    if [ ${#missing[@]} -ne 0 ]; then
        print_error "Missing required tools: ${missing[*]}"
        echo ""
        echo "Please install the missing tools:"
        echo "  - Git: https://git-scm.com/"
        echo "  - Node.js v18+: https://nodejs.org/"
        echo ""
        exit 1
    fi
    
    print_success "Prerequisites check completed"
}

# Install SuperAgent Zero framework
install_framework() {
    print_status "Installing SuperAgent Zero framework..."
    
    # Remove old installation if exists
    if [ -d "$INSTALL_DIR" ]; then
        print_status "Updating existing installation..."
        rm -rf "$INSTALL_DIR"
    fi
    
    # Create installation directory
    mkdir -p "$INSTALL_DIR"
    
    # Clone or copy framework files
    if [ -d "$(dirname "$0")" ] && [ -f "$(dirname "$0")/setup.sh" ]; then
        # Installing from local repository
        print_status "Installing from local repository..."
        cp -r "$(dirname "$0")"/* "$INSTALL_DIR/"
    else
        # Clone from GitHub
        print_status "Cloning from GitHub repository..."
        git clone "$REPO_URL" "$INSTALL_DIR"
    fi
    
    # Set up directory structure
    mkdir -p "$INSTALL_DIR"/{bin,docs,cache}
    
    # Make scripts executable
    chmod +x "$INSTALL_DIR/setup.sh"
    [ -d "$INSTALL_DIR/bin" ] && chmod +x "$INSTALL_DIR/bin/"*.sh 2>/dev/null || true
    
    # Create version file
    echo "$(date '+%Y-%m-%d %H:%M:%S')" > "$INSTALL_DIR/VERSION"
    
    # Create framework registry
    cat > "$INSTALL_DIR/framework-registry.json" << EOF
{
  "installed": true,
  "version": "$VERSION",
  "path": "$INSTALL_DIR",
  "installed_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "components": {
    "agents": true,
    "agent_command_center": true,
    "fluid_evolution_system": true,
    "mcp_configs": true,
    "examples": true
  }
}
EOF
    
    print_success "SuperAgent Zero framework installed at $INSTALL_DIR"
}

# Create helper scripts
create_helpers() {
    print_status "Creating helper scripts..."
    
    # Create update script
    cat > "$INSTALL_DIR/bin/update.sh" << 'EOF'
#!/bin/bash
# SuperAgent Zero Framework Updater
echo "🔄 Updating SuperAgent Zero framework..."
curl -sSL https://raw.githubusercontent.com/Gravicity/SuperAgent-Zero/main/install.sh | bash
echo "✅ Update completed!"
EOF
    chmod +x "$INSTALL_DIR/bin/update.sh"
    
    # Create validation script
    cat > "$INSTALL_DIR/bin/validate.sh" << 'EOF'
#!/bin/bash
# SuperAgent Zero Framework Validator
FRAMEWORK_DIR="$HOME/.superagent-zero"

echo "🔍 Validating SuperAgent Zero installation..."

# Check framework components
checks=(
    "$FRAMEWORK_DIR/framework-registry.json:Framework registry"
    "$FRAMEWORK_DIR/setup.sh:Setup script"
    "$FRAMEWORK_DIR/agents:Agent framework"
    "$FRAMEWORK_DIR/agents/agent-00-command:Agent 0 command center"
    "$FRAMEWORK_DIR/bin:Helper scripts"
)

all_good=true
for check in "${checks[@]}"; do
    IFS=':' read -r path desc <<< "$check"
    if [ -e "$path" ]; then
        echo "✅ $desc"
    else
        echo "❌ $desc (missing: $path)"
        all_good=false
    fi
done

if [ "$all_good" = true ]; then
    echo "🎉 SuperAgent Zero is properly installed and ready!"
else
    echo "⚠️  Some components are missing. Try reinstalling."
fi
EOF
    chmod +x "$INSTALL_DIR/bin/validate.sh"
    
    print_success "Helper scripts created"
}

# Set up shell integration (optional)
setup_shell_integration() {
    print_status "Setting up shell integration..."
    
    # Add to PATH if not already there
    local shell_rc=""
    if [ -n "$BASH_VERSION" ]; then
        shell_rc="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        shell_rc="$HOME/.zshrc"
    fi
    
    if [ -n "$shell_rc" ] && [ -f "$shell_rc" ]; then
        if ! grep -q ".superagent-zero/bin" "$shell_rc"; then
            echo "" >> "$shell_rc"
            echo "# SuperAgent Zero" >> "$shell_rc"
            echo "export PATH=\"\$HOME/.superagent-zero/bin:\$PATH\"" >> "$shell_rc"
            print_success "Added SuperAgent Zero to PATH in $shell_rc"
        fi
    fi
}

# Main installation process
main() {
    echo "🤖 SuperAgent Zero Global Installation"
    echo "======================================"
    echo ""
    
    check_prerequisites
    install_framework
    create_helpers
    setup_shell_integration
    
    echo ""
    echo "🎉 SuperAgent Zero installation completed successfully!"
    echo ""
    echo "📋 Installation Summary:"
    echo "   📂 Location: $INSTALL_DIR"
    echo "   📦 Version: $VERSION"
    echo "   🔧 Helper scripts: Available in bin/"
    echo ""
    echo "🚀 Getting Started (2-Step Process):"
    echo "   1. Navigate to any project directory"
    echo "   2. Start Claude Code: claude-code"
    echo "   3. Tell Claude: 'Execute this bash command: ~/.superagent-zero/setup.sh'"
    echo "   ✅ Claude automatically reads framework files and becomes Agent 0!"
    echo ""
    echo "📚 Additional Commands:"
    echo "   Update framework: ~/.superagent-zero/bin/update.sh"
    echo "   Validate install: ~/.superagent-zero/bin/validate.sh"
    echo ""
    echo "💡 Need help? Check the documentation at:"
    echo "   ~/.superagent-zero/README.md"
    echo "   Quick start guide: ~/.superagent-zero/QUICKSTART.md"
    echo ""
    echo "🎯 Ready to deploy superintelligence with fluid agent evolution! Follow the 3-step process above to begin. 🧠✨"
    echo ""
    echo "🧬 New: Fluid Agent Evolution System"
    echo "   ✅ Agents learn and adapt from previous deployments"
    echo "   ✅ Agent recall and reuse for improved efficiency"
    echo "   ✅ Cross-agent knowledge sharing for better outcomes"
    echo "   ✅ Continuous performance improvement over time"
    echo ""
    echo "🔄 New: CLAUDE.md Persistent Behavior System"
    echo "   ✅ Agent 0 identity persists across all sessions"
    echo "   ✅ Hybrid system: claude-initialization.md + CLAUDE.md"
    echo "   ✅ Consistent multi-agent coordination behavior"
    echo "   ✅ Seamless cross-session superintelligence"
}

# Run installation
main "$@"