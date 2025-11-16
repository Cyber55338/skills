# Claude Code Custom Skills Collection

A curated collection of powerful custom skills for Claude Code that enhance productivity, problem-solving, and personal development through proven frameworks and methodologies.

## 📚 Overview

This repository contains 9 custom Claude Code skills designed to help you think better, work smarter, and achieve breakthrough results. Each skill provides structured frameworks and proven methodologies that activate automatically based on conversation context.

## 🎯 Skills Included

### 🌊 **Flow** - Energy-Based Problem Solving
Energy-based problem solving framework that maps momentum vs resistance. Use when stuck despite high effort, facing constant friction, or experiencing burnout. Helps find the path of least resistance while achieving goals.

**Use when:**
- Stuck despite high effort
- Facing constant friction
- Forcing behavior change
- Fighting trends
- Experiencing burnout
- Need to "work smarter, not harder"

---

### 🧠 **Metacognitive Flow** - Structured Reasoning
Apply structured reasoning using cognitive nodes (Thought, Emotion, Imagination, Belief, Action) and mental models to solve complex problems.

**Use when:**
- Tackling difficult problems
- Making strategic decisions
- Analyzing trade-offs
- Systematic thinking is needed
- Complex decision-making required

---

### 📋 **Planning Mode** - Task Breakdown
Activate focused planning mode for complex tasks. Breaks down work into structured steps, creates implementation plans, and maps project architecture.

**Use when:**
- Breaking down complex tasks
- Creating implementation plans
- Analyzing requirements before coding
- Mapping project architecture
- Need structured approach

---

### 💾 **Save Conversation** - Export Transcripts
Save and export conversations as literal transcripts in markdown format. Optionally generate AI podcast discussions using Google NotebookLM.

**Features:**
- Literal transcript preservation
- User:/Assistant: format
- No reorganization or summarization
- Optional AI podcast generation
- Saves to `~/saved-conversations/`

---

### 🎨 **SCAMPER Analysis** - Creative Innovation
Apply SCAMPER creative thinking technique (Substitute, Combine, Adapt, Modify, Put to other uses, Eliminate, Reverse) for innovation and problem-solving.

**Use when:**
- Need to innovate
- Improve existing products/processes
- Brainstorm alternatives
- Solve problems creatively
- Generate new ideas

---

### 🏛️ **Seneca** - Stoic Philosophy Framework
Apply Seneca's Stoic philosophy for resilience, wisdom, and tranquility. Includes Premeditatio Malorum (negative visualization), Dichotomy of Control, Memento Mori, Voluntary Discomfort, time management, and virtue-based decision-making.

**Use when:**
- Building resilience
- Managing fear or anxiety
- Time optimization needed
- Facing adversity
- Making ethical decisions
- Cultivating gratitude

---

### ⚡ **Tim Ferriss** - Optimization Frameworks
Apply Tim Ferriss's proven frameworks for optimization, learning, and decision-making. Includes DEAL (4-Hour Workweek), DiSSS meta-learning, Fear-Setting, 80/20 principle, and Minimum Effective Dose.

**Use when:**
- Learning new skills faster
- Overcoming fear-based decisions
- Optimizing productivity
- Time management
- Lifestyle design
- Finding the 80/20 leverage points

---

### 🔥 **Tony Robbins** - Peak Performance
Apply Tony Robbins' transformation frameworks for peak performance, breakthrough results, and fulfillment. Includes RPM planning, Six Human Needs, Emotional Triad, NAC conditioning, Priming routine, and Peak State strategies.

**Use when:**
- Need breakthrough results
- Achieving peak states
- Understanding motivation
- Creating lasting behavioral change
- Breaking through limitations
- Transforming stuck patterns

---

### 🎙️ **Podcast Generator** - AI Audio Creation
Converts saved conversation transcripts into AI-generated podcasts using Google NotebookLM Podcast API. Creates natural-sounding discussions between two AI hosts.

**Features:**
- Reads markdown transcripts
- Sends to Google NotebookLM API
- Downloads generated MP3 podcasts
- Saves to `~/saved-conversations/podcasts/`

---

## 🚀 Installation

### Quick Install

```bash
# Clone the repository to your Claude Code skills directory
git clone https://github.com/YOUR_USERNAME/skills.git ~/.claude/skills

# Or if you already have skills, clone and copy
git clone https://github.com/YOUR_USERNAME/skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/* ~/.claude/skills/
```

### Manual Install

1. Download the repository as a ZIP file
2. Extract to `~/.claude/skills/` directory
3. Ensure each skill has its `SKILL.md` file

### Verify Installation

Restart Claude Code and the skills will automatically load. You can verify by checking:

```bash
ls ~/.claude/skills/*/SKILL.md
```

---

