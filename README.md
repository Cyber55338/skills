# BMAD Method v6 - Claude Skills Integration

**Version:** 6.0.0-alpha
**Created:** 2025-10-19
**Status:** Active
**Type:** Progressive Disclosure Skills Library

---

## 📚 Overview

This Skills library implements the complete BMAD (Build-Measure-Adapt-Deploy) Method v6 using Anthropic's Claude Skills architecture with progressive disclosure. Skills auto-activate based on conversation context, providing token-efficient access to BMAD's comprehensive software development methodology.

### What is BMAD Method v6?

BMAD is a **Collaboration Optimized Reflection Engine (CORE)** - a framework that brings out the best in humans through AI agents designed to enhance thinking rather than replace it. The method encompasses:

- **4 Phases:** Analysis → Planning → Solutioning → Implementation
- **10 Specialized Agents:** PM, SM, Dev, Architect, Analyst, Tea, UX Expert, Game roles
- **34 Workflows:** Covering full SDLC from brainstorming to retrospectives
- **Scale-Adaptive:** Works for single bug fixes (Level 0) to enterprise platforms (Level 4)

### Why Skills vs Slash Commands?

**Token Efficiency:**
- **Slash Commands:** Load full agent (~2000-3000 tokens) on invocation
- **Skills:** Load metadata only (~50 tokens) until needed
- **Savings:** 98%+ reduction in idle token usage

**Auto-Activation:**
- **Slash Commands:** User must type `/pm`, `/dev`, etc.
- **Skills:** Auto-detect from natural conversation
- **UX:** More natural, conversational interaction

**Complementary:**
- Skills don't replace slash commands
- Both available based on user preference
- Same quality output, different activation methods

---

## 🏗️ Architecture

### Progressive Disclosure Strategy

```
Level 1: METADATA (Always Loaded)
├─ name + description only
├─ ~50 tokens per Skill
├─ 45 Skills × 50 tokens = 2,250 tokens total
└─ Enables auto-detection

Level 2: INSTRUCTIONS (Loaded When Triggered)
├─ Full SKILL.md content
├─ ~500-2500 tokens per Skill
└─ Provides execution logic

Level 3: RESOURCES (Loaded As Needed)
├─ Templates, scripts, reference docs
├─ BMAD config, workflow YAML
└─ Variable tokens based on usage
```

**Result:** 99% token reduction when Skills are idle

### Directory Structure

```
~/.claude/skills/
├── bmad-core/                  # Core system Skills
│   ├── bmad-orchestrator/     # Main coordinator
│   ├── bmad-config-manager/    # Configuration management
│   └── bmad-workflow-status/   # Status checking
│
├── bmad-agents/                # 10 Agent Skills
│   ├── bmad-pm/               # Product Manager (John)
│   ├── bmad-sm/               # Scrum Master (Alex)
│   ├── bmad-dev/              # Developer (Amelia)
│   ├── bmad-architect/         # Architect (Sophia)
│   ├── bmad-analyst/           # Analyst (Maya)
│   ├── bmad-tea/              # Tech Engineering Assistant (Kai)
│   ├── bmad-ux-expert/        # UX Expert (Jordan)
│   ├── bmad-game-architect/    # Game Architect
│   ├── bmad-game-designer/     # Game Designer
│   └── bmad-game-dev/         # Game Developer
│
├── bmad-workflows/             # 34 Workflow Skills
│   ├── 1-analysis/            # 7 Analysis workflows
│   │   ├── bmad-brainstorm-project/
│   │   ├── bmad-brainstorm-game/
│   │   ├── bmad-product-brief/
│   │   ├── bmad-game-brief/
│   │   ├── bmad-research/
│   │   ├── bmad-document-project/
│   │   └── bmad-workflow-status/
│   ├── 2-planning/            # 6 Planning workflows
│   │   ├── bmad-prd/
│   │   ├── bmad-gdd/
│   │   ├── bmad-narrative/
│   │   ├── bmad-tech-spec-sm/
│   │   ├── bmad-ux-spec/
│   │   └── bmad-plan-project/
│   ├── 3-solutioning/         # 2 Solutioning workflows
│   │   ├── bmad-solution-architecture/
│   │   └── bmad-tech-spec/
│   └── 4-implementation/       # 19 Implementation workflows
│       ├── bmad-create-story/
│       ├── bmad-dev-story/
│       ├── bmad-story-context/
│       ├── bmad-review-story/
│       ├── bmad-story-ready/
│       ├── bmad-story-approved/
│       ├── bmad-correct-course/
│       ├── bmad-retrospective/
│       └── bmad-testarch/     # 8 test architecture Skills
│
└── bmad-integrations/          # Integration Skills
    ├── bmad-docx-pro/         # Word document generation
    ├── bmad-xlsx-metrics/     # Excel spreadsheets
    ├── bmad-pptx-presentation/# PowerPoint slides
    └── bmad-mcp-bridge/       # MCP server integration
```

