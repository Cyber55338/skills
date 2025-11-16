# Planning Mode Skill - Quick Reference

## What is Planning Mode?

A lightweight skill that helps you structure your thinking before diving into implementation. Think of it as "measure twice, cut once" for coding.

## When to Use It

Use Planning Mode when you need to:
- Break down a complex feature into steps
- Design system architecture
- Evaluate different approaches
- Map out dependencies
- Think through edge cases

## How to Activate

Just say any of these phrases:
- "Let's plan this out first"
- "Planning mode: [describe task]"
- "Help me break this down"
- "What's our strategy for..."
- "I need to think through the approach"

## What You Get

Planning Mode produces:
1. **Problem Statement** - Clear definition of the goal
2. **Context Analysis** - Understanding of current state
3. **Approach Evaluation** - Multiple options with pros/cons
4. **Step-by-Step Plan** - Actionable implementation roadmap
5. **Risk Assessment** - What could go wrong and how to handle it
6. **Readiness Check** - Confirmation you're ready to execute

## Example Usage

```
You: "Planning mode: I need to add user authentication to the app"

Claude: [Planning Mode] Activated

Let me help you think through this systematically.

## 1. Problem Statement
We need to implement user authentication that allows users to:
- Register new accounts
- Log in securely
- Maintain sessions
- Reset passwords

## 2. Context Analysis
Current state: No authentication system
Target state: Secure auth with session management
Constraints: [analyzes your codebase]

## 3. Approach Options
**Option A: JWT + Local Storage**
Pros: Stateless, scalable, simple
Cons: Vulnerable to XSS, no server control
Complexity: Medium
Timeline: 2-3 days

**Option B: Session Cookies + Server-side**
Pros: More secure, server control, CSRF protection
Cons: Requires server state, more complex
Complexity: Medium-High
Timeline: 3-4 days

**Option C: OAuth + Third-party (Google/GitHub)**
Pros: Easy to implement, user convenience, no password management
Cons: Dependency on third-party, limited customization
Complexity: Low-Medium
Timeline: 1-2 days

Which approach aligns best with your requirements?
```

## Differences from MetaCognitive Flow

| Feature | Planning Mode | MetaCognitive Flow |
|---------|---------------|-------------------|
| Purpose | Practical planning | Deep reasoning |
| Complexity | Lightweight | Heavy analysis |
| Output | Implementation plan | Cognitive insights |
| Use case | Day-to-day tasks | Complex decisions |
| Duration | 5-10 minutes | 20-30 minutes |

Use **Planning Mode** for regular development work.
Use **MetaCognitive Flow** for strategic decisions, architecture choices, or complex trade-off analysis.

## Transition to Execution

Once planning is complete, Claude will ask:
```
Plan complete. Ready to begin implementation? (yes/revise/cancel)
```

Choose:
- **yes** - Start implementing the plan
- **revise** - Adjust specific parts of the plan
- **cancel** - Return to normal conversation

## Tips for Best Results

1. **Be specific** about what you want to accomplish
2. **Mention constraints** (time, technology, resources)
3. **Share context** about your codebase if relevant
4. **Ask questions** if the plan needs clarification
5. **Iterate** - plans can be revised based on feedback

## Integration with Todo Lists

Plans automatically map to todo lists. After planning, you'll get:
```
[ ] Step 1: Set up authentication routes
[ ] Step 2: Implement user registration
[ ] Step 3: Add login functionality
[ ] Step 4: Create session management
[ ] Step 5: Add password reset flow
[ ] Step 6: Write tests
```

## Files

- `SKILL.md` - Full skill definition (auto-loaded by Claude)
- `README.md` - This quick reference (for humans)

## Meta

**Created:** 2025-10-22
**Version:** 1.0.0
**Category:** Planning & Strategy
**Tokens:** ~250 (metadata only, until activated)

---

**Pro tip:** Use Planning Mode at the start of your work session to set clear direction, then execute with confidence!
