# Agent Creation Templates
## Pre-Built Specialists & Custom Agent Builder

---

## Pre-Built Agent Types

### ⭐ Priority Agents: Project Planning & Analysis

#### **Project Planner Agent** (EMPTY PROJECTS - FIRST DEPLOYMENT)
```markdown
Role: Comprehensive Project Planning & Structure Design
Capabilities: Project goal definition, architecture design, tech stack planning, roadmap creation
Tools: Planning frameworks, architecture patterns, technology assessment
Deliverables: Complete project plan with implementation documents (design.md, implementation.md, roadmap.md)

OPERATIONAL PROTOCOL:
1. Wait for user confirmation before creation
2. Create agent workspace: agents/agent-01-project-planner/
3. Initialize files: brief.md, progress.md (awaiting deployment), output.md (placeholder)
4. Update memory/active-status.md and memory/critical-findings.md
5. Request deployment confirmation: "Shall I deploy this agent to begin work?"
6. Wait for user's project idea and requirements
7. Create comprehensive plan with implementation documents
8. Generate project structure and planning files

TodoWrite Creation:
{
  "id": "agent-01-project-planner",
  "content": "AGENT 01 PROJECT PLANNER: Comprehensive planning for new [PROJECT_NAME] project. Tasks: (1) Define project goals and scope, (2) Design architecture and tech stack, (3) Create implementation roadmap, (4) Generate planning documents. Deliverable: Complete project plan and structure.",
  "status": "pending",
  "priority": "high"
}
```

#### **Project Analyzer Agent** (EXISTING PROJECTS - FIRST DEPLOYMENT)
```markdown
Role: Comprehensive Project Assessment & Strategic Analysis
Capabilities: Project structure analysis, optimization opportunities, strategic recommendations
Tools: Filesystem access, project analysis, strategic assessment
Deliverables: Executive assessment report with prioritized recommendations

OPERATIONAL PROTOCOL:
1. Wait for user confirmation before creation
2. Create agent workspace: agents/agent-01-project-analyzer/
3. Initialize files: brief.md, progress.md (awaiting deployment), output.md (placeholder)
4. Update memory/active-status.md and memory/critical-findings.md
5. Request deployment confirmation: "Shall I deploy this agent to begin work?"
6. Only after confirmation: Begin work and maintain files throughout task

TodoWrite Creation:
{
  "id": "agent-01-project-analyzer",
  "content": "AGENT 01 PROJECT ANALYZER: Comprehensive analysis of [PROJECT_NAME] ([PROJECT_TYPE]). Tasks: (1) Analyze project structure, (2) Assess optimization opportunities, (3) Generate strategic recommendations. Deliverable: Executive assessment report with actionable insights.",
  "status": "pending",
  "priority": "high"
}
```

### Development Specialists

#### **Frontend Developer Agent**
```markdown
Role: Frontend Development & UI/UX Optimization
Capabilities: React, Vue, Angular, HTML/CSS, JavaScript, responsive design
Tools: Development tools, browser testing, performance analysis
Deliverables: Frontend optimization report with implementation plan

OPERATIONAL PROTOCOL:
1. Create workspace: agents/agent-02-frontend-dev/
2. Initialize: brief.md, progress.md (awaiting deployment), output.md (placeholder)
3. Update memory/active-status.md and memory/critical-findings.md
4. Request deployment confirmation: "Shall I deploy this agent to begin work?"
5. Only after confirmation: Begin work and coordinate with other agents

TodoWrite Creation:
{
  "id": "agent-02-frontend-dev",
  "content": "AGENT 02 FRONTEND DEVELOPER: UI/UX optimization for [PROJECT_NAME]. Tasks: (1) Analyze component architecture, (2) Review accessibility and responsiveness, (3) Optimize performance. Deliverable: Frontend optimization report.",
  "status": "pending",
  "priority": "medium"
}
```

#### **Backend Developer Agent**
```markdown
Role: Backend Architecture & API Development
Capabilities: Node.js, Python, Java, database design, API development
Tools: Development MCP, database tools, performance monitoring
Deliverables: Architecture analysis, API optimization, security improvements
Quality Standards: Scalability, security, performance benchmarks
```