---

## 🎯 Core Skills

### 1. BMAD Orchestrator (`bmad-core/bmad-orchestrator/`)

**Purpose:** Main coordinator for all BMAD workflows

**Auto-Activates When:**
- User mentions "BMAD", "workflow", or references agents
- Discusses project planning, PRD, tech specs
- Asks about workflow status or next steps

**Key Features:**
- Loads BMAD configuration
- Executes workflow.xml engine
- Coordinates multi-phase processes
- Routes to appropriate agents/workflows

**Files:**
- `SKILL.md` - Main skill definition
- `scripts/config-loader.sh` - Configuration loader
- `scripts/workflow-executor.sh` - Workflow execution

### 2. BMAD Product Manager (`bmad-agents/bmad-pm/`)

**Agent:** John (Investigative Product Strategist)

**Auto-Activates When:**
- User mentions PRD, planning, requirements
- Discusses features, prioritization, roadmap
- Asks for PM guidance

**Capabilities:**
- Product planning (scale-adaptive, Levels 0-4)
- Product brief creation
- Course correction analysis
- Workflow status checking

**Workflows:**
- `/plan-project` - Adaptive planning
- `/product-brief` - Product vision
- `/correct-course` - Mid-sprint changes
- `/workflow-status` - Project state

### 3. BMAD Developer (`bmad-agents/bmad-dev/`)

**Agent:** Amelia (Senior Implementation Engineer)

**Auto-Activates When:**
- User mentions implement, code, develop
- Discusses user stories or development
- References testing or implementation

**Capabilities:**
- Story implementation (continuous until 100% done)
- Story creation from PRD/epics
- Story Context XML assembly
- Code review
- Test-driven development

**Key Principles:**
- Story Context is single source of truth
- 100% test coverage of acceptance criteria
- No shortcuts, no lies about tests
- Reuse existing patterns

**Workflows:**
- `/develop` - Implement stories
- `/create-story` - Create next story
- `/story-context` - Generate Story Context XML
- `/review` - Code review
- `/story-ready` - Mark story ready
- `/story-approved` - Mark story complete

### 4. BMAD PRD Generator (`bmad-workflows/2-planning/bmad-prd/`)

**Purpose:** Generate Product Requirements Documents

**Auto-Activates When:**
- User mentions "PRD", "requirements document"
- Needs to document product features
- References product specification

**Scale-Adaptive:**
- Level 0: Routes to tech-spec-sm (no PRD needed)
- Level 1: Focused PRD (2-3 pages)
- Level 2: Standard PRD (5-8 pages)
- Level 3: Comprehensive PRD (10-15 pages)
- Level 4: Full PRD with Epics (20+ pages)

**Output:**
- `{BMAD_OUTPUT}/docs/PRD-{PROJECT_NAME}.md`
- Optional: DOCX, PDF formats

**Templates:**
- `templates/prd-level-1-2.md` - For simple/medium projects
- `templates/prd-level-3-4.md` - For complex/enterprise projects

---

## 🚀 Quick Start

### For Users (Conversation)

Just talk naturally! Skills auto-activate based on what you're discussing:

```
User: "I need to create a PRD for my mobile app"
→ bmad-prd Skill activates automatically
→ Guides you through requirements gathering
→ Generates professional PRD document

User: "Let's implement the login feature"
→ bmad-dev Skill activates
→ Checks for approved story
→ Loads Story Context
→ Implements with 100% test coverage

User: "What should we work on next?"
→ bmad-workflow-status Skill activates
→ Analyzes project state
→ Suggests next logical step
```

### For Developers (Setup)

Skills are already installed at `~/.claude/skills/`. Claude Code automatically:
1. Loads all skill metadata on startup (~2,250 tokens)
2. Watches conversations for trigger keywords
3. Loads full skills when relevant
4. Executes workflows as needed

No manual activation required!

---

## 📖 Usage Patterns

### Pattern 1: Start New Project

```
Conversation Flow:
User: "I want to build a fitness tracking app"

Skills Activated:
1. bmad-workflow-status checks project state
2. Suggests: Start with brainstorming
3. bmad-brainstorm-project activates
4. After brainstorming, suggests product brief
5. bmad-product-brief activates
6. After brief, suggests PRD
7. bmad-prd activates
8. After PRD, routes to bmad-architect

Result: Guided through full Analysis → Planning flow
```

### Pattern 2: Continue Existing Project

