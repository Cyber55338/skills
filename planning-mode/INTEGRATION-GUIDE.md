# Planning Mode - Claude Code Integration Guide

## Overview

This document explains how Planning Mode integrates with Claude Code's `--permission-mode plan` system and the `ExitPlanMode` tool.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    User Invocation                          │
│  "Planning mode: add feature X"                             │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Planning Mode Skill Activates                   │
│  - Auto-detected from keywords in description                │
│  - Claude loads SKILL.md instructions                        │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│            Planning Phase (Read-Only Mode)                   │
│  ✓ Analyze problem                                           │
│  ✓ Read files for context                                    │
│  ✓ Explore approaches                                        │
│  ✓ Generate structured plan                                  │
│  ✗ NO code execution                                         │
│  ✗ NO file modifications                                     │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│          ExitPlanMode Tool Invocation                        │
│  Claude calls: ExitPlanMode(plan="[structured plan]")       │
│  - Presents plan to user                                     │
│  - Requests approval                                         │
│  - Handles permission mode transition                        │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│              User Decision Point                             │
│  Options: approve / revise / cancel                          │
└──────────┬──────────────┬────────────────┬──────────────────┘
           │              │                │
    approve│       revise │         cancel │
           ▼              ▼                ▼
┌─────────────────┐ ┌──────────────┐ ┌─────────────────┐
│  Execution Mode │ │Return to Plan│ │  Exit Gracefully│
│  - TodoWrite    │ │  - Adjust    │ │                 │
│  - Implement    │ │  - Re-present│ │                 │
└─────────────────┘ └──────────────┘ └─────────────────┘
```

## Permission Modes

### Planning Mode (`--permission-mode plan`)

**What's Allowed:**
- ✅ Read files (`Read`, `Glob`, `Grep`)
- ✅ Analyze code structure
- ✅ Think through approaches
- ✅ Generate plan documents
- ✅ Use `ExitPlanMode` tool

**What's NOT Allowed:**
- ❌ Write/Edit files
- ❌ Execute code (`Bash`)
- ❌ Modify system state
- ❌ Install packages
- ❌ Use `TodoWrite` (until after approval)

### Execution Mode (after ExitPlanMode approval)

**What's Allowed:**
- ✅ Everything from Planning Mode
- ✅ Write/Edit files
- ✅ Execute commands
- ✅ Use TodoWrite
- ✅ Full implementation

## The ExitPlanMode Tool

### Purpose
Provides a clean transition gate between planning and execution, ensuring:
1. User sees the complete plan before any changes
2. User explicitly approves before implementation
3. Permission boundaries are respected
4. Clear communication of what will happen

### Usage in Planning Mode Skill

```markdown
## Instructions for Claude

When this skill is activated:

### Planning Process Flow:
1. **Acknowledge** Planning Mode activation
2. **Analyze** the problem and context
3. **Explore** multiple approaches
4. **Generate** structured plan
5. **Call ExitPlanMode** with the plan

Example:
```
[Planning Mode] Activated

[... planning process ...]

## Complete Plan

### 1. Problem Statement
[Clear description]

### 2. Approach
[Selected strategy with reasoning]

### 3. Implementation Steps
1. Step one with validation
2. Step two with validation
...

### 4. Risks & Mitigation
[Risk table]

[Calls ExitPlanMode tool with above plan]
```

### ExitPlanMode Parameters

```typescript
ExitPlanMode({
  plan: string  // The complete structured plan in markdown
})
```

**The plan should include:**
- Problem statement
- Context & constraints
- Chosen approach & alternatives
- Step-by-step breakdown
- Dependencies
- Risk assessment
- Success criteria

### What Happens After ExitPlanMode

1. **Tool Execution:**
   - Plan is formatted and presented to user
   - User sees: "Plan complete. Ready to begin implementation?"
   - Options: approve / revise / cancel

2. **User Approves:**
   - Claude exits plan mode
   - Permission mode changes to execution
   - Claude creates TodoWrite items
   - Implementation begins

3. **User Requests Revision:**
   - Claude stays in plan mode
   - Adjusts specific aspects
   - Calls ExitPlanMode again with updated plan

4. **User Cancels:**
   - Claude exits plan mode
   - No implementation occurs
   - Conversation continues normally

## Integration Points

### 1. Skill Activation

**Trigger Keywords in Description:**
```yaml
description: ... Use when you need to break down work into structured steps,
create implementation plans, analyze requirements before coding, or map out
project architecture. Triggers on "plan", "planning mode", "break down",
"strategy", "approach".
```

**User Phrases That Activate:**
- "Let's plan this out first"
- "Planning mode: [task]"
- "What's our strategy for..."
- "Help me break down [feature]"
- "I need to think through the approach"

