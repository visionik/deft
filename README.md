# Warping Process

**A layered framework for AI-assisted development with consistent standards and workflows.**

## 🎯 What is Warping?

Warping is a structured approach to working with AI coding assistants (particularly Warp AI) that provides:

- **Consistent coding standards** across languages and projects
- **Reproducible workflows** via task-based automation
- **Self-improving guidelines** that evolve with your team
- **Hierarchical rule precedence** from general to project-specific

## 📚 The Layers

Warping uses a layered architecture where more specific rules override general ones:

```
user.md          ← Highest precedence (personal preferences)
  ↓
project.md       ← Project-specific rules and workflows
  ↓
python.md        ← Language-specific standards
go.md
  ↓
taskfile.md      ← Tool-specific guidelines
  ↓
main.md          ← General AI guidelines and agent behavior
  ↓
specification.md ← Lowest precedence (project requirements)
```

### 🔧 Core Files

#### **main.md** - Foundation
The central AI guidelines document defining:
- General workflow standards (documentation, filenames, secrets)
- Agent persona and behavior
- Quality requirements and safety rules
- Self-improvement mechanisms

**Start here** to understand core principles.

#### **user.md** - Your Preferences
Personal overrides for any rule in the system:
- How to address you
- Personal workflow preferences
- Custom rules that supersede all others

**Customize this** to make warping yours.

### 🐍 Language Layers

#### **python.md**
Python-specific standards:
- Testing: pytest, ≥75% coverage
- Style: ruff, black, isort (PEP 8)
- Types: mypy strict mode
- Docs: PEP 257 docstrings

#### **go.md**
Go-specific standards:
- Testing: Testify, ≥75% coverage
- Docs: go.dev/doc/comment
- Patterns: table-driven tests, interface design

### 🎛️ Tool Layers

#### **taskfile.md**
Taskfile best practices:
- Task-centric workflows
- Composable, documented tasks
- Caching and incremental builds
- Shell robustness patterns

### 📦 Project Layer

#### **project.md**
Project-specific overrides:
- Tech stack (CLI/Web/TUI)
- Project workflows and commands
- Secrets management
- Coverage requirements

#### **specification.md**
Links to detailed project specifications.

### 🧠 Learning & Memory

#### **lessons.md**
Codified learnings from repeated corrections. The AI can update this autonomously when discovering better approaches.

#### **ideas.md**
New concepts and future directions noticed during development.

#### **suggestions.md**
AI-generated improvement suggestions for your projects.

## 🚀 Getting Started

### 1. Set Up Your User Preferences

Edit `user.md` to configure personal preferences:

```markdown
# User Preferences

## Name
Address the user as: **YourName**

## Custom Rules
- Your custom preferences here
```

### 2. Understand the Hierarchy

Rules cascade with precedence:
1. **user.md** (highest) - your personal overrides
2. **project.md** - project-specific rules
3. **Language files** (python.md, go.md) - language standards
4. **Tool files** (taskfile.md) - tool guidelines
5. **main.md** - general AI behavior
6. **specification.md** (lowest) - requirements

### 3. Reference in Warp

Upload these files to **Warp Drive** so they're available to AI sessions:

1. Open Warp
2. Access Warp Drive (notebooks feature)
3. Upload relevant warping/*.md files
4. Reference them in your Warp rules/agent instructions

### 4. Use in Projects

For each project:

1. Copy or link the warping directory
2. Create/update `project.md` with project-specific rules
3. Create/update `specification.md` or link to specs
4. Let the AI reference these during development

### 5. Evolve Over Time

The warping process improves continuously:

- AI updates `lessons.md` when learning better patterns
- AI notes ideas in `ideas.md` for future consideration
- AI suggests improvements in `suggestions.md`
- You update `user.md` with new preferences
- You update language/tool files as standards evolve

## 💡 Key Principles

### Task-Centric Workflow with Taskfile

**Why Taskfile?**

Warping uses [Taskfile](https://taskfile.dev) as the universal task runner for several reasons:

1. **Makefiles are outdated**: Make syntax is arcane, portability is poor, and tabs vs spaces causes constant friction
2. **Polyglot simplicity**: When working across Python (make/invoke/poetry scripts), Go (make/mage), Node (npm scripts/gulp), etc., each ecosystem has different conventions. Taskfile provides one consistent interface
3. **Better than script sprawl**: A `/scripts` directory with dozens of bash files becomes chaotic—hard to discover, hard to document, hard to compose. Taskfile provides discoverability (`task --list`), documentation (`desc`), and composition (`deps`)
4. **Modern features**: Built-in file watching, incremental builds via checksums, proper error handling, variable templating, and cross-platform support

**Usage:**
```bash
task --list        # See available tasks
task check         # Pre-commit checks
task test:coverage # Run coverage
task dev           # Start dev environment
```

### Test-Driven Development (TDD)

Warping embraces TDD as the default development approach:

1. **Write the test first**: Define expected behavior before implementation
2. **Watch it fail**: Confirm the test fails for the right reason
3. **Implement**: Write minimal code to make the test pass
4. **Refactor**: Improve code quality while keeping tests green
5. **Repeat**: Build features incrementally with confidence

**Benefits:**
- Tests become specifications of behavior
- Better API design (you use the API before implementing it)
- High coverage naturally (≥75% is easy when tests come first)
- Refactoring confidence
- Living documentation

**In Practice:**
```bash
task test          # Run tests in watch mode during development
task test:coverage # Verify ≥75% coverage
task check         # Pre-commit: all quality checks including tests
```

### Quality First
- ≥75% test coverage (overall + per-module)
- Always run `task check` before commits
- Run linting, formatting, type checking
- Never claim checks passed without running them

### Spec-Driven Development (SDD)

Before writing any code, warping uses an AI-assisted specification process:

**The Process:**

1. **Start with make-spec.md**: A prompt template for creating specifications
   ```markdown
   I want to build ________ that has the following features:
   1. Feature A
   2. Feature B
   3. Feature C
   ```

2. **AI Interview**: The AI (Claude or similar) asks focused, non-trivial questions to clarify:
   - Missing decisions and edge cases
   - Implementation details and architecture
   - UX considerations and constraints
   - Dependencies and tradeoffs
   
   Each question includes numbered options and an "other" choice for custom responses.

3. **Generate SPECIFICATION.md**: Once ambiguity is minimized, the AI produces a comprehensive spec with:
   - Clear phases, subphases, and tasks
   - Dependency mappings (what blocks what)
   - Parallel work opportunities
   - No code—just the complete plan

4. **Multi-Agent Development**: The spec enables multiple AI coding agents to work in parallel on independent tasks

**Why SDD?**
- **Clarity before coding**: Catch design issues early
- **Parallelization**: Clear dependencies enable concurrent work
- **Scope management**: Complete spec prevents scope creep
- **Onboarding**: New contributors/agents understand the full picture
- **AI-friendly**: Structured specs help AI agents stay aligned

**Example**: See `make-spec.md` template in Warp Drive for the interview process

### Convention Over Configuration
- Use Conventional Commits for all commits
- Use hyphens in filenames, not underscores
- Keep secrets in `secrets/` directory
- Keep docs in `docs/`, not project root

### Safety and Reversibility
- Never force-push without permission
- Assume production impact unless stated
- Prefer small, reversible changes
- Call out risks explicitly

## 📖 Example Workflows

### Starting a New Python Project

1. AI reads: `main.md` → `python.md` → `taskfile.md`
2. AI sets up: pytest, ruff, black, mypy, Taskfile
3. AI configures: ≥75% coverage, PEP standards
4. You customize: `project.md` with project specifics

### Working on an Existing Go Project

1. AI reads: `user.md` → `project.md` → `go.md` → `main.md`
2. AI follows: go.dev/doc/comment, Testify patterns
3. AI runs: `task check` before suggesting changes
4. AI respects: your user.md overrides

### Code Review Session

1. AI references quality standards from language file
2. AI runs `task quality` and `task test:coverage`
3. AI checks Conventional Commits compliance
4. AI suggests improvements → adds to `suggestions.md`

## 🔗 Integration with Warp AI

The warping process is designed for Warp AI's rule system:

1. **Upload to Warp Drive**: Keep main.md and relevant files in Warp Drive
2. **Create Warp Rules**: Reference warping files in your Warp rules
3. **Project-Specific Rules**: Add `AGENTS.md` or `WARP.md` in project root that references warping
4. **Automatic Context**: Warp AI loads rules automatically when working in your projects

## 📝 Contributing to Warping

As you use warping:

1. **lessons.md**: AI adds patterns discovered during development
2. **ideas.md**: AI notes potential improvements
3. **suggestions.md**: AI records project-specific suggestions
4. Review these periodically and promote good ideas to main guidelines

## 🎓 Philosophy

Warping embodies:

- **Correctness over convenience**: Optimize for long-term quality
- **Standards over flexibility**: Consistent patterns across projects
- **Evolution over perfection**: Continuously improve through learning
- **Clarity over cleverness**: Direct, explicit, maintainable code

---

**Next Steps**: Read [main.md](./main.md) for comprehensive AI guidelines, then customize [user.md](./user.md) with your preferences.