```
User: "What's next for my project?"

bmad-workflow-status activates:
- Reads bmad/_output/ folder
- Analyzes completeness:
  ✓ Product Brief done
  ✓ PRD done
  ✓ Architecture done
  ✗ User stories missing
- Suggests: Create user stories with /create-story
```

### Pattern 3: Development Sprint

```
User: "Let's start the sprint"

Flow:
1. bmad-workflow-status: Check stories exist
2. bmad-story-ready: Mark story IN PROGRESS
3. bmad-story-context: Generate Story Context XML
4. bmad-dev: Implement story (continuous)
5. bmad-review-story: Code review
6. bmad-story-approved: Mark DONE
7. Repeat for next story
```

---

## 🔧 Configuration

### BMAD Configuration File

Location: `bmad/core/config.yaml`

```yaml
userName: Developer
communication_language: English
output_folder: '{project-root}/docs'
```

**Usage by Skills:**
- All Skills load this configuration
- `userName` - Used in greetings and authorship
- `communication_language` - All outputs in this language
- `output_folder` - Where artifacts are saved

### Skill Configuration

Each Skill's `SKILL.md` has YAML frontmatter:

```yaml
---
name: Skill Name
description: When to activate this Skill and what it does...
---
```

**Only two fields supported:**
- `name`: Human-friendly name (max 64 chars)
- `description`: Activation triggers + capabilities (max 1024 chars)

---

## 🎨 Auto-Activation Logic

### How Skills Activate

Claude scans your message for keywords in the `description`:

**Example:** `bmad-prd` Skill
```yaml
description: Generate Product Requirements Documents following BMAD Method v6.
Activates when user mentions PRD, product requirements document, requirements
specification, or needs to document product features and specifications.
```

**Triggers:**
- "I need a PRD" ✓
- "Create product requirements" ✓
- "Document our features" ✓
- "What's a PRD?" ✓
- "Random conversation" ✗

### Activation Priority

When multiple Skills match:
1. **Most specific** wins (e.g., bmad-prd over bmad-orchestrator)
2. **Context-aware** (phase-appropriate Skills)
3. **User intent** (what are they trying to achieve?)

### Preventing False Activations

Skills use specific, action-oriented keywords:
- ✓ "create PRD", "generate requirements"
- ✗ "PRD" alone might be too broad

Description should include:
- **What** the Skill does
- **When** it should activate
- **Keywords** that indicate user intent

---

## 📊 Skills Inventory

### Core System (3 Skills)
- `bmad-orchestrator` - Main coordinator
- `bmad-config-manager` - Configuration
- `bmad-workflow-status` - Status checking

### Agents (10 Skills)
- `bmad-pm` - Product Manager
- `bmad-sm` - Scrum Master
- `bmad-dev` - Developer
- `bmad-architect` - Architect
- `bmad-analyst` - Analyst
- `bmad-tea` - Technical Engineering Assistant
- `bmad-ux-expert` - UX Expert
- `bmad-game-architect` - Game Architect
- `bmad-game-designer` - Game Designer
- `bmad-game-dev` - Game Developer

### Workflows (34 Skills)
**Analysis Phase (7):**
- brainstorm-project, brainstorm-game, product-brief, game-brief, research, document-project, workflow-status

**Planning Phase (6):**
- prd, gdd, narrative, tech-spec-sm, ux-spec, plan-project

**Solutioning Phase (2):**
- solution-architecture, tech-spec

**Implementation Phase (19):**
- create-story, dev-story, story-context, review-story, story-ready, story-approved, correct-course, retrospective
- Test Architecture (8): testarch-plan, testarch-atdd, testarch-framework, testarch-automate, testarch-ci, testarch-gate, testarch-nfr, testarch-trace

### Integrations (4 Skills)
- `bmad-docx-pro` - Word documents
- `bmad-xlsx-metrics` - Excel spreadsheets
- `bmad-pptx-presentation` - PowerPoint slides
- `bmad-mcp-bridge` - MCP server integration

**Total: 51 Skills**

---

## 🔌 Integration with External Tools

### MCP Servers

`bmad-mcp-bridge` connects BMAD workflows with Model Context Protocol servers:

**Current Integration:**
- `mobile-mcp` - Mobile development tools

**Potential Integrations:**
- Database servers (PostgreSQL, MongoDB)
- Cloud platforms (AWS, Google Cloud)
- Development tools (GitHub, Jira)
- Testing frameworks

### Document Generation

**Anthropic Skills (via plugins):**
- Install: `/plugin install docx@anthropics/skills`
- Use: Automatically via `bmad-docx-pro` Skill

**Benefits:**
- Professional formatting
- BMAD branding
- Template-based generation
- Multiple output formats