### 2. TodoWrite Integration

**After Approval:**
```javascript
// Claude automatically does:
TodoWrite({
  todos: [
    { content: "Step 1: ...", status: "pending", activeForm: "..." },
    { content: "Step 2: ...", status: "pending", activeForm: "..." },
    // ... all plan steps become todos
  ]
})
```

### 3. MetaCognitive Flow Integration

**For Complex Decisions:**
If planning reveals a complex architectural decision, Planning Mode can:
1. Identify the decision point
2. Suggest using MetaCognitive Flow for deeper analysis
3. Return to Planning Mode with insights

```
[Planning Mode] I've identified a critical architectural decision.
This would benefit from deeper cognitive analysis.

Recommending: Invoke MetaCognitive Flow to analyze:
- Trade-offs between approach A vs B
- Long-term implications
- System-wide impacts

Would you like me to activate MetaCognitive Flow for this decision?
```

## Best Practices

### For Users

**DO:**
- ✅ Invoke Planning Mode for non-trivial features
- ✅ Review the complete plan before approving
- ✅ Ask for revisions if something's unclear
- ✅ Use for architecture decisions

**DON'T:**
- ❌ Use for trivial one-step tasks
- ❌ Skip plan review
- ❌ Approve without understanding risks

### For Skill Authors

**DO:**
- ✅ Always call `ExitPlanMode` when plan is complete
- ✅ Structure plans clearly with markdown
- ✅ Include success criteria
- ✅ Document risks and mitigation
- ✅ Provide multiple approach options

**DON'T:**
- ❌ Execute code during planning phase
- ❌ Skip ExitPlanMode call
- ❌ Assume user approval
- ❌ Modify files before approval

## Testing the Integration

### Test Case 1: Basic Planning Flow

```bash
# User input
"Planning mode: add a search feature"

# Expected behavior
1. Skill activates with "[Planning Mode] Activated"
2. Claude analyzes requirements
3. Presents 2-3 approaches
4. Generates structured plan
5. Calls ExitPlanMode with plan
6. Waits for user approval
7. On approval: creates todos and starts implementation
```

### Test Case 2: Plan Revision

```bash
# User approves then says "wait, revise the database choice"

# Expected behavior
1. Claude returns to planning mode
2. Focuses on database decision
3. Presents alternatives
4. Updates plan
5. Calls ExitPlanMode with revised plan
6. Waits for approval again
```

### Test Case 3: Complex Decision Point

```bash
# During planning, Claude identifies complex trade-off

# Expected behavior
1. Planning Mode pauses
2. Suggests MetaCognitive Flow for deep analysis
3. User approves metacognitive analysis
4. Runs cognitive node flows
5. Returns to Planning Mode with insights
6. Completes plan with informed decision
7. Calls ExitPlanMode
```

## Troubleshooting

### Issue: Skill Doesn't Activate

**Problem:** Said "let's plan" but skill didn't activate

**Solution:**
- Be more explicit: "Planning mode: [specific task]"
- Use trigger keywords: "break down", "strategy"
- Check skill is installed: `ls ~/.claude/skills/planning-mode/`

### Issue: Code Execution During Planning

**Problem:** Claude started writing files during planning

**Solution:**
- This violates the skill's design
- Report as bug - planning should be read-only
- ExitPlanMode should gate all implementations

### Issue: ExitPlanMode Not Called

**Problem:** Claude presented plan but didn't use ExitPlanMode

**Solution:**
- Explicitly remind: "Please use ExitPlanMode tool"
- Check SKILL.md has proper instructions
- Ensure instructions emphasize the requirement

### Issue: No Todo List After Approval

**Problem:** Approved plan but no todos created

**Solution:**
- TodoWrite should happen after approval
- Check execution mode was entered
- Manually remind: "Create todos from the plan"

## Version History

### v1.1.0 (Current)
- ✅ ExitPlanMode integration
- ✅ Permission mode handling
- ✅ Enhanced workflow documentation
- ✅ Clear transition gates

### v1.0.0 (Initial)
- Basic planning framework
- No ExitPlanMode integration
- Manual approval process

## References

- **Claude Code Docs:** https://docs.claude.com/en/docs/claude-code
- **Skills Documentation:** https://docs.claude.com/en/docs/agents-and-tools/agent-skills
- **ExitPlanMode Tool:** Built-in Claude Code tool for plan transitions

## Support

For issues or questions:
1. Check this integration guide
2. Review SKILL.md for instructions
3. Test with simple examples first
4. Document unexpected behavior

---

**Summary:** Planning Mode + ExitPlanMode = Structured thinking with safe transitions to execution. The permission mode system ensures you always approve before code changes.