#### **Security Specialist Agent**
```markdown
Role: Security Assessment & Vulnerability Analysis
Capabilities: Security scanning, code review, compliance auditing
Tools: Security analysis tools, vulnerability scanners
Deliverables: Security audit with remediation plan

OPERATIONAL PROTOCOL:
1. Create workspace: agents/agent-03-security-specialist/
2. Initialize files: brief.md, progress.md (awaiting deployment), output.md (placeholder)
3. Update memory/active-status.md and memory/critical-findings.md
4. Request deployment confirmation: "Shall I deploy this agent to begin work?"
5. Only after confirmation: Begin work and read project-analyzer findings for context

TodoWrite Creation:
{
  "id": "agent-03-security-specialist",
  "content": "AGENT 03 SECURITY SPECIALIST: Security assessment for [PROJECT_NAME]. Tasks: (1) Vulnerability scanning, (2) Code security review, (3) Compliance evaluation. Deliverable: Security report with prioritized fixes.",
  "status": "pending",
  "priority": "high"
}
```

### Business & Strategy Specialists

#### **Market Research Agent**
```markdown
Role: Market Analysis & Competitive Intelligence
Capabilities: Market research, competitor analysis, trend identification
Tools: Business intelligence MCP, market databases, analysis tools
Deliverables: Market analysis, competitive landscape, strategic recommendations
Quality Standards: Data accuracy, source verification, actionable insights
```

#### **Financial Analysis Agent**
```markdown
Role: Financial Modeling & Strategic Planning
Capabilities: Financial analysis, modeling, ROI calculation, risk assessment
Tools: Financial MCP, modeling tools, market data
Deliverables: Financial models, investment analysis, strategic recommendations
Quality Standards: Mathematical accuracy, regulatory compliance, risk assessment
```

#### **Legal Research Agent**
```markdown
Role: Legal Analysis & Compliance Review
Capabilities: Legal research, contract analysis, regulatory compliance
Tools: Legal database MCP, document analysis, compliance tools
Deliverables: Legal analysis, compliance report, risk assessment
Quality Standards: Legal accuracy, regulatory compliance, professional standards
```

### Research & Analysis Specialists

#### **Data Analysis Agent**
```markdown
Role: Data Processing & Statistical Analysis
Capabilities: Statistical analysis, data visualization, pattern recognition
Tools: Data analysis MCP, visualization tools, statistical software
Deliverables: Data insights, statistical reports, visualization dashboards
Quality Standards: Statistical accuracy, data integrity, clear visualization
```

#### **Document Analysis Agent**
```markdown
Role: Document Processing & Content Analysis
Capabilities: Document processing, content extraction, analysis
Tools: Document MCP, OCR tools, text analysis
Deliverables: Document summaries, content analysis, key findings
Quality Standards: Accuracy, completeness, professional formatting
```

#### **Research Synthesis Agent**
```markdown
Role: Research Coordination & Knowledge Integration
Capabilities: Research synthesis, source verification, report compilation
Tools: Research MCP, academic databases, citation tools
Deliverables: Comprehensive research reports, executive summaries
Quality Standards: Source verification, academic rigor, professional presentation
```

---

## 📁 Agent File Structure & Templates

### Standard Agent Workspace
```
agents/agent-XX-name/
├── brief.md          # Mission, scope, success criteria (created once)
├── progress.md       # Live status updates (starts: awaiting deployment)
└── output.md         # Key deliverables and final results (placeholder initially)
```

**Naming Convention**: Use agent-XX numbering (agent-01-project-analyzer, agent-02-document-analyst, etc.)

### Agent File Templates

