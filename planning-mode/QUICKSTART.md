# Planning Mode - Quick Start Guide

## 🚀 What You Need to Know

**Planning Mode** is a Claude Code skill that helps you think before you code. It enforces structured planning with automatic approval gates before any code changes.

## ⚡ 3-Second Start

Just say:
```
"Planning mode: [describe what you want to build]"
```

That's it! Claude will guide you through planning, then ask for approval before implementing.

## 📋 Complete Flow (30 seconds)

```
1. YOU:    "Planning mode: add user authentication"
2. CLAUDE: [Planning Mode] Activated - analyzes problem
3. CLAUDE: Shows 2-3 approaches with pros/cons
4. CLAUDE: Generates structured implementation plan
5. CLAUDE: Calls ExitPlanMode - asks for approval
6. YOU:    "Yes, let's do it"
7. CLAUDE: Creates todos and starts implementing
```

## 🎯 When to Use It

**Use Planning Mode when:**
- Building a new feature (more than 1 file)
- Making architectural decisions
- Refactoring complex code
- Unsure of the best approach
- Working on something unfamiliar

**Skip Planning Mode for:**
- Simple bug fixes
- One-line changes
- Trivial updates
- Well-understood tasks

## 💡 Example Conversations

### Example 1: New Feature
```
You: "Planning mode: I need to add a comment system to my blog"

Claude: [Planning Mode] Activated

Let me plan the comment system implementation.

## 1. Problem Statement
Add threaded comments with moderation

## 2. Approach Options
A) REST + PostgreSQL (recommended)
B) GraphQL + MongoDB
C) Firebase Realtime DB

Choosing A for team familiarity and proven patterns.

## 3. Implementation Steps
1. Create comments table schema
2. Build REST endpoints (CRUD)
3. Add frontend components
4. Implement reply threading
5. Add moderation panel
6. Write tests

## 4. Risks
- Spam handling: Use rate limiting + captcha
- Performance: Index by post_id and parent_id

[Calls ExitPlanMode]

Ready to implement?

You: "Yes"

Claude: [Creates 6 todos, starts with step 1]
```

### Example 2: Architectural Decision
```
You: "Planning mode: should I use Redux or Context API?"

Claude: [Planning Mode] Activated

Let me analyze this state management decision.

## Analysis

**Your app characteristics:**
- 15 components
- 3 shared data pieces
- No complex async flows

**Option A: Context API**
Pros: Built-in, simple, sufficient for your scale
Cons: Can cause unnecessary re-renders
Recommendation: ✅ Best fit

**Option B: Redux**
Pros: Powerful, great dev tools
Cons: Overkill for your needs, more boilerplate
Recommendation: ❌ Too heavy

## Plan
Use Context API with these steps:
1. Create AuthContext
2. Create ThemeContext
3. Wrap app in providers
4. Convert components to use contexts

[Calls ExitPlanMode]

You: "Agreed, let's go with Context"

Claude: [Implements the plan]
```

## 🔧 Key Features

### 1. **Automatic Activation**
No commands to remember. Just say "plan", "strategy", "break down" and it activates.

### 2. **Multiple Approaches**
You always get 2-3 options with honest pros/cons. No bias toward complexity.

### 3. **Risk Assessment**
Every plan includes "what could go wrong" and mitigation strategies.

### 4. **Approval Gates**
Uses ExitPlanMode tool - you MUST approve before any code changes happen.

### 5. **Todo Integration**
Approved plans automatically become tracked todo items.

## 🛡️ Safety Features

**During Planning (Read-Only):**
- ✅ Can read your code
- ✅ Can analyze structure
- ✅ Can explore approaches
- ❌ Cannot modify files
- ❌ Cannot execute code
- ❌ Cannot change system state

**After Approval (Execution):**
- ✅ Everything allowed
- ✅ Changes are tracked
- ✅ Todos show progress

## 🔄 Revising Plans

Changed your mind? No problem:

