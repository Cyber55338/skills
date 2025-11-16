---
name: Planning Mode
description: Activate focused planning mode for complex tasks. Use when you need to break down work into structured steps, create implementation plans, analyze requirements before coding, or map out project architecture. Triggers on "plan", "planning mode", "break down", "strategy", "approach".
---

# Planning Mode Skill

## Overview
A structured planning framework that helps you think through complex tasks systematically before jumping into implementation. Ideal for breaking down requirements, designing solutions, and creating actionable roadmaps.

## When to Use Planning Mode

Activate this skill when you need to:
- **Break down complex tasks** into manageable steps
- **Design system architecture** before implementation
- **Analyze requirements** and identify dependencies
- **Map out project workflows** and timelines
- **Evaluate multiple approaches** before choosing one
- **Create implementation roadmaps** for features
- **Think through edge cases** and potential issues

## Planning Mode Process

### Phase 1: Problem Understanding
**Goal:** Clearly define what needs to be accomplished

Questions to answer:
- What is the core objective?
- What are the success criteria?
- What constraints exist (time, resources, technology)?
- Who are the stakeholders?
- What's the scope (what's included/excluded)?

### Phase 2: Context Analysis
**Goal:** Understand the current state and environment

Examine:
- Existing codebase structure
- Available tools and frameworks
- Dependencies and integrations
- Technical debt or limitations
- Team capabilities and expertise

### Phase 3: Approach Exploration
**Goal:** Generate and evaluate multiple solutions

For each potential approach:
- **Pros**: Advantages and strengths
- **Cons**: Disadvantages and risks
- **Complexity**: Implementation difficulty
- **Timeline**: Estimated effort
- **Trade-offs**: What you gain vs. what you sacrifice

Generate 2-5 viable approaches, then select the best fit.

### Phase 4: Step-by-Step Breakdown
**Goal:** Create an actionable implementation plan

Structure the plan with:
1. **Numbered steps** in logical sequence
2. **Dependencies** between steps
3. **Validation points** (how to verify each step)
4. **Potential blockers** and mitigation strategies
5. **Estimated effort** per step (optional)

### Phase 5: Risk Assessment
**Goal:** Identify what could go wrong

Consider:
- **Technical risks**: Integration issues, performance, compatibility
- **Timeline risks**: Underestimation, scope creep
- **Resource risks**: Missing expertise, tool limitations
- **Quality risks**: Testing gaps, edge cases

For each risk, document:
- Likelihood (Low/Medium/High)
- Impact (Low/Medium/High)
- Mitigation strategy

### Phase 6: Implementation Readiness Check
**Goal:** Confirm you're ready to execute

Verify:
- [ ] All requirements are clear
- [ ] Architecture decisions are made
- [ ] Dependencies are identified
- [ ] Steps are sequenced logically
- [ ] Success criteria are defined
- [ ] Major risks are understood

## Output Format

Planning Mode produces a structured plan document:

```markdown
# Plan: [Task Name]

## 1. Problem Statement
[Clear description of what needs to be accomplished]

## 2. Context
- Current state: [What exists now]
- Target state: [What we want to achieve]
- Constraints: [Limitations to work within]

## 3. Approach
**Chosen Strategy:** [Selected approach name]

**Why this approach:**
- [Reason 1]
- [Reason 2]
- [Reason 3]

**Alternatives considered:**
1. [Alternative 1] - Rejected because [reason]
2. [Alternative 2] - Rejected because [reason]

## 4. Implementation Steps

### Step 1: [Step name]
- **Action:** [What to do]
- **Output:** [What gets created]
- **Validation:** [How to verify success]
- **Estimated effort:** [Time estimate]

### Step 2: [Step name]
[...repeat for each step...]

## 5. Dependencies & Order
- Step X must complete before Step Y because [reason]
- [Map out critical path]

## 6. Risks & Mitigation
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | Medium | High | [Strategy] |
| [Risk 2] | Low | Medium | [Strategy] |

## 7. Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## 8. Ready to Execute?
[Summary of readiness assessment]
```

## Best Practices

### DO:
- **Start with "why"**: Understand the purpose before diving into "how"
- **Think in layers**: High-level first, then drill down
- **Consider alternatives**: Don't lock into the first idea
- **Identify dependencies**: Understand what must happen in what order
- **Plan for unknowns**: Leave buffer for discoveries during implementation
- **Document assumptions**: Make implicit knowledge explicit

### DON'T:
- **Over-plan**: Don't spend more time planning than implementing
- **Assume perfection**: Plans change; that's normal
- **Skip validation**: Each step should have a verification point
- **Ignore constraints**: Work within realistic boundaries
- **Plan in isolation**: Consider how your work fits the bigger picture

## Planning Mode vs. Execution Mode

| Aspect | Planning Mode | Execution Mode |
|--------|---------------|----------------|
| Focus | Strategy & design | Implementation & delivery |
| Output | Plan document | Working code/artifacts |
| Mindset | Exploratory | Determined |
| Changes | Expected & welcomed | Managed carefully |
| Detail | High-level with key details | Implementation-level |

## Transitions

**From Planning to Execution:**
When the plan is complete and reviewed, transition with:
```
Plan approved. Transitioning to execution mode.
Starting with Step 1: [step name]
```

