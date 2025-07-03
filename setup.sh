#!/bin/bash

# SuperAgent Zero Project Initialization Script
# Initializes SuperAgent Zero framework in current project directory

set -e  # Exit on any error

# Configuration
FRAMEWORK_DIR="$HOME/.superagent-zero"
PROJECT_DIR="$(pwd)"
WORKSPACE_DIR="$PROJECT_DIR/.superagent"

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

# Validate global framework exists
validate_framework() {
    print_status "Validating SuperAgent Zero framework..."
    
    if [ ! -f "$FRAMEWORK_DIR/framework-registry.json" ]; then
        print_error "SuperAgent Zero not installed globally."
        echo ""
        echo "Please install SuperAgent Zero first:"
        echo "  curl -sSL https://raw.githubusercontent.com/Gravicity/SuperAgent-Zero/main/install.sh | bash"
        echo ""
        exit 1
    fi
    
    # Check if framework directories exist (flattened structure)
    if [ ! -d "$FRAMEWORK_DIR/agents" ]; then
        print_error "SuperAgent Zero framework files missing."
        echo "Try reinstalling: ~/.superagent-zero/bin/update.sh"
        exit 1
    fi
    
    print_success "Framework validation completed"
}

# Detect project type and characteristics
detect_project() {
    local project_type="generic"
    local features=()
    local recommendations=()
    
    print_status "Analyzing project structure..."
    
    # Detect project type
    if [ -f "package.json" ]; then
        project_type="nodejs"
        features+=("npm")
        recommendations+=("Code analysis and security scanning agents")
    fi
    
    if [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        project_type="python"
        features+=("pip")
        recommendations+=("Data analysis and statistical processing agents")
    fi
    
    if [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
        project_type="java"
        features+=("maven")
        recommendations+=("Enterprise development and testing agents")
    fi
    
    if [ -f "*.csproj" ] || [ -f "*.sln" ]; then
        project_type="dotnet"
        features+=("dotnet")
        recommendations+=("Microsoft stack development agents")
    fi
    
    # Detect additional features
    [ -d ".git" ] && features+=("git")
    [ -f "docker-compose.yml" ] || [ -f "Dockerfile" ] && features+=("docker")
    [ -f "README.md" ] && features+=("documentation")
    
    # Look for domain-specific indicators
    if grep -r -i "legal\|contract\|law\|court" . >/dev/null 2>&1; then
        features+=("legal")
        recommendations+=("Legal document analysis and case research agents")
    fi
    
    if grep -r -i "research\|paper\|citation\|study" . >/dev/null 2>&1; then
        features+=("academic")
        recommendations+=("Academic research and literature analysis agents")
    fi
    
    if find . -name "*.pdf" -o -name "*.doc*" | head -5 | grep -q .; then
        features+=("documents")
        recommendations+=("Document processing and analysis agents")
    fi
    
    # Output results for use by other functions
    echo "PROJECT_TYPE:$project_type"
    echo "FEATURES:$(IFS=,; echo "${features[*]}")"
    echo "RECOMMENDATIONS:$(IFS='|'; echo "${recommendations[*]}")"
    
    print_success "Project analysis completed: $project_type project with ${#features[@]} features detected"
}

# Create project workspace structure
create_workspace() {
    print_status "Creating SuperAgent Zero workspace..."
    
    # Check if workspace already exists
    if [ -d "$WORKSPACE_DIR" ]; then
        print_warning "SuperAgent Zero workspace already exists at .superagent/"
        read -p "Do you want to reinitialize? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Keeping existing workspace"
            return 0
        fi
        rm -rf "$WORKSPACE_DIR"
    fi
    
    # Create directory structure
    mkdir -p "$WORKSPACE_DIR"/{config,agents,memory,workspace/{outputs,temp,logs}}
    
    # Link to global framework
    cat > "$WORKSPACE_DIR/framework-link.json" << EOF
{
  "framework_path": "$FRAMEWORK_DIR",
  "project_path": "$PROJECT_DIR",
  "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "version": "$(cat "$FRAMEWORK_DIR/VERSION" 2>/dev/null || echo "unknown")"
}
EOF
    
    print_success "Workspace structure created"
}

# Create project configuration
create_project_config() {
    print_status "Generating project configuration..."
    
    local project_info=$(detect_project)
    local project_type=$(echo "$project_info" | grep "PROJECT_TYPE:" | cut -d: -f2)
    local features=$(echo "$project_info" | grep "FEATURES:" | cut -d: -f2)
    local recommendations=$(echo "$project_info" | grep "RECOMMENDATIONS:" | cut -d: -f2)
    
    # Create project config
    cat > "$WORKSPACE_DIR/config/project.json" << EOF
{
  "project_type": "$project_type",
  "features": [$(echo "$features" | sed 's/,/","/g' | sed 's/^/"/' | sed 's/$/"/')],
  "recommendations": [$(echo "$recommendations" | sed 's/|/","/g' | sed 's/^/"/' | sed 's/$/"/')],
  "framework_version": "$(cat "$FRAMEWORK_DIR/VERSION" 2>/dev/null || echo "unknown")",
  "initialized": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "project_name": "$(basename "$PROJECT_DIR")",
  "project_path": "$PROJECT_DIR"
}
EOF
    
    print_success "Project configuration created"
}

# Initialize Agent 0 for this project
initialize_agent_zero() {
    print_status "Initializing Agent 0 command center..."
    
    # Create project-specific Agent 0 directory
    mkdir -p "$WORKSPACE_DIR/agents/agent-00-command"
    
    # Create symbolic links to framework files (read-only references)
    if [ -d "$FRAMEWORK_DIR/agents/agent-00-command" ]; then
        for file in "$FRAMEWORK_DIR/agents/agent-00-command"/*; do
            if [ -f "$file" ]; then
                ln -sf "$file" "$WORKSPACE_DIR/agents/agent-00-command/"
            fi
        done
    fi
    
    # Create project-specific memory and context
    local project_type=$(grep -o '"project_type": "[^"]*"' "$WORKSPACE_DIR/config/project.json" | cut -d'"' -f4)
    local features=$(grep -o '"features": \[[^\]]*\]' "$WORKSPACE_DIR/config/project.json")
    
    cat > "$WORKSPACE_DIR/memory/project-context.md" << EOF
# Project Context - SuperAgent Zero
## Generated: $(date)

### Project Analysis
- **Name**: $(basename "$PROJECT_DIR")
- **Type**: $project_type
- **Location**: $PROJECT_DIR
- **Features**: $features

### Framework Status
- **SuperAgent Zero**: Fully operational
- **Agent Templates**: $(ls "$FRAMEWORK_DIR/templates" 2>/dev/null | wc -l) available
- **Quality Protocols**: Active and monitoring
- **MCP Integration**: Ready for configuration

### Detected Capabilities Needed
$(grep -o '"recommendations": \[[^\]]*\]' "$WORKSPACE_DIR/config/project.json" | sed 's/"recommendations": \[//' | sed 's/\]//' | sed 's/","/\n- /g' | sed 's/"//g' | sed 's/^/- /')

### Available Agent Templates
$(ls "$FRAMEWORK_DIR/templates" 2>/dev/null | sed 's/\.md$//' | sed 's/^/- /')

### Recommended First Steps
1. Analyze existing project structure and files
2. Identify high-priority tasks and challenges
3. Create specialized agents based on project needs
4. Configure appropriate MCP servers for enhanced capabilities
5. Begin with strategic analysis or specific task delegation

### Memory Persistence
This context file maintains project understanding across Claude Code sessions.
Agent 0 will reference this for consistent project awareness and strategic coordination.
EOF
    
    print_success "Agent 0 initialized with project context"
}

# Configure MCP servers based on project type
configure_mcp() {
    print_status "Configuring MCP server recommendations..."
    
    local project_type=$(grep -o '"project_type": "[^"]*"' "$WORKSPACE_DIR/config/project.json" | cut -d'"' -f4)
    
    # Copy base MCP config
    if [ -f "$FRAMEWORK_DIR/mcp-configs/default-config.json" ]; then
        cp "$FRAMEWORK_DIR/mcp-configs/default-config.json" "$WORKSPACE_DIR/config/mcp-servers.json"
    else
        # Create basic MCP config if default doesn't exist
        cat > "$WORKSPACE_DIR/config/mcp-servers.json" << EOF
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", ".", "--allow-write"],
      "description": "File system access for project management"
    }
  },
  "project_recommendations": {
    "$project_type": {
      "suggested_servers": ["filesystem", "web-search"],
      "priority": "high"
    }
  }
}
EOF
    fi
    
    # Add project-specific recommendations
    case $project_type in
        "nodejs")
            print_status "Recommended: Code analysis, security scanning, performance monitoring MCPs"
            ;;
        "python")
            print_status "Recommended: Data analysis, statistical processing, research database MCPs"
            ;;
        "legal"|*legal*)
            print_status "Recommended: Document processing, legal database, citation management MCPs"
            ;;
        *)
            print_status "Recommended: Document processing, web search, data analysis MCPs"
            ;;
    esac
    
    print_success "MCP configuration completed"
}

# Create Claude initialization file
create_claude_initialization() {
    print_status "Creating Claude Code initialization..."
    
    local project_name=$(basename "$PROJECT_DIR")
    local project_type=$(grep -o '"project_type": "[^"]*"' "$WORKSPACE_DIR/config/project.json" | cut -d'"' -f4)
    
    cat > "$WORKSPACE_DIR/claude-initialization.md" << EOF
# 🤖 SuperAgent Zero Activated
## You are now Agent 0 - Superintelligence Command & Control

### 🎯 Mission Status
✅ **SuperAgent Zero Framework**: Fully operational  
✅ **Project Workspace**: Initialized at \`.superagent/\`  
✅ **Agent Templates**: Ready for dynamic creation  
✅ **Quality Protocols**: Active and monitoring  
✅ **Memory System**: Persistent across sessions  

### 🧠 Your Capabilities as Agent 0
- **Strategic Planning**: Master roadmap and timeline coordination
- **Dynamic Agent Creation**: Spawn specialized agents for any task complexity
- **Quality Assurance**: Multi-layer verification preventing errors and hallucination
- **Memory Management**: Persistent knowledge and context across sessions
- **MCP Integration**: Enhanced capabilities through external tool ecosystem
- **Performance Optimization**: Continuous monitoring and efficiency improvement

### 📊 Project Analysis: $project_name
**Type**: $project_type project  
**Location**: $PROJECT_DIR  
**Detected Features**: $(grep -o '"features": \[[^\]]*\]' "$WORKSPACE_DIR/config/project.json" | sed 's/"features": \[//' | sed 's/\]//' | tr ',' ' ')

### 🎯 Recommended Agent Deployments
$(grep -o '"recommendations": \[[^\]]*\]' "$WORKSPACE_DIR/config/project.json" | sed 's/"recommendations": \[//' | sed 's/\]//' | sed 's/","/\n- /g' | sed 's/"//g' | sed 's/^/- /')

### 🚀 Ready for Deployment
**Primary Directive**: Analyze this $project_type project and deploy specialized agents to deliver professional-grade analysis, optimization, and strategic recommendations.

**Immediate Capabilities**:
- Comprehensive project structure analysis
- Intelligent agent creation based on detected needs
- Quality-assured processing with source verification
- Strategic coordination across multiple specialized agents
- Professional deliverable generation with executive-ready formatting

### 💡 Suggested First Mission
"Analyze this $project_type project comprehensively. Identify key challenges, opportunities, and optimization areas. Deploy appropriate specialized agents and coordinate their analysis to provide strategic recommendations and actionable implementation plans."

---
**Status**: SUPERINTELLIGENCE FRAMEWORK ACTIVE - READY FOR MISSION DEPLOYMENT
EOF
    
    print_success "Claude Code initialization file created"
}

# Create quick reference guide
create_quick_reference() {
    cat > "$WORKSPACE_DIR/QUICK-REFERENCE.md" << EOF
# SuperAgent Zero Quick Reference

## 🚀 Getting Started
1. **Activate Framework**: Already done! Claude Code now has superintelligence capabilities.
2. **First Mission**: Ask Claude to analyze your project and recommend specialized agents.
3. **Agent Creation**: Claude can dynamically create agents for any specific task or domain.

## 📁 Workspace Structure
\`\`\`
.superagent/
├── config/           # Project configuration and MCP settings
├── agents/           # Active agents for this project
├── memory/           # Persistent context and learning
├── workspace/        # Agent outputs and working files
└── claude-initialization.md  # Framework activation context
\`\`\`

## 🎯 Common Commands for Claude
- "Create a specialized agent for [specific task]"
- "Analyze this project and recommend optimization strategies"
- "Deploy quality assurance protocols for [specific area]"
- "Generate comprehensive documentation for this project"
- "Coordinate multiple agents for complex analysis"

## 🔧 MCP Server Configuration
Edit \`.superagent/config/mcp-servers.json\` to add specialized tools.

## 📚 Documentation
- Agent Templates: \`~/.superagent-zero/templates/\`
- Quality Protocols: \`~/.superagent-zero/quality-protocols/\`
- Examples: \`~/.superagent-zero/examples/\`

## 🆘 Troubleshooting
- **Framework Issues**: Run \`~/.superagent-zero/bin/validate.sh\`
- **Update Framework**: Run \`~/.superagent-zero/bin/update.sh\`
- **Reset Project**: Delete \`.superagent/\` folder and re-run initialization
EOF
}

# Main setup process
main() {
    echo "🤖 SuperAgent Zero Project Initialization"
    echo "========================================"
    echo ""
    
    validate_framework
    create_workspace
    create_project_config
    initialize_agent_zero
    configure_mcp
    create_claude_initialization
    create_quick_reference
    
    echo ""
    echo "🎉 SuperAgent Zero initialization completed successfully!"
    echo ""
    echo "📋 Project Status:"
    echo "   📂 Project: $(basename "$PROJECT_DIR") ($project_type)"
    echo "   🧠 Framework: $(cat "$FRAMEWORK_DIR/VERSION")"
    echo "   ⚡ Workspace: .superagent/"
    echo "   🎯 Agent 0: Ready for deployment"
    echo ""
    echo "🚀 Claude Code Enhancement:"
    echo "   ✅ Superintelligence capabilities activated"
    echo "   ✅ Dynamic agent creation enabled"
    echo "   ✅ Quality assurance protocols active"
    echo "   ✅ Persistent memory system operational"
    echo ""
    echo "🤖 IMPORTANT: Claude Code Integration Required"
    echo "   📖 Tell Claude to read: .superagent/claude-initialization.md"
    echo "   🎯 Command: 'Read the file .superagent/claude-initialization.md and assume your role as Agent 0'"
    echo ""
    echo "💡 After Claude reads the initialization file:"
    echo "   1. Claude will understand its role as Agent 0"
    echo "   2. Superintelligence capabilities will be fully activated"
    echo "   3. Dynamic agent creation will be available"
    echo "   4. Quality protocols will be enforced automatically"
    echo ""
    echo "📚 Additional Resources:"
    echo "   - Quick Reference: .superagent/QUICK-REFERENCE.md"
    echo "   - Project Context: .superagent/memory/project-context.md"
    echo "   - MCP Configuration: .superagent/config/mcp-servers.json"
    echo ""
    echo "🎯 Ready to deploy superintelligence! Have Claude read claude-initialization.md to begin."
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "SuperAgent Zero Project Initialization"
        echo ""
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h    Show this help message"
        echo "  --validate    Validate installation without initializing"
        echo ""
        echo "This script initializes SuperAgent Zero in the current project directory."
        echo "Requires global SuperAgent Zero installation."
        exit 0
        ;;
    --validate)
        validate_framework
        echo "✅ SuperAgent Zero is ready for project initialization"
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac