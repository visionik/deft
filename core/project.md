# Warping Framework Project Guidelines

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [taskfile.md](../tools/taskfile.md)

## Project Configuration

**Tech Stack**: Pure Markdown (.md files)

**Project Type**: Agent Framework / Documentation System

**Purpose**: A layered framework for AI-assisted development with consistent standards and workflows

**Specification**: See [README.md](../README.md) and [main.md](../main.md) for framework overview

## 📋 Workflow

```bash
task validate      # Validate all markdown files
task lint          # Lint markdown files
task build         # Package framework for distribution
task clean         # Clean generated artifacts
```

## 📁 Directory Structure

- `core/` - Core framework files (user.md, project.md, coding.md)
- `languages/` - Language-specific standards (python.md, go.md, typescript.md, cpp.md)
- `interfaces/` - Interface type guidelines (cli.md, rest.md, tui.md, web.md)
- `tools/` - Tool-specific guidelines (taskfile.md, git.md, testing.md, telemetry.md)
- `swarm/` - Multi-agent coordination patterns
- `templates/` - Templates and examples for specifications
- `meta/` - Meta/process files (lessons.md, ideas.md, suggestions.md)

## Standards

**Documentation Quality:**
- ! All filenames use hyphens, not underscores
- ! Maintain clear hierarchical precedence (user.md > project.md > language > tool > main.md)
- ! Use RFC2119 notation (!=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY)
- ~ Keep files focused and modular
- ~ Cross-reference related documents

**Framework Principles:**
- ! Lazy loading - only read files relevant to current task
- ! Layer precedence - more specific rules override general ones
- ~ Self-improvement via lessons.md updates
- ~ Maintain both templates and examples

**Version Control:**
- ! Use Conventional Commits
- ! Never force-push without permission
- ~ Create backup/ directory for significant refactors