## 💡 How to Use

Skills activate automatically based on conversation context. Simply talk naturally about your needs:

### Example 1: Problem Solving
```
You: "I'm working really hard but not making progress on this project"
→ Flow skill activates and helps find path of least resistance
```

### Example 2: Learning
```
You: "I want to learn Python as quickly as possible"
→ Tim Ferriss skill activates with DiSSS meta-learning framework
```

### Example 3: Decision Making
```
You: "I'm anxious about making this career decision"
→ Seneca skill activates with Stoic decision-making framework
```

### Example 4: Innovation
```
You: "How can I improve this product feature?"
→ SCAMPER Analysis skill activates for creative thinking
```

---

## 📖 Skill Details

Each skill directory contains:

- **SKILL.md** - Main skill definition with instructions
- **README.md** - Additional documentation (some skills)
- **examples.md** - Usage examples (some skills)
- **reference.md** - Quick reference guide (some skills)
- **Scripts** - Helper scripts for automation (podcast-generator)

---

## 🎓 Best Practices

### For Users

**DO:**
- Describe what you need naturally
- Mention specific challenges or goals
- Ask for help with frameworks by name
- Combine multiple skills for complex problems

**DON'T:**
- Need to memorize skill names (they auto-activate)
- Manually invoke skills (unless you prefer to)
- Worry about technical details

### For Developers

**DO:**
- Read the SKILL.md files to understand capabilities
- Customize descriptions for better auto-activation
- Add your own skills following the same structure
- Share improvements with the community

---

## 🔧 Configuration

Skills work out of the box with no configuration required. However, some skills have optional settings:

### Podcast Generator
Requires Google NotebookLM API configuration:
- See `podcast-generator/setup-podcast-api.sh` for setup instructions
- Configure API credentials before first use

### Save Conversation
Default save location: `~/saved-conversations/`
- Modify in SKILL.md if you prefer a different location

---

## 🤝 Contributing

Want to add your own skills or improve existing ones?

1. Fork this repository
2. Create a new skill directory: `your-skill-name/`
3. Write a `SKILL.md` file with proper frontmatter:
   ```yaml
   ---
   name: Your Skill Name
   description: When to activate and what it does (clear trigger keywords)
   ---
   ```
4. Add documentation and examples
5. Test thoroughly
6. Submit a pull request

---

## 📄 Skill Format

Each skill must have a `SKILL.md` file with YAML frontmatter:

```yaml
---
name: skill-name
description: Clear description with activation keywords and use cases
---

# Skill Content

Your skill instructions, frameworks, and prompts go here...
```

**Requirements:**
- `name`: Human-friendly name (max 64 chars)
- `description`: Activation triggers + capabilities (max 1024 chars)
- Content: Detailed instructions Claude follows when skill activates

---

## 🌟 Why These Skills?

### Philosophy & Personal Development
- **Seneca**: Ancient wisdom for modern challenges
- **Tony Robbins**: Peak performance and transformation
- **Flow**: Work with natural forces, not against them

### Productivity & Learning
- **Tim Ferriss**: Proven optimization frameworks
- **Planning Mode**: Structured approach to complex tasks
- **Metacognitive Flow**: Systematic problem-solving

### Creativity & Innovation
- **SCAMPER Analysis**: Creative thinking techniques
- **Podcast Generator**: Transform conversations into audio
- **Save Conversation**: Preserve insights and learnings

---

## 📚 Additional Resources

### Learn More About Skills
- [Claude Code Skills Documentation](https://code.claude.com/docs/skills)
- [Anthropic Skills GitHub](https://github.com/anthropics/skills)

### Framework Sources
- **Tim Ferriss**: "The 4-Hour Workweek", "Tools of Titans"
- **Tony Robbins**: "Awaken the Giant Within", "Unlimited Power"
- **Seneca**: "Letters from a Stoic", "On the Shortness of Life"
- **SCAMPER**: Bob Eberle's creative thinking method

---

## 📞 Support & Feedback

- **Issues**: Report bugs or request features via GitHub Issues
- **Discussions**: Share your experiences and tips
- **Pull Requests**: Contribute improvements or new skills

---

## 📄 License

These skills are provided as-is for personal and educational use. Individual frameworks and methodologies may have their own copyrights and trademarks.

---

## 🙏 Acknowledgments

Created for the Claude Code community to enhance productivity and personal growth through proven frameworks and structured thinking.

Special thanks to:
- Tim Ferriss for optimization frameworks
- Tony Robbins for transformation methodologies
- Seneca for timeless Stoic wisdom
- Bob Eberle for SCAMPER method
- Anthropic for Claude Code platform

---

**Happy coding and growing!** 🚀

*Let these skills help you think better, work smarter, and achieve breakthrough results.*
