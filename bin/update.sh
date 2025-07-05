#!/bin/bash
# SuperAgent Zero Framework Update Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://raw.githubusercontent.com/Gravicity/SuperAgent-Zero/main"
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

# Check if framework is installed
if [ ! -d "$INSTALL_DIR" ]; then
    print_error "SuperAgent Zero framework not found. Please install first:"
    echo "curl -sSL $REPO_URL/install.sh | bash"
    exit 1
fi

echo "🔄 SuperAgent Zero Framework Update"
echo "=================================="
echo ""

print_status "Backing up current framework..."
cp -r "$INSTALL_DIR" "$INSTALL_DIR.backup.$(date +%Y%m%d-%H%M%S)"

print_status "Downloading latest framework..."
if curl -sSL "$REPO_URL/install.sh" | bash; then
    print_success "Framework updated successfully!"
    echo ""
    echo "🎉 SuperAgent Zero framework update completed!"
    echo ""
    echo "📋 Framework Status:"
    echo "   📂 Location: $INSTALL_DIR"
    echo "   📦 Version: $(cat "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")"
    echo "   🔧 Helper scripts: Available in bin/"
    echo ""
    echo "🚀 Getting Started (3-Step Process):"
    echo "   1. Navigate to any project directory"
    echo "   2. Start Claude Code: claude-code"
    echo "   3. Tell Claude: 'Execute this bash command: ~/.superagent-zero/setup.sh'"
    echo "   4. Tell Claude: 'Read the file .superagent/claude-initialization.md and assume your role as Agent 0'"
    echo ""
    echo "📚 Additional Commands:"
    echo "   Update framework: ~/.superagent-zero/bin/update.sh"
    echo "   Validate install: ~/.superagent-zero/bin/validate.sh"
    echo ""
    echo "💡 Need help? Check the documentation at:"
    echo "   ~/.superagent-zero/README.md"
    echo ""
    echo "✅ Update completed!"
else
    print_error "Update failed. Restoring backup..."
    rm -rf "$INSTALL_DIR"
    mv "$INSTALL_DIR.backup."* "$INSTALL_DIR" 2>/dev/null || true
    print_error "Update failed and backup restored. Please try again."
    exit 1
fi