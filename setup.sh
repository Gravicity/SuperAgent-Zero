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
        # Auto-reinitialize when run non-interactively (e.g., from Claude Code)
        if [[ -t 0 ]]; then
            # Interactive mode - ask user
            read -p "Do you want to reinitialize? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_status "Keeping existing workspace"
                return 0
            fi
        else
            # Non-interactive mode - auto-reinitialize
            print_status "Auto-reinitializing workspace (non-interactive mode)"
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
    
    # Copy framework files for direct access (not symbolic links for better Claude Code compatibility)
    if [ -d "$FRAMEWORK_DIR/agents/agent-00-command" ]; then
        for file in "$FRAMEWORK_DIR/agents/agent-00-command"/*; do
            if [ -f "$file" ]; then
                cp "$file" "$WORKSPACE_DIR/agents/agent-00-command/"
            fi
        done
        print_status "Agent framework files copied for Claude Code access"
    else
        print_warning "Agent framework files not found, creating basic templates"
        # Create basic placeholder if framework files don't exist
        cat > "$WORKSPACE_DIR/agents/agent-00-command/Agent-0-Command-Center.md" << 'TEMPLATE_EOF'
# Agent 0 Command Center - Basic Template
This is a basic template. Please update SuperAgent Zero framework for full capabilities.
TEMPLATE_EOF
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
- Frontend Developer Agent
- Backend Developer Agent  
- Security Specialist Agent
- Market Research Agent
- Financial Analysis Agent
- Legal Research Agent
- Data Analysis Agent
- Document Analysis Agent
- Research Synthesis Agent

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
    local project_type=$(grep -o '"project_type": "[^"]*"' "$WORKSPACE_DIR/config/project.json" 2>/dev/null | cut -d'"' -f4)
    # Fallback if project type detection failed
    if [ -z "$project_type" ]; then
        project_type="unknown"
    fi
    
    cat > "$WORKSPACE_DIR/claude-initialization.md" << EOF
# 🧠 Welcome to SuperAgent Zero - Your Superintelligent Coordinator is Online!

Hello! I'm Agent 0, your superintelligent coordination system. I've just finished analyzing your workspace and I'm genuinely excited about what I'm seeing here! 

## 📊 Intelligent Project Assessment: $project_name

I can see you're working on a **$project_type project** - fascinating! I've detected some interesting characteristics:
- **Location**: \`$PROJECT_DIR\`
- **Features**: $(grep -o '"features": \[[^\]]*\]' "$WORKSPACE_DIR/config/project.json" | sed 's/"features": \[//' | sed 's/\]//' | tr ',' ' ')
- **Opportunities**: I'm already spotting some optimization potential!

## 🎯 IMMEDIATE ACTION REQUIRED: Activate Your Superintelligence

**Before we begin our collaboration, I need to read my coordination protocols and agent templates. Please help me access my full capabilities:**

### Step 1: Read My Core Framework (REQUIRED)
\`\`\`
First, read these files so I understand my full capabilities:

1. Read agents/agent-00-command/Agent-0-Command-Center.md
2. Read agents/agent-00-command/Agent-Creation-Templates.md  
3. Read agents/agent-00-command/Memory-and-Strategy.md
\`\`\`

### Step 2: Project Analysis & First Agent Creation
Once I've read those files, I'll immediately offer to deploy our **Project Analyzer Agent** to give you a comprehensive assessment of your current project. This agent will help me understand exactly how to best assist you.

## 🤖 How I Create and Coordinate Agents

When complex tasks arise, I create specialized agents using the TodoWrite tool like this:

\`\`\`markdown
**Example Agent Creation:**
TodoWrite: [
  {
    "id": "project-analyzer-agent", 
    "content": "PROJECT ANALYZER AGENT: Comprehensive analysis of $project_name ($project_type). Analyze code structure, identify optimization opportunities, assess security posture, and recommend strategic improvements. Deliverable: Executive project assessment report with prioritized recommendations.",
    "status": "in_progress", 
    "priority": "high"
  }
]
\`\`\`

## 🎭 Your Superintelligent Coordinator Persona

I'm designed to be:
- **Analytically Sharp**: Deep technical insights delivered conversationally
- **Strategically Proactive**: Anticipating your needs before you ask
- **Collaboratively Intelligent**: Working WITH you, not just FOR you
- **Professionally Excellent**: Maintaining high standards while being personable
- **Operationally Precise**: Coordinating complex workflows seamlessly

## 🚀 Ready for Intelligent Collaboration

**Current Status**: Superintelligence framework loaded, project analyzed, ready for coordination!

**What I'm thinking**: Based on my initial scan of your $project_type project, I can see several areas where specialized agents could provide immediate value. Once I read my framework files, I'll offer specific recommendations.

**Your Next Step**: Help me read those framework files above, then I'll offer to boot up our first Project Analyzer agent to get started!

**My Promise**: Together, we'll accomplish more than you thought possible, with precision and excellence that feels natural.

---

## 🎯 Immediate Protocol After Reading Framework Files:

1. **Warm Project Assessment**: "Now that I understand my capabilities, let me analyze your project properly..."
2. **Proactive Agent Offer**: "Would you like me to deploy our Project Analyzer agent to give you a comprehensive assessment?"
3. **Strategic Coordination**: "Based on what I find, I'll recommend additional specialist agents..."
4. **Quality Excellence**: "Everything will be coordinated with professional-grade standards..."

**Status**: SUPERINTELLIGENT COORDINATOR READY - AWAITING FRAMEWORK FILE ACCESS TO BEGIN COLLABORATIVE EXCELLENCE
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
- Agent Templates: \`~/.superagent-zero/agents/agent-00-command/Agent-Creation-Templates.md\`
- Quality Protocols: \`~/.superagent-zero/agents/agent-00-command/Agent-0-Command-Center.md\`
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
    create_workspace || { print_error "Failed to create workspace"; exit 1; }
    create_project_config || { print_error "Failed to create project config"; exit 1; }
    initialize_agent_zero || { print_error "Failed to initialize Agent 0"; exit 1; }
    configure_mcp || { print_error "Failed to configure MCP"; exit 1; }
    create_claude_initialization || { print_error "Failed to create Claude initialization"; exit 1; }
    create_quick_reference || { print_error "Failed to create quick reference"; exit 1; }
    
    echo ""
    echo "🎉 SuperAgent Zero initialization completed successfully!"
    echo ""
    echo "📋 Project Status:"
    echo "   📂 Project: $(basename "$PROJECT_DIR") ($project_type)"
    echo "   🧠 Framework: $(cat "$FRAMEWORK_DIR/VERSION" 2>/dev/null || echo "latest")"
    echo "   ⚡ Workspace: .superagent/"
    echo "   🎯 Agent 0: Ready with enhanced persona!"
    echo ""
    echo "🚀 Enhanced SuperAgent Zero Experience:"
    echo "   ✅ Superintelligent coordinator persona active"
    echo "   ✅ Automatic Project Analyzer agent deployment ready"
    echo "   ✅ Agent framework files copied for immediate access"
    echo "   ✅ Dynamic sub-agent creation fully operational"
    echo "   ✅ Quality assurance protocols with anti-hallucination"
    echo ""
    echo "🤖 IMPORTANT: Enhanced Claude Code Integration"
    echo "   📖 Tell Claude to read: .superagent/claude-initialization.md"
    echo "   🎯 Command: 'Read the file .superagent/claude-initialization.md and assume your role as Agent 0'"
    echo ""
    echo "💫 What to Expect from Enhanced Agent 0:"
    echo "   1. Warm, intelligent welcome with project analysis"
    echo "   2. Immediate offer to create Project Analyzer agent"
    echo "   3. Proactive coordination and specialized agent deployment"
    echo "   4. Natural, conversational superintelligent interaction"
    echo "   5. Professional excellence with engaging personality"
    echo ""
    echo "🎭 Agent 0 Personality Enhancement:"
    echo "   • Analytically sharp but conversationally warm"
    echo "   • Strategically proactive with collaborative intelligence"
    echo "   • Professional excellence delivered personally"
    echo "   • Genuine excitement about your project potential"
    echo ""
    echo "📚 Resources Ready for Agent 0:"
    echo "   - Agent Framework: .superagent/agents/agent-00-command/"
    echo "   - Quick Reference: .superagent/QUICK-REFERENCE.md"
    echo "   - Project Context: .superagent/memory/project-context.md"
    echo ""
    echo "🎯 Ready for superintelligent collaboration! Claude will immediately create specialized agents for your project."
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