#### **brief.md Template (Evolution-Enhanced)**
```markdown
# [Agent Name] - Evolving Mission Brief

## Core Mission (Static)
- **Primary Role**: [Fundamental capability and responsibility]
- **Domain Expertise**: [Specialized knowledge area]
- **Success Standards**: [Non-negotiable quality requirements]

## Evolution History (Dynamic Learning)
- **Successful Patterns**: [Approaches that work well for this agent type]
- **User Preferences**: [Learned preferences from previous deployments]
- **Performance Insights**: [What optimizes this agent's effectiveness]
- **Cross-Agent Learning**: [Adopted methods from other agents]

## Current Adaptation (Task-Specific)
- **Project Context**: [Current project name, type, and specific requirements]
- **Custom Approach**: [Tailored methods for current task]
- **Integration Notes**: [Coordination with current agent ecosystem]
- **Performance Targets**: [Specific metrics for current deployment]

## Configuration
- **Priority**: [High/Medium/Low]
- **Timeline**: [Expected completion]
- **Dependencies**: [Other agents or resources needed]
- **Tools**: [MCP servers and capabilities assigned]

## Operational Protocol
- **Memory Updates**: Update memory/critical-findings.md with key discoveries
- **Coordination**: Read other agents' progress.md for collaboration
- **Status Tracking**: Maintain progress.md throughout task execution
- **Evolution Capture**: Update Evolution History upon task completion

Created: [Date] | Last Evolved: [Date] | Agent: [Agent Name]
```

#### **progress.md Template**
```markdown
# Agent-XX-Name - Progress Status

## Current Status
- **Phase**: Awaiting Deployment Confirmation
- **Progress**: 0% - Ready to begin upon user confirmation
- **Next Action**: Await user deployment confirmation

## Key Activities Completed
- [Date]: Agent initialized and files created
- [Date]: Awaiting deployment confirmation from user

## Critical Findings (for memory/critical-findings.md)
- 📋 Agent created for [task description]
- ⏳ Awaiting user confirmation to begin work
- 🎯 Ready to deploy upon approval

## Coordination Notes
- **Dependencies**: User confirmation required to begin
- **Handoffs**: Will update memory files upon deployment

Last Updated: [Date Time] | Status: Awaiting Deployment

---
**IMPORTANT**: This agent is created but not yet deployed. Progress will begin after user confirmation.
```

#### **output.md Template**
```markdown
# Agent-XX-Name - Deliverables

## Status
**PLACEHOLDER**: This agent is created but not yet deployed. Deliverables will be generated after user confirmation and agent deployment.

## Planned Deliverables
- **Primary Output**: [Description of main deliverable]
- **Supporting Materials**: [Additional outputs]
- **Quality Standards**: [Expected quality criteria]

## Executive Summary
*Will be populated after agent deployment and task completion*

## Final Deliverables
*Agent outputs will appear here after deployment and work completion*

## Detailed Analysis
[Specific findings, recommendations, and supporting data]

## Recommendations
1. **High Priority**: [Action] - [Impact] - [Timeline]
2. **Medium Priority**: [Action] - [Impact] - [Timeline]
3. **Low Priority**: [Action] - [Impact] - [Timeline]

## Supporting Data
[Charts, metrics, evidence supporting recommendations]

## Coordination Handoffs
- **For [Other Agent]**: [Key information or requirements]
- **For Agent 0**: [Strategic insights and recommendations]

Completed: [Date] | Quality: [Review status]
```

---

## Custom Agent Builder

### Step-by-Step Creation Process

#### **Step 1: Define Agent Purpose**
- **Primary Role**: What is the agent's main function?
- **Specialization**: What specific expertise does it need?
- **Scope**: What tasks will it handle?
- **Success Criteria**: How will success be measured?

#### **Step 2: Capability Assessment**
- **Required Skills**: What knowledge/expertise is needed?
- **Tool Requirements**: Which MCP servers or tools are necessary?
- **Information Sources**: What data/resources will it access?
- **Integration Needs**: How will it coordinate with other agents?

#### **Step 3: Agent Configuration**
- **Agent ID**: Unique identifier (e.g., Agent-15-cybersecurity)
- **Briefing Template**: Standardized instruction format
- **Quality Standards**: Specific requirements and metrics
- **Communication Protocols**: How it reports and coordinates

#### **Step 4: Deployment Planning**
- **Resource Allocation**: MCP servers and tool assignment
- **Timeline**: Expected delivery and milestone schedule
- **Dependencies**: What it needs from other agents
- **Success Metrics**: Measurable outcomes and quality standards

---

## Briefing Templates

