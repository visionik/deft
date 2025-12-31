# Warping

> Best practices and guidelines for working with Warp and other Agentic Development Environments

A curated collection of markdown guidelines that codify best practices for AI agents when writing, building, testing, and managing software projects. Originally designed for [Warp](https://www.warp.dev/), these standards are applicable to any agentic development environment.

## 🎯 What is this?

Warping is a framework of reusable, modular instructions that teach AI agents how to work effectively on your projects. Rather than repeatedly explaining conventions or debugging agent mistakes, you encode your standards once and reference them across projects.

## 🚀 Benefits

- **Consistency**: Agents follow the same standards across all your projects
- **Quality**: Built-in best practices for testing, coverage, formatting, and code quality
- **Safety**: Guidelines for production safety, source control, and secrets management
- **Efficiency**: Agents know your preferred tools, patterns, and workflows upfront
- **Self-improvement**: Agents can learn from mistakes and codify new knowledge
- **Language-agnostic**: Separate guidelines for Python, Go, and other languages/tools

## 📚 Files Overview

### Core Guidelines

- **`warp.md`** - Main entry point with general AI guidelines covering:
  - Documentation structure and file organization
  - Code search (ripgrep, ast-grep)
  - Commit conventions (Conventional Commits)
  - Agent persona and quality standards
  - SCM and production safety rules
  - Self-improvement mechanisms

### Language-Specific Standards

- **`warp-python.md`** - Python development standards:

  - Stack: Python 3.11+, pytest, Flask/FastAPI, typer, textual
  - Testing: pytest with ≥75% coverage requirement
  - Style: PEP 8 via ruff, black, isort
  - Types: PEP 484 with mypy strict mode
  - Complete pyproject.toml configuration

- **`warp-go.md`** - Go development standards:
  - Documentation: go.dev/doc/comment conventions
  - Testing: Testify with ≥75% coverage
  - Table-driven test patterns
  - HTTP testing with httptest
  - Quality checks and workflow

### Tool-Specific Guides

- **`warp-taskfile.md`** - [Task](https://taskfile.dev) best practices:
  - Task-centric workflow philosophy
  - Naming conventions and structure
  - Dependencies, caching, and performance
  - Robustness patterns (errexit, nounset, pipefail)
  - UX considerations for teams and CI

### Project Configuration

- **`warp-project.md`** - Project-specific guidelines template:

  - Workflow commands
  - Secrets management
  - Standards enforcement
  - Example: OuraCLI configuration

- **`warp-specification.md`** - Project specification template:
  - Overview and dependencies
  - Features and requirements
  - Implementation notes
  - Example: OuraCLI spec

### Agent Memory

- **`warp-ideas.md`** - Placeholder for new concepts and future directions
- **`warp-lessons.md`** - Agent-learned knowledge from corrections and improvements
- **`warp-suggestions.md`** - Agent suggestions for project improvements

## 🔧 Usage

### For Warp Users

1. Copy relevant markdown files to your project's `docs/` directory
2. Reference them in your project's `WARP.md` or `AGENTS.md` file:
   ```markdown
   See [docs/warp.md](./docs/warp.md) for AI agent guidelines
   ```
3. Customize the guidelines for your specific project needs
4. Agents will automatically use these as context when working on your code

### For Other Agentic Environments

These guidelines work with any AI development environment that supports:

- Reading markdown documentation as context
- Following codified instructions and best practices
- Persisting learned knowledge

Simply reference the appropriate files in your agent's context or system prompts.

### Modular Approach

Each file is standalone and references related files. You can:

- Use `warp.md` alone for general guidelines
- Add `warp-python.md` for Python projects
- Add `warp-go.md` for Go projects
- Add `warp-taskfile.md` if using Task for builds
- Create custom `warp-project.md` for specific needs

## 📖 Key Concepts

### Quality Standards

- Files SHOULD be <500 lines, MUST be <1000 lines
- ≥75% test coverage (overall + per-module)
- Run all checks (fmt, lint, type, test) before commits
- Never claim checks passed without actually running them

### Safety Principles

- Never use `git reset --hard` or force-push without permission
- Assume production impact unless stated otherwise
- All secrets in `secrets/` directory, never in code
- Prefer small, reversible changes

### Self-Improvement

- Agents can modify `warp-lessons.md` to codify learnings
- Agents document observations in `warp-ideas.md` and `warp-suggestions.md`
- No permission required to update memory files

### Conventional Commits

All guidelines enforce [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

```
type(scope): description

Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert
```

## 🤝 Contributing

This is a living framework. As you discover better patterns or encounter new scenarios:

1. Update the relevant markdown file
2. If agents discover improvements, they'll add to `warp-lessons.md`
3. Consider contributing back patterns that work well

## 📄 License

Copyright 2025 Jonathan Taylor. If you've been invited to this repo you have permission to use this work.

---

**Note**: While designed for Warp, these standards promote universal software engineering best practices applicable to any development workflow.