```
You: "Actually, let's use PostgreSQL instead of MongoDB"

Claude: [Planning Mode] Reactivated

Updating database choice...

[Shows updated plan with PostgreSQL]
[Calls ExitPlanMode again]

Ready with updated plan?
```

## 📊 What You Get

Every plan includes:

1. **Problem Statement** - What we're solving
2. **Context** - Current state & constraints
3. **Approaches** - 2-3 options evaluated
4. **Steps** - Detailed implementation roadmap
5. **Dependencies** - What needs to happen when
6. **Risks** - What could go wrong + fixes
7. **Success Criteria** - How to know it's done

## 🆚 vs Other Planning Tools

| Feature | Planning Mode | Manual Planning | Other Tools |
|---------|--------------|-----------------|-------------|
| Automatic activation | ✅ | ❌ | Varies |
| Multiple approaches | ✅ | Maybe | ❌ |
| Risk assessment | ✅ | Rarely | ❌ |
| Approval gates | ✅ | ❌ | ❌ |
| Todo integration | ✅ | Manual | Manual |
| Permission safety | ✅ | ❌ | ❌ |

## 🤔 Common Questions

**Q: Do I have to use "planning mode:" exactly?**
A: Nope! Also works: "let's plan", "help me break down", "what's our strategy"

**Q: Can I skip straight to coding?**
A: Yes! Planning Mode only activates if you invoke it. Regular requests work as before.

**Q: What if I disagree with the plan?**
A: Say "revise" or "I want a different approach". Claude will adjust.

**Q: Can I use this with BMAD or other workflows?**
A: Absolutely! Planning Mode works alongside other skills.

**Q: Is this the same as MetaCognitive Flow?**
A: No - that's for deep strategic thinking. This is for practical day-to-day planning.

## 🎓 Pro Tips

1. **Be specific**: "Planning mode: add OAuth login" > "Planning mode: add auth"

2. **Mention constraints**: "Planning mode with 2-day timeline: add search"

3. **Share context**: "Planning mode: refactor auth system (currently using JWT)"

4. **Ask questions**: During planning, ask "what about X?" to refine

5. **Iterate**: Approve → implement → learn → plan next feature better

## 📁 Files Structure

```
~/.claude/skills/planning-mode/
├── SKILL.md              # Main skill (Claude reads this)
├── README.md             # Quick reference
├── QUICKSTART.md         # This file
├── CHANGELOG.md          # Version history
└── INTEGRATION-GUIDE.md  # Technical details
```

## 🔗 Related Skills

- **MetaCognitive Flow** - Deep reasoning for complex decisions
- **BMAD Workflows** - Full software development methodology
- **Todo Management** - Track implementation progress

## 🐛 Troubleshooting

**Skill didn't activate?**
- Try: "Planning mode: [task]" (more explicit)
- Check: `ls ~/.claude/skills/planning-mode/`

**Claude started coding without approval?**
- Shouldn't happen! Report this as a bug
- ExitPlanMode should gate all changes

**Want to exit planning?**
- Say "cancel" or "never mind"
- No changes will be made

## 🎉 Success Stories

**Scenario:** Building a new API endpoint
- **Without Planning Mode:** 2 hours coding, discovered missed requirements, had to refactor
- **With Planning Mode:** 10 min planning, caught issues early, 1 hour smooth implementation

**Scenario:** Choosing between frameworks
- **Without Planning Mode:** Went with familiar choice, regretted it later
- **With Planning Mode:** Saw trade-offs clearly, made informed decision, no regrets

## 🚀 Try It Now!

Ready to test? Try this:

```
You: "Planning mode: add a dark mode toggle to my app"
```

Claude will:
1. Analyze your app structure
2. Present implementation approaches
3. Generate a detailed plan
4. Ask for your approval
5. Implement with confidence

---

**Remember:** Good planning = faster implementation + fewer surprises

**Questions?** Just ask Claude: "How does planning mode work?"

**Version:** 1.1.0 | **Updated:** 2025-10-22