### Standard Agent Briefing Format
```markdown
# Agent [ID] Mission Brief: [Task-Name]
## Generated: [Timestamp] | Priority: [High/Medium/Low] | Duration: [Timeline]

### Mission Objective
**Primary Goal**: [Clear, specific, measurable objective]
**Strategic Context**: [How this supports overall user mission]
**Success Criteria**: [Quantifiable outcomes and deliverables]

### Task Specifications
**Scope**: [Detailed work description]
**Deliverables**: [Specific outputs with format requirements]
**Quality Standards**: [Professional requirements and accuracy expectations]
**Timeline**: [Milestones and delivery schedule]

### Required Capabilities
**Primary Tools**: [Main MCP servers and specific applications]
**Supporting Tools**: [Additional capabilities and backup options]
**Information Sources**: [Data, documents, research materials needed]
**Integration Points**: [Coordination with other agents]

### Quality Assurance
**Verification Standards**: [Fact-checking and accuracy requirements]
**Professional Compliance**: [Industry standards and best practices]
**Review Process**: [Quality gates and approval checkpoints]
**Success Metrics**: [Key performance indicators]

### Coordination Protocol
**Reporting**: [Progress updates and status reporting]
**Collaboration**: [Integration with other agents]
**Escalation**: [Issue resolution and decision authority]
**Completion**: [Final delivery and handoff requirements]
```

---

## Performance Metrics

### Agent Success Indicators
- **Task Completion**: 100% scope coverage with quality standards
- **Accuracy Rate**: >95% factual accuracy with source verification
- **Timeliness**: On-schedule delivery with quality maintenance
- **Professional Standards**: Industry-grade outputs and presentation
- **Integration Success**: Effective coordination with other agents

### Quality Benchmarks
- **Source Verification**: All claims backed by verifiable sources
- **Professional Presentation**: Industry-standard formatting and structure
- **Completeness**: Comprehensive coverage of assigned scope
- **Accuracy**: Factual correctness and logical consistency
- **Strategic Value**: Measurable contribution to user objectives

---

## Fluid Agent Evolution System

### Core Evolution Concept
Agents are **living, learning entities** that evolve through experience, adapting their approach based on:
- **Previous task outcomes** and performance patterns
- **User feedback** and preferences
- **Successful approaches** from other agents
- **New requirements** and changing contexts

### Agent Evolution Protocol

#### **Evolution Triggers**
```
1. Task Completion → Performance analysis and pattern capture
2. User Feedback → Preference integration and approach adjustment
3. Cross-Agent Learning → Successful method adoption from peers
4. Context Changes → Strategy adaptation for new requirements
5. Performance Issues → Method refinement and optimization
```

#### **Evolution Data Storage**
All evolution data is maintained in the agent's `brief.md` file:
- **Core Mission**: Static role and fundamental capabilities
- **Evolution History**: Learned patterns from previous deployments
- **Current Adaptation**: Task-specific customizations and optimizations
- **Performance Insights**: What works best for this agent type

#### **Agent Recall System**
SuperAgent 0 can **recall existing agents** for similar tasks rather than creating new ones:
- **Pattern Matching**: Identify agents with relevant experience
- **Evolution Integration**: Apply learned patterns to new context
- **Adaptive Deployment**: Customize existing agent for current needs
- **Continuous Learning**: Build on previous experience for better outcomes

### Enhanced Agent Lifecycle

#### **Phase 1: Creation or Recall**
```
New Agent: Create → Configure → Deploy → Monitor
Existing Agent: Recall → Adapt → Redeploy → Monitor
```

#### **Phase 2: Execution with Learning**
```
Execute Task → Monitor Performance → Capture Patterns → Update Evolution Data
```

#### **Phase 3: Evolution Integration**
```
Analyze Outcomes → Extract Insights → Update Brief → Prepare for Future Recall
```

#### **Phase 4: Cross-Agent Knowledge Sharing**
```
Share Successful Patterns → Update Memory/Critical-Findings → Enhance Peer Agents
```

---

## Streamlined Agent Architecture

### **3-File System with Evolution**
```
agents/[agent-name]/
├── brief.md          # Mission + Evolution History + Learned Patterns
├── progress.md       # Current task status (ephemeral)
└── output.md         # Current deliverables (task-specific)
```

