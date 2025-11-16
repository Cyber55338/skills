---
name: save-conversation
description: Save and export the current conversation as a literal transcript. Optionally generate an AI podcast discussion. Preserves the exact conversation flow in User:/Assistant: format without any reorganization or summarization.
---

# Save Conversation

This Skill saves the current conversation to `~/saved-conversations/` as a **literal transcript** in markdown format. Optionally, it can also generate an AI-powered podcast discussion using Google NotebookLM.

## Core Principle

**DO NOT summarize, reorganize, or restructure.** Save the conversation EXACTLY as it occurred, preserving the natural flow between user and assistant.

## Instructions

When this Skill is activated:

### Step 1: Reconstruct Conversation Chronologically

Go through the entire conversation from start to finish and recreate it in literal transcript format:

```markdown
# Chat Transcript: [Brief Topic]
**Date**: October 28, 2025
**Format**: Literal conversation transcript

---

User: [exact first message]

Assistant: [exact first response with all formatting preserved]

User: [exact second message]

Assistant: [exact second response]

[Continue for entire conversation...]
```

**Preservation Rules**:
- Keep ALL markdown formatting (tables, code blocks, lists, headers)
- Include system messages like skill activations inline
- Preserve tool uses and their results
- NO reorganization by theme
- NO executive summaries
- NO table of contents
- NO added insights sections
- Just the raw conversation flow

### Step 2: Generate Filename

Use pattern: `[Topic]-Chat-Transcript-[Date].md`

Examples:
- `Claude-Code-Ecosystem-Chat-Transcript-2025-10-28.md`
- `Python-Tutorial-Chat-Transcript-2025-10-28.md`

### Step 3: Save File

Use Write tool to save to:
```
~/saved-conversations/[filename].md
```

### Step 4: Check for Podcast Request

Detect if user requested podcast generation by looking for keywords:
- "podcast"
- "audio"
- "listen"
- "make a podcast"

If podcast requested:
- Ask: "Would you like me to generate an AI podcast discussion of this conversation using Google NotebookLM?"
- If yes, proceed to Step 5
- If no or unsure, skip to Step 6

### Step 5: Generate Podcast (Optional)

If user wants podcast:
1. Check if podcast-generator skill is configured (config file exists)
2. If not configured, inform user:
   ```
   ⚠ Podcast API not yet configured

   To enable podcast generation:
   1. Run: ~/.claude/skills/podcast-generator/setup-podcast-api.sh
   2. Or use the podcast-generator skill to set up
   ```
3. If configured, invoke podcast-generator skill:
   ```
   Use podcast-generator skill with the saved transcript file
   ```

### Step 6: Confirm with User

Provide completion message:

**Without Podcast**:
```
✓ **Chat transcript saved successfully!**

**File**: [filename]
**Location**: ~/saved-conversations/
**Format**: Literal User:/Assistant: transcript
**Length**: ~[X] messages

The conversation has been preserved exactly as it occurred with:
- Chronological order maintained
- All formatting preserved
- System messages included
- Zero reorganization

You can read it and see the exact chat history.

**Want to listen?** Ask me to "create a podcast from this conversation"
```

**With Podcast**:
```
✓ **Conversation saved and podcast generated!**

**Transcript**: ~/saved-conversations/[filename].md
**Podcast**: ~/saved-conversations/podcasts/[filename]-podcast.mp3
**Format**: Two AI hosts discussing your conversation
**Duration**: ~[X] minutes

Listen with: mpv ~/saved-conversations/podcasts/[filename]-podcast.mp3

Both the written transcript and audio podcast are ready!
```

## Important Notes

- This skill preserves conversations AS-IS, not summaries
- Focus on accuracy over polish
- User wants to see what they saw in the chat interface
- Simple chronological transcript is better than fancy formatting

## Example Output

```markdown
# Chat Transcript: Database Optimization Discussion
**Date**: October 28, 2025
**Format**: Literal conversation transcript

---

User: How can I optimize my PostgreSQL queries?

Assistant: Let me help you optimize PostgreSQL queries. Here are the key strategies:

1. **Indexing**: Create indexes on frequently queried columns
2. **Query planning**: Use EXPLAIN ANALYZE
3. **Connection pooling**: Reduce connection overhead

[... exact conversation continues ...]
```
