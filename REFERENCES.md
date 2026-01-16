# Reference Guide - When to Load Which Files

**Lazy Loading Principle**: Only read files that are relevant to your current task. Don't load entire framework upfront.

## 🎯 Always Start Here

**[main.md](./main.md)** - Entry point
- Load: Always (defines agent behavior and general guidelines)
- ~100 lines, quick read

**[core/user.md](./core/user.md)** - User preferences
- Load: Always (highest precedence, overrides everything)
- Check for custom rules and preferences

## 📋 Task-Based Loading

### When Writing Code

1. **[core/coding.md](./core/coding.md)** - General coding guidelines
   - Load: For any software development task
   - Contains: modularity, contracts, error handling, change management

2. **Language file** - Load based on language:
   - [languages/python.md](./languages/python.md) - When writing Python
   - [languages/go.md](./languages/go.md) - When writing Go
   - [languages/typescript.md](./languages/typescript.md) - When writing TypeScript/JavaScript
   - [languages/cpp.md](./languages/cpp.md) - When writing C++

3. **[core/project.md](./core/project.md)** - Project-specific rules
   - Load: When unsure about project standards
   - Contains: project tech stack, coverage requirements, telemetry config

### When Building Interfaces

Load based on interface type:

- **[interfaces/cli.md](./interfaces/cli.md)** - Building command-line tools
- **[interfaces/rest.md](./interfaces/rest.md)** - Designing/implementing REST APIs
- **[interfaces/tui.md](./interfaces/tui.md)** - Building terminal UIs (Textual, ink)
- **[interfaces/web.md](./interfaces/web.md)** - Building web UIs (React, etc.)

### When Working with Tools

Load as needed:

- **[tools/git.md](./tools/git.md)** - Before committing (commit conventions)
- **[tools/github.md](./tools/github.md)** - When setting up CI/CD, PRs, issues
- **[tools/taskfile.md](./tools/taskfile.md)** - When creating/modifying tasks
- **[tools/testing.md](./tools/testing.md)** - When writing tests or checking coverage
- **[tools/telemetry.md](./tools/telemetry.md)** - When implementing logging, tracing, metrics

### When Working in a Swarm

**[swarm/swarm.md](./swarm/swarm.md)** - Multi-agent coordination
- Load: Only when multiple agents working on same codebase
- Contains: communication protocols, conflict resolution, handoff patterns

### When Creating Specifications

**[templates/make-spec.md](./templates/make-spec.md)** - Specification generation
- Load: When user asks to create a project specification
- Contains: interview process, output format

## 🔄 Reference Chains

Follow these chains only as needed:

### Coding → Language → Interface
```
coding.md → (pick language) → python.md → (pick interface) → rest.md
```

### Coding → Tools
```
coding.md → testing.md (when writing tests)
coding.md → telemetry.md (when adding logging)
coding.md → git.md (before committing)
```

### Project Overrides
```
(any file) → project.md (check for overrides)
user.md (check for personal preferences)
```

## ⚠️ Don't Load Unless Needed

**[core/ralph.md](./core/ralph.md)** - Ralph loop concept
- Status: Draft, not implemented
- Load: Only if exploring self-correction loops

**[meta/code-field.md](./meta/code-field.md)** - Coding philosophy
- Load: For mindset/philosophy, not technical rules
- Complements technical standards, doesn't replace them

**[meta/ideas.md](./meta/ideas.md)** - Future directions
- Load: When agent wants to add new ideas
- AI can update without permission

**[meta/lessons.md](./meta/lessons.md)** - Codified learnings
- Load: When agent discovers repeated pattern/correction
- AI can update without permission

**[meta/suggestions.md](./meta/suggestions.md)** - Improvement suggestions
- Load: When agent has suggestions for project improvements
- AI can update without permission

## 🎯 Common Scenarios

### Scenario: "Write a Python REST API"
Load order:
1. main.md (always)
2. core/user.md (always)
3. core/coding.md (writing code)
4. languages/python.md (Python-specific)
5. interfaces/rest.md (REST API design)
6. core/project.md (check for overrides)

### Scenario: "Add tests to existing Go code"
Load order:
1. main.md (always)
2. core/user.md (always)
3. tools/testing.md (testing standards)
4. languages/go.md (Go-specific testing)
5. core/project.md (coverage requirements)

### Scenario: "Fix a bug"
Load order:
1. main.md (always)
2. core/user.md (always)
3. (language file if fixing code)
4. tools/git.md (before committing fix)

### Scenario: "Multi-agent coordination"
Load order:
1. main.md (always)
2. core/user.md (always)
3. swarm/swarm.md (swarm patterns)
4. core/coding.md (coding standards)
5. tools/git.md (commit conventions with task IDs)

## 💡 Tips for Agents

**Minimize Context Window Usage:**
- Don't load all files speculatively
- Load files only when their content is needed
- Use this guide to determine what to load

**Check Precedence:**
- Always check user.md first (highest precedence)
- Check project.md for project-specific overrides
- Follow most specific → most general

**Update Meta Files Freely:**
- meta/ideas.md, meta/lessons.md, meta/suggestions.md can be updated without permission
- These are for continuous improvement

**When In Doubt:**
- Start with main.md and core/coding.md
- Add language/interface files as task becomes clear
- Check project.md if behavior seems inconsistent