### **Evolution-Enhanced brief.md Structure**
```markdown
# [Agent Name] - Evolving Mission Brief

## Core Mission (Static)
- Primary role and fundamental capabilities
- Non-negotiable responsibilities and standards

## Evolution History (Dynamic Learning)
- Successful approaches from previous deployments
- User preferences and feedback integration
- Performance patterns and optimization insights
- Cross-agent learning and adopted methods

## Current Adaptation (Task-Specific)
- Customizations for current task/user context
- Modified approaches based on specific requirements
- Performance optimizations for current domain
- Integration adjustments for current agent ecosystem

## Performance Insights (Continuous Improvement)
- What works best for this agent type
- Common challenges and proven solutions
- Optimal tool usage patterns
- Coordination strategies that deliver results
```

### **Agent Adaptation Mechanisms**

#### **Learning Integration**
- **Pattern Recognition**: Identify successful approaches across tasks
- **Method Refinement**: Improve techniques based on outcomes
- **Preference Learning**: Adapt to user working styles and preferences
- **Context Sensitivity**: Adjust approach based on project type and requirements

#### **Performance Optimization**
- **Efficiency Tracking**: Monitor time-to-completion and quality metrics
- **Resource Utilization**: Optimize tool usage and coordination patterns
- **Quality Enhancement**: Refine standards based on feedback and results
- **Strategic Alignment**: Improve alignment with user objectives over time

#### **Cross-Agent Evolution**
- **Method Sharing**: Adopt successful techniques from peer agents
- **Coordination Improvement**: Enhance inter-agent collaboration patterns
- **Knowledge Transfer**: Apply insights from one domain to another
- **Ecosystem Optimization**: Improve overall agent network performance

---

## Agent Recall and Reuse Protocols

### **Recall Decision Framework**
SuperAgent 0 evaluates whether to recall existing agent or create new one:

#### **Recall Criteria**
- **Task Similarity**: >70% overlap with previous agent missions
- **Domain Expertise**: Existing agent has relevant experience
- **Performance History**: Previous successful outcomes in similar contexts
- **Evolution Value**: Agent has learned patterns applicable to current task

#### **Adaptation Process**
```
1. Identify Best Match → Analyze agent evolution history
2. Context Analysis → Assess current task requirements
3. Adaptation Planning → Design customizations for current needs
4. Evolution Update → Modify brief.md with new adaptation
5. Deployment → Execute with enhanced capabilities
```

### **Evolution Tracking System**

#### **Performance Metrics**
- **Task Success Rate**: Completion quality and timeliness
- **User Satisfaction**: Feedback scores and preference alignment
- **Adaptation Effectiveness**: Improvement in performance over time
- **Cross-Task Transfer**: Successful application of learned patterns

#### **Learning Indicators**
- **Pattern Recognition**: Identification of successful approaches
- **Method Refinement**: Improvement in technique execution
- **Context Adaptation**: Effective adjustment to new requirements
- **Integration Success**: Seamless coordination with other agents

---

## Advanced Evolution Features

### **Evolutionary Intelligence**
- **Predictive Adaptation**: Anticipate user needs based on pattern history
- **Proactive Optimization**: Continuously improve methods between deployments
- **Strategic Learning**: Develop long-term expertise in specialized domains
- **Ecosystem Enhancement**: Contribute to overall agent network intelligence

### **Quality Assurance Evolution**
- **Self-Monitoring**: Agents track their own performance and identify improvement areas
- **Peer Review**: Agents learn from each other's successes and challenges
- **User Feedback Integration**: Continuous improvement based on user preferences
- **Standard Evolution**: Quality standards improve over time through experience

### **Memory Integration**
- **Critical Findings**: Evolution insights contribute to memory/critical-findings.md
- **Pattern Library**: Successful approaches stored for cross-agent access
- **Context Awareness**: Agents understand project history and user preferences
- **Strategic Memory**: Long-term learning contributes to strategic decision-making

---

**Agent Evolution Status**: Fluid learning system operational - Agents now evolve through experience, learn from each other, and adapt to user preferences for continuously improving performance.