---

## 📈 Token Efficiency Comparison

### Scenario: User asks about creating a PRD

**Without Skills (Slash Command `/prd`):**
```
System Prompt: 500 tokens
Agent Persona: 2,000 tokens
Workflow YAML: 800 tokens
Templates: 1,500 tokens
TOTAL: 4,800 tokens loaded immediately
```

**With Skills:**
```
Level 1 (Idle): 50 tokens (metadata only)
Level 2 (Activated): 2,500 tokens (SKILL.md)
Level 3 (Templates): 1,500 tokens (when used)
TOTAL: 50 tokens until needed, 4,050 max
```

**Savings:**
- Idle: 99% reduction (4,800 → 50 tokens)
- Active: 16% reduction (4,800 → 4,050 tokens)
- With 45 Skills idle: 216,000 → 2,250 tokens (99% reduction)

---

## 🎓 Best Practices

### For Users

**DO:**
- Describe what you want naturally
- Mention specific artifacts ("I need a PRD")
- Ask about next steps
- Reference phases ("we're in planning")

**DON'T:**
- Need to know Skill names
- Manually activate Skills
- Remember slash commands (though they still work!)

### For Skill Authors

**DO:**
- Write specific, action-oriented descriptions
- Include clear activation keywords
- Use progressive disclosure (minimal frontmatter)
- Test with various phrasings

**DON'T:**
- Use vague descriptions
- Load everything upfront
- Duplicate existing Skills
- Forget to document

---

## 🔍 Troubleshooting

### Skill Not Activating

**Problem:** Mentioned "PRD" but `bmad-prd` didn't activate

**Solutions:**
1. Be more specific: "I need to create a PRD"
2. Include action: "generate product requirements"
3. Add context: "document product features"
4. Fallback: Use slash command `/prd`

### Wrong Skill Activated

**Problem:** Wanted PRD, got product brief

**Solutions:**
1. Clarify intent: "I need a detailed PRD, not just a brief"
2. Reference phase: "We're past brainstorming, time for planning"
3. Manual override: Use `/prd` slash command

### Configuration Not Loading

**Problem:** Skill can't find BMAD config

**Solutions:**
1. Check file exists: `bmad/core/config.yaml`
2. Verify you're in project directory
3. Check file permissions
4. Use absolute path in Skill if needed

---

## 📚 Documentation

### Skill-Specific Docs

Each Skill has detailed documentation in its `SKILL.md`:
- Purpose and capabilities
- Auto-activation keywords
- Workflow execution patterns
- Examples and use cases
- Integration points
- Best practices

### BMAD Method Docs

- **GitHub:** https://github.com/bmad-code-org/BMAD-METHOD
- **Discord:** https://discord.gg/gk8jAdXWmj
- **YouTube:** https://www.youtube.com/@BMadCode

### Anthropic Skills Docs

- **Official Docs:** https://docs.claude.com/en/docs/agents-and-tools/agent-skills
- **GitHub:** https://github.com/anthropics/skills

---

## 🚀 Future Enhancements

### Planned Skills
- [ ] bmad-api-designer - API specification
- [ ] bmad-database-modeler - Database design
- [ ] bmad-deployment - Deployment workflows
- [ ] bmad-monitoring - Production monitoring
- [ ] bmad-documentation - Auto-documentation

### Integration Expansions
- [ ] GitHub Actions integration
- [ ] Jira/Linear integration
- [ ] Figma/design tool integration
- [ ] Analytics and metrics
- [ ] AI-assisted code review

### Community Contributions
- [ ] Public Skill marketplace
- [ ] Skill templates
- [ ] Best practices library
- [ ] Example projects

---

## 📄 Version History

- **6.0.0-alpha (2025-10-19)**: Initial Skills implementation
  - 51 Skills covering full BMAD methodology
  - Progressive disclosure architecture
  - Auto-activation from conversation
  - Integration with slash commands
  - MCP server bridge
  - Document generation Skills

---

## 🤝 Contributing

To add new Skills to this library:

1. Create Skill directory: `~/.claude/skills/category/skill-name/`
2. Write `SKILL.md` with proper frontmatter
3. Add supporting resources (templates, scripts)
4. Test auto-activation thoroughly
5. Document in this README
6. Consider contributing to BMAD repo

---

## 📞 Support

**Issues:** GitHub Issues on BMAD-METHOD repo
**Discussions:** BMAD Discord community
**Email:** support@bmad-code.org (if available)

---

**Powered by BMAD-CORE™**
**Collaboration Optimized Reflection Engine**

*Bringing out the best in you through AI agents designed to enhance human thinking, not replace it.*
