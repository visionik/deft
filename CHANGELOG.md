# Changelog

All notable changes to the Deft framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.4] - 2026-01-29

### Changed
- **README Formatting**: Consolidated file descriptions to one line per file for better readability
  - Core, Languages, Interfaces, Tools, Templates, and Meta sections now use single-line format
  - Improved scannability and reduced visual clutter

## [0.3.3] - 2026-01-29

### Changed
- **README TL;DR Enhancements**: 
  - Emphasized Deft as a SKILL.md format for AI coding effectiveness
  - Added platform compatibility note for systems without SKILL.md support (e.g. Warp.dev)
  - Added context efficiency explanation: RFC 2119 notation and lazy-loading keep context windows lean
  - Clarified that Deft is markdown-first with optional Python CLI for setup

## [0.3.2] - 2026-01-29

### Changed
- **README TL;DR**: Added note about professional-grade defaults
  - Highlights that Deft works out of the box without customization
  - Emphasizes built-in standards for Python, Go, TypeScript, C++

## [0.3.1] - 2026-01-29

### Changed
- **MIT License**: Updated from temporary usage terms to full MIT License
  - Users can now freely use, modify, distribute, and sell Deft
  - Only requirement: retain copyright notice and license text
  - Updated LICENSE.md with standard MIT text
- **Branding**: Updated copyright notices to include website
  - Copyright now reads: Jonathan "visionik" Taylor
  - Added https://deft.md reference in LICENSE.md and README.md
- **README Improvements**: Added TL;DR section
  - Quick summary of what Deft is and why it's valuable
  - Highlights key benefits before diving into details

## [0.3.0] - 2026-01-29

### Changed
- **Project renamed from Warping to Deft**: Complete rebrand across all files and documentation
  - CLI command renamed from `wrun` to `run`
  - All references to "Warping" replaced with "Deft" throughout documentation
  - GitHub repository renamed from `visionik/warping` to `visionik/deft`
  - Local directory renamed to match new project name
  - Updated LICENSE.md, README.md, and all markdown files
  - Updated Taskfile.yml project name variable

## [0.2.5] - 2026-01-23

### Added
- **`run reset` command**: Reset configuration files to default/empty state
  - Interactive mode: prompts for each file individually
  - Batch mode (`--all`): resets all files without prompting
  - Resets user.md to default template, deletes project.md/PRD.md/SPECIFICATION.md
- **Guided workflow prompts**: Commands now chain together interactively
  - `run install` asks to run `run project` after completion
  - `run bootstrap` asks to run `run project` after completion (if in deft directory)
  - `run project` asks to run `run spec` after completion
  - Creates smooth guided flow: install → bootstrap → project → spec
- **Enhanced command descriptions**: Each command now shows detailed explanation at startup
  - `run install`: Shows what will be created (deft/, secrets/, docs/, Taskfile.yml, .gitignore)
  - `run project`: Explains project.md purpose (tech stack, quality standards, workflow)
  - `run spec`: Explains PRD.md creation and AI interview process
- **Smart project name detection**: `run spec` reads project name from project.md
  - Auto-suggests project name if project.md exists
  - Falls back to manual input if not found
- **Improved prompt_toolkit installation**: Better detection and instructions
  - Shows exact Python interpreter path being used
  - Detects externally-managed Python (PEP 668)
  - Automatically includes `--break-system-packages` flag when needed
  - Provides clear explanation and alternatives (venv, pipx)
  - Links to PEP 668 documentation

### Changed
- **Renamed `run.py` → `run`**: Removed .py extension for cleaner command
  - Follows Unix convention for executables
  - More professional appearance
  - All documentation updated
- **Renamed `run init` → `run install`**: Better matches common tooling patterns
  - Aligns with Makefile/Taskfile conventions (make install, task install)
  - Clearer intent: "install deft framework"
  - Less confusion with bootstrap command
  - Updated all references: "initialized" → "installed", "Reinitialize" → "Reinstall"
- **Updated README.md**: Added Quick Start section with run commands
  - Shows complete workflow: install → bootstrap → project → spec
  - Lists all available commands with descriptions

### Fixed
- **prompt_toolkit installation issues**: Python version mismatch detection
  - Now uses `python -m pip` instead of bare `pip` command
  - Ensures package installs for correct Python interpreter
  - Prevents "module not found" errors when Python 3.x versions differ

