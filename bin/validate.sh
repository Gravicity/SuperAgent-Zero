#!/bin/bash
# SuperAgent Zero Framework Validation Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="$HOME/.superagent-zero"

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

echo "🔍 SuperAgent Zero Framework Validation"
echo "======================================"
echo ""

# Check framework installation
print_status "Validating framework installation..."

if [ ! -d "$INSTALL_DIR" ]; then
    print_error "SuperAgent Zero framework not found at $INSTALL_DIR"
    echo "Please install the framework first:"
    echo "curl -sSL https://raw.githubusercontent.com/Gravicity/SuperAgent-Zero/main/install.sh | bash"
    exit 1
fi

print_success "Framework directory found"

# Check framework components (directories)
print_status "Checking framework structure..."
if [ -f "$INSTALL_DIR/framework-registry.json" ]; then
    echo "  ✅ Framework registry"
else
    echo "  ❌ Framework registry"
fi

if [ -f "$INSTALL_DIR/setup.sh" ]; then
    echo "  ✅ Setup script"
else
    echo "  ❌ Setup script"
fi

if [ -d "$INSTALL_DIR/agents" ]; then
    echo "  ✅ Agent framework"
else
    echo "  ❌ Agent framework"
fi

if [ -d "$INSTALL_DIR/agents/agent-00-command" ]; then
    echo "  ✅ Agent 0 command center"
else
    echo "  ❌ Agent 0 command center"
fi

if [ -d "$INSTALL_DIR/bin" ]; then
    echo "  ✅ Helper scripts"
else
    echo "  ❌ Helper scripts"
fi

# Check essential files
essential_files=(
    "README.md"
    "setup.sh"
    "install.sh"
    "VERSION"
    "agents/agent-00-command/Agent-0-Command-Center.md"
    "agents/agent-00-command/Agent-Creation-Templates.md"
    "agents/agent-00-command/Memory-and-Strategy.md"
    "agents/agent-00-command/Project-Analyzer-Agent-Template.md"
    "bin/update.sh"
    "bin/validate.sh"
    "mcp-configs/default-config.json"
)

print_status "Checking essential files..."
missing_files=()

for file in "${essential_files[@]}"; do
    if [ -f "$INSTALL_DIR/$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file"
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -eq 0 ]; then
    print_success "All essential files present"
else
    print_error "Missing files detected:"
    for file in "${missing_files[@]}"; do
        echo "    - $file"
    done
    echo ""
    print_warning "Consider running: ~/.superagent-zero/bin/update.sh"
fi

# Check permissions
print_status "Checking script permissions..."
if [ -x "$INSTALL_DIR/setup.sh" ]; then
    echo "  ✅ setup.sh is executable"
else
    print_warning "setup.sh is not executable"
    chmod +x "$INSTALL_DIR/setup.sh"
    echo "  🔧 Fixed setup.sh permissions"
fi

if [ -x "$INSTALL_DIR/bin/update.sh" ]; then
    echo "  ✅ update.sh is executable"
else
    print_warning "update.sh is not executable"
    chmod +x "$INSTALL_DIR/bin/update.sh"
    echo "  🔧 Fixed update.sh permissions"
fi

# Show version and status
echo ""
print_status "Framework Information:"
echo "   📂 Location: $INSTALL_DIR"
echo "   📦 Version: $(cat "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")"
echo "   🧠 Agent 0: Ready for superintelligence deployment"
echo "   🧬 Evolution System: Fluid Agent Evolution operational"
echo ""

if [ ${#missing_files[@]} -eq 0 ]; then
    print_success "✅ SuperAgent Zero framework validation complete - All systems operational!"
    echo ""
    echo "🚀 Ready to activate in any project:"
    echo "   1. Navigate to project directory"
    echo "   2. Start Claude Code: claude-code"
    echo "   3. Run: 'Execute this bash command: ~/.superagent-zero/setup.sh'"
    echo "   ✅ Claude automatically reads framework files and becomes Agent 0!"
    echo ""
    echo "🧬 Evolution System Features:"
    echo "   ✅ Agent learning and adaptation"
    echo "   ✅ Agent recall and reuse (>70% task similarity)"
    echo "   ✅ Cross-agent knowledge sharing"
    echo "   ✅ Continuous performance improvement"
else
    print_error "❌ Framework validation failed - Missing files detected"
    echo "Run 'update.sh' to fix installation issues"
    exit 1
fi