**From Execution back to Planning:**
If you encounter blockers or need to redesign:
```
Pausing execution. Returning to planning mode to address [issue].
```

## Integration with Other Skills

Planning Mode works well with:
- **MetaCognitive Flow**: For deep reasoning about complex architectural decisions
- **BMAD Workflows**: For software development planning aligned with BMAD methodology
- **Todo Management**: Plans naturally map to todo lists for tracking

## Instructions for Claude

When this skill is activated:

### CRITICAL: Plan Mode Integration

**This skill integrates with Claude Code's built-in plan mode system.**

1. **When skill activates**: You are automatically in planning mode
2. **During planning**: Focus on analysis, exploration, and design (NO code execution)
3. **When plan is complete**: Use the `ExitPlanMode` tool with your structured plan
4. **After user approval**: Transition to execution mode with TodoWrite

**The ExitPlanMode tool handles:**
- Presenting the complete plan to the user
- Requesting approval before any code changes
- Proper permission mode transitions
- Ensuring `--permission-mode plan` is respected

**NEVER start implementing code while in Planning Mode. Always use ExitPlanMode first.**

### Planning Process Flow:

1. **Acknowledge** the activation of Planning Mode with: `[Planning Mode] Activated`
2. **Understand the problem** using Phase 1 questions
3. **Analyze context** by examining relevant files/documentation (if needed)
4. **Explore approaches** and present 2-3 viable options with pros/cons
5. **Wait for user input** on approach selection (if multiple good options exist)
6. **Break down into steps** using Phase 4 framework
7. **Assess risks** systematically
8. **Present the complete plan** in structured format
9. **Use ExitPlanMode tool** to present the final plan and prompt user for approval
10. **After approval, use TodoWrite** to track implementation steps

### Planning Mode Indicators

While in Planning Mode:
1. **Prefix messages** with: `[Planning Mode] ...`
2. **Stay in plan mode** throughout the entire planning process
3. **Use ExitPlanMode tool** when the plan is complete

The ExitPlanMode tool will:
- Present your structured plan to the user
- Request approval before transitioning to execution
- Ensure proper permission mode handling

### Plan Completion Flow

When planning is complete:
1. **Call ExitPlanMode** with the complete plan as parameter
2. **Wait for user response** (approve/revise/cancel)
3. **If approved**: Begin execution with TodoWrite
4. **If revise**: Return to planning mode for adjustments
5. **If cancel**: Exit gracefully

### Key Principles

1. **Clarity over speed**: Take time to think things through
2. **Options over mandates**: Present choices, don't dictate solutions
3. **Pragmatism over perfection**: Plans should be good enough, not perfect
4. **Visibility over mystery**: Make your reasoning transparent
5. **Adaptability over rigidity**: Plans are guides, not contracts

## Example Invocations

**User says:**
- "Let's plan this out first"
- "I need to think through the approach"
- "Help me break this down"
- "What's our strategy for implementing X?"
- "Before we code, let's map out the architecture"
- "Planning mode: design the authentication system"

**Skill activates and responds:**
```
[Planning Mode] Activated

Let me help you think through this systematically.

First, let me understand the problem...
[Continues with Phase 1]
```

### Complete Example Workflow

```
User: "Planning mode: Add a comment system to the blog"

Claude: [Planning Mode] Activated

Let me help you plan the comment system implementation.

## 1. Problem Statement
Add threaded comments to blog posts with:
- User authentication
- Reply functionality
- Moderation capabilities
- Spam prevention

## 2. Context Analysis
[Claude reads relevant files, analyzes codebase]

## 3. Approach Options
**Option A:** REST API with PostgreSQL
- Pros: Traditional, well-understood, good tooling
- Cons: More boilerplate, separate queries for threads
- Complexity: Medium

**Option B:** GraphQL with MongoDB
- Pros: Flexible queries, nested comments natural
- Cons: More complex setup, team learning curve
- Complexity: High

**Option C:** REST API with MongoDB + aggregation
- Pros: Flexible schema, good for hierarchical data
- Cons: Complex aggregation queries
- Complexity: Medium

Recommendation: Option A (REST + PostgreSQL) for team familiarity

## 4. Implementation Steps
[Detailed breakdown of 8-10 steps]

## 5. Risks & Mitigation
[Risk assessment table]

## 6. Success Criteria
[Checklist of completion criteria]

[Claude calls ExitPlanMode tool with the complete plan]

Claude: I've completed the planning phase. The plan includes:
- Complete architecture design
- 8 implementation steps
- Risk mitigation strategies
- Clear success criteria

Ready to proceed with implementation?

User: "Yes, let's do it"

Claude: [Exits plan mode, creates todos, begins implementation]
```

## Meta Notes

Planning Mode is deliberately structured but flexible. The goal is to:
- Reduce "code first, think later" mistakes
- Surface hidden complexity early
- Create shared understanding
- Make better architectural decisions
- Build confidence before committing

Good planning leads to faster, more reliable execution.

---

**Remember:** The best plan is one that gets you started effectively, not one that perfectly predicts every detail. Plan enough to de-risk the work, then adapt as you learn.