## [0.2.4] - 2026-01-22

### Added
- **AgentSkills Integration**: Added `SKILL.md` for Claude Code and clawd.bot compatibility
  - Follows AgentSkills specification for universal AI assistant compatibility
  - Auto-invokes when working in deft projects or mentioning deft standards
  - Teaches AI assistants about rule precedence, lazy loading, TDD, SDD, and quality standards
  - Includes comprehensive "New Project Workflow" section with step-by-step guidance
  - Documents complete SDD process: PRD → AI Interview → Specification → Implementation
  - Compatible with both Claude Code (IDE) and clawd.bot (messaging platforms)
- **clawd.bot Support**: Added clawd.bot-specific metadata to SKILL.md
  - Requires `task` binary (specified in metadata)
  - Supports macOS and Linux platforms
  - Homepage reference to GitHub repository
  - Installation paths for shared and per-agent skills
- **Integration Documentation**: Created `docs/claude-code-integration.md` (renamed to include clawd.bot)
  - Installation instructions for both Claude Code and clawd.bot
  - Usage examples across IDE and messaging platforms
  - Publishing guidance for Skills Marketplace and ClawdHub
  - Multi-agent setup documentation
  - Cross-platform benefits and compatibility notes

### Changed
- **SKILL.md Structure**: Enhanced with detailed workflow sections
  - Step-by-step initialization workflow (init → bootstrap → project → spec)
  - Conditional logic for first-time user setup
  - Complete SDD workflow documentation with user review gates
  - Context-aware workflows for new projects vs existing projects vs new features
  - Integration notes expanded to cover multiple AI platforms

## [0.2.3] - 2026-01-22

### Added
- **Project Type Selection**: Added "Other" option (option 6) to project type selection in `deft.sh project`
  - Prompts for custom project type when selected
  - Allows flexibility for project types beyond CLI, TUI, REST API, Web App, and Library

### Changed
- **Spec Command Output**: Improved next steps messaging in `deft.sh spec`
  - Now displays full absolute paths to PRD.md and SPECIFICATION.md
  - Updated AI assistant references to "Claude, Warp.dev, etc."
  - Added steps 5-7 with guidance on reviewing, implementing, and continuing with AI
  - Clearer instructions: "Ask your AI to read and run {full_path}"

## [0.2.2] - 2026-01-21

### Added
- **LICENSE.md**: Added license file with temporary usage terms through 2026
  - Permission to use (but not distribute) for repository collaborators
  - Future plans for permissive license preventing resale
- **Copyright Notice**: Added copyright to README.md with contact email

## [0.2.1] - 2026-01-18

### Added
- **SCM Directory**: Created `scm/` directory for source control management standards
  - `scm/git.md` - Git workflow and conventions
  - `scm/github.md` - GitHub workflows and releases
  - `scm/changelog.md` - Changelog maintenance standards (releases only)
- **Versioning Standards**: Added `core/versioning.md` with RFC2119-style Semantic Versioning guide
  - Applies to all software types (APIs, UIs, CLIs, libraries)
  - Decision trees, examples, and FAQ
  - Integration with git tags and GitHub releases

### Changed
- **SCM Reorganization**: Moved `tools/git.md` and `tools/github.md` to `scm/` directory
- **Documentation Standards**: All technical docs now use strict RFC2119 notation
  - Use symbols (!, ~, ?, ⊗, ≉) only, no redundant MUST/SHOULD keywords
  - Minimizes token usage while maintaining clarity
- **Internal References**: All docs reference internal files instead of external websites
  - semver.org → `core/versioning.md`
  - keepachangelog.com → `scm/changelog.md`

### Fixed
- Removed all redundant MUST/SHOULD/MAY keywords from technical documentation
- Corrected RFC2119 syntax throughout framework (swarm.md, git.md, github.md)
- Fixed grammar issues in changelog.md

## [0.2.0] - 2026-01-18

### Added

#### Core Features
- **CLI Tool**: New `deft.sh` script for bootstrapping and project setup
  - `deft.sh bootstrap` - Set up user preferences
  - `deft.sh project` - Configure project settings
  - `deft.sh init` - Initialize deft in a new project
  - `deft.sh validate` - Validate configuration files
