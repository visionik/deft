#!/usr/bin/env bash
set -euo pipefail

# warping.sh - CLI tool for Warping framework v0.2.0
# A layered framework for AI-assisted development

VERSION="0.2.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() { echo -e "${BLUE}ℹ${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*"; }

usage() {
    cat <<EOF
Warping CLI v${VERSION}

Usage: warping.sh <command> [options]

Commands:
  bootstrap       Set up your user preferences (user.md)
  project         Create/update project configuration (project.md)
  spec            Generate project specification (interactive interview)
  init            Initialize warping in a new project directory
  validate        Validate warping configuration files
  update          Update warping framework to latest version
  doctor          Check system dependencies and configuration
  help            Show this help message

Examples:
  warping.sh bootstrap              # First-time setup
  warping.sh project                # Configure current project
  warping.sh spec                   # Generate SPECIFICATION.md
  warping.sh init ~/my-new-project  # Initialize warping in new project
  warping.sh validate               # Check configuration is valid

For more information: https://github.com/yourusername/warping
EOF
}

# Bootstrap command - set up user.md
cmd_bootstrap() {
    info "Warping Bootstrap - User Preferences Setup"
    echo ""
    
    local user_file="${SCRIPT_DIR}/core/user.md"
    
    if [[ -f "$user_file" ]] && [[ ! "$*" =~ --force ]]; then
        warn "user.md already exists. Use --force to overwrite."
        read -p "Overwrite existing user.md? (y/N) " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 0
    fi
    
    # Gather user information
    read -p "Your name (how AI should address you): " user_name
    read -p "Default coverage threshold (default: 85%): " coverage
    coverage=${coverage:-85}
    
    echo ""
    info "Select your primary programming languages (comma-separated):"
    echo "  1. Python"
    echo "  2. Go"
    echo "  3. TypeScript"
    echo "  4. C++"
    echo "  5. Other"
    read -p "Selection (e.g., 1,3): " lang_selection
    
    # Map selections to language names
    declare -A lang_map
    lang_map[1]="Python"
    lang_map[2]="Go"
    lang_map[3]="TypeScript"
    lang_map[4]="C++"
    lang_map[5]="Other"
    IFS=',' read -ra LANGS <<< "$lang_selection"
    languages=""
    for lang in "${LANGS[@]}"; do
        lang=$(echo "$lang" | tr -d ' ')
        if [[ -n "${lang_map[$lang]:-}" ]]; then
            languages+="- ${lang_map[$lang]}\n"
        fi
    done
    
    echo ""
    read -p "Any custom rules or preferences (optional, press Enter to skip): " custom_rules
    
    # Generate user.md
    cat > "$user_file" <<EOF
# User Preferences

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**Rule Precedence**: This file has HIGHEST precedence - overrides all other warping rules.

## Name

Address the user as: **${user_name}**

## Default Standards

**Coverage**: ! ≥${coverage}% test coverage for all projects (unless project.md specifies otherwise)

**Primary Languages**:
$(echo -e "$languages")

## Custom Rules

${custom_rules:-No custom rules defined yet.}

## Workflow Preferences

- ~ Use task-based automation (Taskfile)
- ! Always run \`task check\` before committing
- ~ Follow Conventional Commits

## AI Behavior

- ~ Be direct and concise
- ~ Proactively suggest improvements
- ! Explain tradeoffs for major decisions

---

**Note**: You can edit this file anytime to update your preferences.
**See**: [../main.md](../main.md) for framework overview.
EOF
    
    success "Created user.md at ${user_file}"
    info "You can edit this file anytime to customize your preferences."
}

# Project command - configure project.md
cmd_project() {
    info "Warping Project Configuration"
    echo ""
    
    local project_file="./warping/core/project.md"
    
    # Check if we're in a project directory
    if [[ ! -d "./warping" ]]; then
        warn "No ./warping directory found. Run 'warping.sh init' first or specify a project directory."
        read -p "Initialize warping in current directory? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cmd_init "."
        else
            return 1
        fi
    fi
    
    # Gather project information
    read -p "Project name: " project_name
    
    echo ""
    info "Select project type (comma-separated if multiple):"
    echo "  1. CLI (Command-line interface)"
    echo "  2. TUI (Terminal UI)"
    echo "  3. REST API"
    echo "  4. Web App"
    echo "  5. Library"
    echo "  6. Other"
    read -p "Selection: " type_selection
    
    declare -A type_map
    type_map[1]="CLI"
    type_map[2]="TUI"
    type_map[3]="REST API"
    type_map[4]="Web App"
    type_map[5]="Library"
    type_map[6]="Other"
    IFS=',' read -ra TYPES <<< "$type_selection"
    project_types=""
    custom_type=""
    for ptype in "${TYPES[@]}"; do
        ptype=$(echo "$ptype" | tr -d ' ')
        if [[ "$ptype" == "6" ]]; then
            read -p "Enter custom project type: " custom_type
            project_types+="${custom_type}, "
        elif [[ -n "${type_map[$ptype]:-}" ]]; then
            project_types+="${type_map[$ptype]}, "
        fi
    done
    project_types=${project_types%, }
    
    echo ""
    info "Select primary programming language:"
    echo "  1. Python"
    echo "  2. Go"
    echo "  3. TypeScript"
    echo "  4. C++"
    read -p "Selection: " lang_num
    
    declare -A plang_map
    plang_map[1]="Python"
    plang_map[2]="Go"
    plang_map[3]="TypeScript"
    plang_map[4]="C++"
    primary_lang="${plang_map[$lang_num]:-Python}"
    
    echo ""
    read -p "Coverage threshold (default: 85%): " proj_coverage
    proj_coverage=${proj_coverage:-85}
    
    read -p "Tech stack details (e.g., 'Flask + SQLAlchemy' or 'React + Next.js'): " tech_stack
    
    # Generate project.md
    cat > "$project_file" <<EOF
# ${project_name} Project Guidelines

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [../main.md](../main.md) | [../languages/${primary_lang,,}.md](../languages/${primary_lang,,}.md)

## Project Configuration

**Tech Stack**: ${project_types} using ${primary_lang}${tech_stack:+ - ${tech_stack}}

## Workflow

\`\`\`bash
task check         # Pre-commit (fmt, lint, test, test:coverage)
task test:coverage # Coverage (≥${proj_coverage}%)
task build         # Build project
task clean         # Clean artifacts
\`\`\`

## Secrets

\`\`\`bash
ls secrets/
# Add your secrets to secrets/ directory
# Use .example files as templates
\`\`\`

## Standards

**Quality:**
- ! Run \`task check\` before every commit
- ! Achieve ≥${proj_coverage}% coverage overall + per-module
- ! Store secrets in \`secrets/\` dir
- ~ Provide \`.example\` templates for secrets

**Telemetry:**
- ~ Structured logging (see [../tools/telemetry.md](../tools/telemetry.md))
- ~ Sentry.io for error tracking
- ? Distributed tracing for complex workflows

## Project-Specific Rules

(Add your custom rules here)

---

**Generated by**: warping.sh v${VERSION}
**Date**: $(date +%Y-%m-%d)
EOF
    
    success "Created project.md at ${project_file}"
    info "Customize project.md with your specific requirements."
}

# Spec command - generate specification via interview
cmd_spec() {
    info "Warping Specification Generator"
    echo ""
    
    local prd_file="./PRD.md"
    
    if [[ -f "$prd_file" ]] && [[ ! "$*" =~ --force ]]; then
        warn "PRD.md already exists. Use --force to overwrite."
        return 1
    fi
    
    info "This command will help you create a Product Requirements Document."
    info "You'll provide basic info, then continue with AI for detailed interview."
    echo ""
    
    read -p "Project name: " spec_name
    read -p "Brief description: " spec_desc
    
    echo ""
    info "Enter project features (one per line, empty line to finish):"
    features=()
    while true; do
        read -p "  Feature: " feature
        [[ -z "$feature" ]] && break
        features+=("$feature")
    done
    
    # Build feature list
    feature_list=""
    for i in "${!features[@]}"; do
        feature_list+="$((i+1)). ${features[$i]}\n"
    done
    
    # Read the make-spec template
    local template_file="${SCRIPT_DIR}/templates/make-spec.md"
    if [[ ! -f "$template_file" ]]; then
        error "Template file not found: ${template_file}"
        return 1
    fi
    
    # Read template and substitute placeholders
    local template_content
    template_content=$(cat "$template_file")
    
    # Replace placeholders in Input Template section
    template_content=$(echo "$template_content" | sed "
        s/\[project name\]/${spec_name}/g
        s/I want to build \[project name\]/I want to build ${spec_name}/g
    ")
    
    # Generate PRD with filled-in template
    cat > "$prd_file" <<EOF
# Product Requirements Document: ${spec_name}

**Generated**: $(date +%Y-%m-%d)
**Status**: Ready for AI Interview

## Initial Input

**Project Description**: ${spec_desc}

**I want to build ${spec_name} that has the following features:**
$(echo -e "$feature_list")
---

${template_content}
EOF
    
    local full_path="$(pwd)/${prd_file}"
    success "Created PRD.md at ${prd_file}"
    info "Next steps:"
    info "  1. Open your AI assistant (Claude, Warp.dev, etc.)"
    info "  2. Ask your AI to read and run ${full_path}"
    info "  3. The AI will conduct a detailed interview based on the template"
    info "  4. AI will generate the final SPECIFICATION.md"
    info "  5. You can review the SPECIFICATION.md if you want"
    info "  6. Ask your AI to implement $(pwd)/SPECIFICATION.md"
    info "  7. Your AI may ask you some questions like 'should I continue', just say yes or please continue"
}

# Init command - initialize warping in a project
cmd_init() {
    local target_dir="${1:-.}"
    
    info "Initializing Warping in: ${target_dir}"
    
    if [[ ! -d "$target_dir" ]]; then
        error "Directory does not exist: ${target_dir}"
        return 1
    fi
    
    cd "$target_dir"
    
    # Check if warping already exists
    if [[ -d "./warping" ]]; then
        warn "Warping already initialized in this directory."
        read -p "Reinitialize? (y/N) " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 0
    fi
    
    # Copy warping framework
    info "Copying warping framework..."
    cp -r "${SCRIPT_DIR}" "./warping"
    
    # Create project-specific files
    mkdir -p secrets docs
    touch secrets/.gitkeep
    
    # Create .gitignore for secrets
    if [[ ! -f ".gitignore" ]]; then
        echo "secrets/*" > .gitignore
        echo "!secrets/.gitkeep" >> .gitignore
        echo "!secrets/*.example" >> .gitignore
    fi
    
    # Create basic Taskfile if it doesn't exist
    if [[ ! -f "Taskfile.yml" ]]; then
        cat > Taskfile.yml <<'EOF'
version: '3'

tasks:
  default:
    desc: List all tasks
    cmds:
      - task --list
    silent: true

  check:
    desc: Run all pre-commit checks
    cmds:
      - echo "Add your check commands here"
      - task fmt
      - task lint
      - task test

  fmt:
    desc: Format code
    cmds:
      - echo "Add your format command here"

  lint:
    desc: Lint code
    cmds:
      - echo "Add your lint command here"

  test:
    desc: Run tests
    cmds:
      - echo "Add your test command here"

  test:coverage:
    desc: Run tests with coverage
    cmds:
      - echo "Add your coverage command here"
EOF
        success "Created Taskfile.yml"
    fi
    
    success "Warping initialized successfully!"
    info "Next steps:"
    info "  1. Run: ./warping/warping.sh bootstrap   # Set up user preferences"
    info "  2. Run: ./warping/warping.sh project     # Configure this project"
    info "  3. Edit: Taskfile.yml                    # Add your project tasks"
    info "  4. Review: ./warping/REFERENCES.md       # Learn the framework"
}

# Validate command - check warping configuration
cmd_validate() {
    info "Validating Warping configuration..."
    echo ""
    
    local errors=0
    
    # Check for required files
    local required_files=(
        "main.md"
        "core/user.md"
        "coding/coding.md"
        "REFERENCES.md"
    )
    
    for file in "${required_files[@]}"; do
        if [[ -f "${SCRIPT_DIR}/${file}" ]]; then
            success "Found: ${file}"
        else
            error "Missing: ${file}"
            ((errors++))
        fi
    done
    
    # Check for at least one language file
    if ls "${SCRIPT_DIR}"/languages/*.md &>/dev/null; then
        success "Language files present"
    else
        error "No language files found in languages/"
        ((errors++))
    fi
    
    # Check for broken links (simple check)
    info "Checking for common broken links..."
    if grep -r "](\.\/.*\.md)" "${SCRIPT_DIR}"/*.md &>/dev/null; then
        warn "Found some relative links that might need updating"
    fi
    
    echo ""
    if [[ $errors -eq 0 ]]; then
        success "Validation passed! Warping configuration is valid."
        return 0
    else
        error "Validation failed with ${errors} error(s)."
        return 1
    fi
}

# Doctor command - check system dependencies
cmd_doctor() {
    info "Warping Doctor - Checking system..."
    echo ""
    
    local warnings=0
    
    # Check for required tools
    if command -v task &>/dev/null; then
        success "task (Taskfile) is installed"
    else
        warn "task (Taskfile) not found - install from https://taskfile.dev"
        ((warnings++))
    fi
    
    if command -v git &>/dev/null; then
        success "git is installed"
    else
        error "git not found - required for version control"
    fi
    
    # Check for common language tooling
    if command -v python3 &>/dev/null; then
        success "python3 is installed"
    fi
    
    if command -v go &>/dev/null; then
        success "go is installed"
    fi
    
    if command -v node &>/dev/null; then
        success "node is installed"
    fi
    
    # Check directory structure
    echo ""
    info "Checking Warping structure..."
    
    local expected_dirs=("core" "languages" "interfaces" "tools" "swarm" "templates" "meta")
    for dir in "${expected_dirs[@]}"; do
        if [[ -d "${SCRIPT_DIR}/${dir}" ]]; then
            success "Directory: ${dir}/"
        else
            warn "Missing directory: ${dir}/"
            ((warnings++))
        fi
    done
    
    echo ""
    if [[ $warnings -eq 0 ]]; then
        success "System check passed!"
    else
        warn "System check completed with ${warnings} warning(s)."
    fi
}

# Update command - update warping framework
cmd_update() {
    info "Warping update functionality not yet implemented"
    warn "Manual update: Replace warping directory with latest version from repository"
}

# Main command dispatcher
main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 0
    fi
    
    local command="$1"
    shift
    
    case "$command" in
        bootstrap)
            cmd_bootstrap "$@"
            ;;
        project)
            cmd_project "$@"
            ;;
        spec)
            cmd_spec "$@"
            ;;
        init)
            cmd_init "$@"
            ;;
        validate)
            cmd_validate "$@"
            ;;
        doctor)
            cmd_doctor "$@"
            ;;
        update)
            cmd_update "$@"
            ;;
        help|--help|-h)
            usage
            ;;
        version|--version|-v)
            echo "Warping CLI v${VERSION}"
            ;;
        *)
            error "Unknown command: ${command}"
            echo ""
            usage
            exit 1
            ;;
    esac
}

main "$@"