- **Task Automation**: Added `Taskfile.yml` with framework management tasks
  - `task validate` - Validate all markdown files
  - `task build` - Package framework for distribution
  - `task install` - Install CLI to /usr/local/bin
  - `task stats` - Show framework statistics
- **Template System**: User and project configuration templates
  - `templates/user.md.template` - Template for new users
  - Generic templates in `core/user.md` and `core/project.md`

#### Documentation
- **REFERENCES.md**: Comprehensive lazy-loading guide for when to read which files
- **Expanded Language Support**: Added detailed standards for:
  - C++ (cpp.md) - C++20/23, Catch2/GoogleTest, GSL
  - TypeScript (typescript.md) - Vitest/Jest, strict mode
- **Interface Guidelines**: New interface-specific documentation
  - `interfaces/cli.md` - Command-line interface patterns
  - `interfaces/rest.md` - REST API design
  - `interfaces/tui.md` - Terminal UI (Textual, ink)
  - `interfaces/web.md` - Web UI (React, Tailwind)

#### Organization
- **New `coding/` directory**: Reorganized coding-specific standards
  - `coding/coding.md` - General coding guidelines
  - `coding/testing.md` - Universal testing standards
- **Meta files**: Added self-improvement documentation
  - `meta/code-field.md` - Coding mindset and philosophy
  - `meta/lessons.md` - Codified learnings (AI-updatable)
  - `meta/ideas.md` - Future directions
  - `meta/suggestions.md` - Improvement suggestions

### Changed

#### Breaking Changes
- **Directory Restructure**: Moved files to new locations
  - `core/coding.md` → `coding/coding.md`
  - `tools/testing.md` → `coding/testing.md`
  - All cross-references updated throughout framework
- **User Configuration**: `core/user.md` now in `.gitignore`
  - Users should copy from `templates/user.md.template`
  - Prevents accidental commits of personal preferences

#### Improvements
- **Enhanced README.md**: Comprehensive overview with examples
- **Better Documentation**: Clearer hierarchy and precedence rules
- **Framework Philosophy**: Documented key principles (TDD, SDD, Task-centric workflows)
- **Coverage Requirements**: Standardized at ≥85% across all languages
- **Fuzzing Standards**: Added ≥50 fuzzing tests per input point requirement

### Removed
- **Pronouns Field**: Removed from user bootstrap process in `deft.sh`

### Fixed
- All internal references updated to reflect new directory structure
- Consistent path references across all markdown files
- Cross-reference links in language and interface files

## [0.1.0] - Initial Release

Initial release of the Deft framework with:
- Core AI guidelines (main.md)
- Python and Go language standards
- Basic project structure
- Taskfile integration guidelines
- Git and GitHub workflows

---

## Migration Guide: 0.1.0 → 0.2.0

### File Paths
If you have custom scripts or references to deft files, update these paths:
- `core/coding.md` → `coding/coding.md`
- `tools/testing.md` → `coding/testing.md`

### User Configuration
1. Copy `templates/user.md.template` to `core/user.md`
2. Customize with your preferences
3. Your `core/user.md` will be ignored by git

### New Features to Explore
- Run `deft.sh bootstrap` to set up user preferences interactively
- Check out `REFERENCES.md` for lazy-loading guidance
- Explore new interface guidelines if building CLIs, APIs, or UIs
- Review enhanced language standards for Python, Go, TypeScript, and C++

[0.3.4]: https://github.com/visionik/deft/releases/tag/v0.3.4
[0.3.3]: https://github.com/visionik/deft/releases/tag/v0.3.3
[0.3.2]: https://github.com/visionik/deft/releases/tag/v0.3.2
[0.3.1]: https://github.com/visionik/deft/releases/tag/v0.3.1
[0.3.0]: https://github.com/visionik/deft/releases/tag/v0.3.0
[0.2.5]: https://github.com/visionik/deft/releases/tag/v0.2.5
[0.2.4]: https://github.com/visionik/deft/releases/tag/v0.2.4
[0.2.3]: https://github.com/visionik/deft/releases/tag/v0.2.3
[0.2.2]: https://github.com/visionik/deft/releases/tag/v0.2.2
[0.2.1]: https://github.com/visionik/deft/releases/tag/v0.2.1
[0.2.0]: https://github.com/visionik/deft/releases/tag/v0.2.0
[0.1.0]: https://github.com/visionik/deft/releases/tag/v0.1.0
