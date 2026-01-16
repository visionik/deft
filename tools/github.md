# GitHub Standards

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [project.md](../core/project.md) | [git.md](../tools/git.md)

**Stack**: gh CLI 2.0+, GitHub Actions, Conventional Commits, issue/PR workflows

## Standards

**PRs**: **MUST** use descriptive titles (Conventional Commits format); **SHOULD** link issues; **SHOULD** request reviews
**Issues**: **SHOULD** include clear reproduction steps, expected vs actual behavior, environment details
**Reviews**: **SHOULD** provide constructive feedback; **MUST** use appropriate status (approve/request changes/comment)
**Actions**: **SHOULD** provide fast feedback, fail fast, cache dependencies, use matrix testing
**Releases**: **MUST** use semantic versioning; **SHOULD** include changelogs and release notes

## gh CLI Commands

### Authentication & Config

```bash
gh auth login                        # Authenticate with GitHub
gh auth status                       # Check auth status
gh config set editor vim             # Set editor
gh config set git_protocol ssh       # Use SSH for git ops
```

### Repository Operations

```bash
gh repo view                         # View current repo
gh repo view owner/repo              # View specific repo
gh repo clone owner/repo             # Clone repo
gh repo fork                         # Fork current repo
gh repo create                       # Create new repo
gh repo sync                         # Sync fork with upstream
```

### Pull Requests

```bash
gh pr create                         # Create PR (interactive)
gh pr create -t "title" -b "body"    # Create with title/body
gh pr create -f                      # Fill from last commit
gh pr list                           # List PRs
gh pr list --state all               # All PRs (open/closed/merged)
gh pr status                         # Your PRs
gh pr view 123                       # View PR #123
gh pr view 123 --web                 # Open in browser
gh pr diff 123                       # View PR diff
gh pr checkout 123                   # Checkout PR locally
gh pr review 123                     # Review PR
gh pr review 123 --approve           # Approve PR
gh pr review 123 --request-changes   # Request changes
gh pr review 123 --comment -b "msg"  # Add review comment
gh pr merge 123                      # Merge PR
gh pr merge 123 --squash             # Squash merge
gh pr merge 123 --rebase             # Rebase merge
gh pr close 123                      # Close without merge
gh pr reopen 123                     # Reopen closed PR
```

### Issues

```bash
gh issue create                      # Create issue (interactive)
gh issue create -t "title" -b "body" # Create with title/body
gh issue list                        # List issues
gh issue list --assignee @me         # Your assigned issues
gh issue list --label bug            # Issues with label
gh issue view 456                    # View issue #456
gh issue view 456 --web              # Open in browser
gh issue close 456                   # Close issue
gh issue reopen 456                  # Reopen issue
gh issue comment 456 -b "comment"    # Add comment
gh issue edit 456 --add-label bug    # Add label
gh issue edit 456 --add-assignee @me # Assign to self
```

### GitHub Actions

```bash
gh workflow list                     # List workflows
gh workflow view                     # View workflow details
gh workflow run workflow.yml         # Trigger workflow
gh run list                          # List workflow runs
gh run view                          # View latest run
gh run view 789                      # View specific run
gh run watch                         # Watch current run
gh run rerun 789                     # Rerun workflow
gh run cancel 789                    # Cancel run
gh run download 789                  # Download artifacts
```

### Releases

```bash
gh release create v1.0.0             # Create release
gh release create v1.0.0 --generate-notes # Auto-generate notes
gh release list                      # List releases
gh release view v1.0.0               # View release
gh release download v1.0.0           # Download assets
gh release delete v1.0.0             # Delete release
```

### Search & Browse

```bash
gh search repos "query"              # Search repositories
gh search issues "query"             # Search issues
gh search prs "query"                # Search pull requests
gh browse                            # Open repo in browser
gh browse 123                        # Open PR/issue in browser
```

## PR Workflow

### Creating a PR

```bash
# 1. Create feature branch
git switch -c feat/feature-name

# 2. Make changes, commit with Conventional Commits
git add .
git commit -m "feat(scope): add feature description"

# 3. Push branch
git push -u origin feat/feature-name

# 4. Create PR
gh pr create --title "feat(scope): feature description" \
             --body "## Description
Brief summary of changes

## Changes
- Change 1
- Change 2

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

Closes #123"

# Alternative: Interactive creation
gh pr create
```

### PR Template (.github/pull_request_template.md)

```markdown
## Description

Brief summary of the changes and their purpose.

## Type of Change

- [ ] feat: New feature
- [ ] fix: Bug fix
- [ ] docs: Documentation update
- [ ] refactor: Code refactoring
- [ ] test: Adding or updating tests
- [ ] chore: Maintenance or tooling

## Changes

- List specific changes
- Be concise but complete

## Testing

- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Coverage ≥75%
- [ ] Manual testing completed

## Checklist

- [ ] Code follows project style guidelines (MUST)
- [ ] Self-reviewed code and comments (SHOULD)
- [ ] Updated documentation (SHOULD)
- [ ] No breaking changes (or documented) (MUST)
- [ ] `task check` passes (MUST)

## Related Issues

Closes #issue_number
```

### Reviewing PRs

```bash
# View PR
gh pr view 123

# Check out and test locally
gh pr checkout 123
task check

# Leave review
gh pr review 123 --comment -b "Great work! Minor suggestions inline."
gh pr review 123 --approve -b "LGTM! ✅"
gh pr review 123 --request-changes -b "Please address the failing tests."
```

### Review Guidelines

**Approval criteria (MUST be met)**:

- Code follows language standards (python.md, go.md, cpp.md)
- Tests pass with ≥75% coverage
- Conventional Commits format
- No security vulnerabilities
- Documentation updated
- No breaking changes (or properly documented)

**Review tone (SHOULD follow)**:

- Be constructive and specific
- Explain "why" not just "what"
- Suggest alternatives when requesting changes
- Praise good solutions
- Focus on correctness, maintainability, performance (in that order)

## Issue Workflow

### Creating Issues

```bash
# Interactive
gh issue create

# Direct
gh issue create --title "bug(component): brief description" \
                --body "## Description
Clear description of the bug or feature request.

## Steps to Reproduce (for bugs)
1. Step one
2. Step two
3. Observe error

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: macOS 14.0
- Version: v1.2.3
- Go: 1.21

## Additional Context
Logs, screenshots, etc."
```

### Issue Template (.github/ISSUE_TEMPLATE/bug_report.md)

```markdown
---
name: Bug Report
about: Report a bug or unexpected behavior
labels: bug
---

## Description

Clear and concise description of the bug.

## Steps to Reproduce

1. Step one
2. Step two
3. Observe error

## Expected Behavior

What should happen.

## Actual Behavior

What actually happens.

## Environment

- OS: [e.g., macOS 14.0, Ubuntu 22.04]
- Version: [e.g., v1.2.3]
- Language/Runtime: [e.g., Go 1.21, Python 3.11]

## Logs/Screenshots

Paste relevant logs or attach screenshots.

## Additional Context

Any other relevant information.
```

### Issue Labels

**Priority**:

- `priority:critical` - Production down, security issue
- `priority:high` - Major functionality broken
- `priority:medium` - Important but not blocking
- `priority:low` - Nice to have

**Type**:

- `bug` - Something broken
- `feat` - New feature request
- `docs` - Documentation improvement
- `refactor` - Code improvement
- `test` - Testing related
- `chore` - Maintenance

**Status**:

- `status:blocked` - Waiting on dependency
- `status:in-progress` - Being worked on
- `status:needs-info` - Needs more information
- `status:wontfix` - Will not be addressed

## GitHub Actions Workflow

### Basic CI (.github/workflows/ci.yml)

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        # Python example
        python-version: ["3.11", "3.12"]
        # Or Go example
        # go-version: ['1.21', '1.22']

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: ~/.cache/pip
          key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}

      - name: Install dependencies
        run: |
          pip install -e ".[dev]"

      - name: Run quality checks
        run: |
          task py:fmt
          task py:lint
          task py:type

      - name: Run tests
        run: task test:coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
```

### Release Workflow (.github/workflows/release.yml)

```yaml
name: Release

on:
  push:
    tags:
      - "v*"

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Generate changelog
        id: changelog
        run: |
          # Generate from conventional commits
          git log --pretty=format:"%s" $(git describe --tags --abbrev=0 @^)..@ > changes.txt

      - name: Create release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: Release ${{ github.ref }}
          body_path: changes.txt
          draft: false
          prerelease: false
```

## Task Integration

```yaml
# Taskfile.yml
tasks:
  gh:pr:create:
    desc: Create PR with conventional commit format
    cmds:
      - gh pr create --fill

  gh:pr:check:
    desc: Check out and verify PR locally
    cmds:
      - gh pr checkout {{.CLI_ARGS}}
      - task check

  gh:issue:mine:
    desc: List your assigned issues
    cmds:
      - gh issue list --assignee @me

  gh:ci:status:
    desc: Check CI status
    cmds:
      - gh run list --limit 5
      - gh run view

  gh:release:
    desc: Create release from tag
    cmds:
      - gh release create {{.TAG}} --generate-notes
```

## Best Practices

### PR Best Practices

**Size**: Keep PRs small (< 400 lines changed ideal)
**Scope**: One logical change per PR
**Title**: Use Conventional Commits format
**Description**: Explain "why" not just "what"
**Tests**: Include tests, maintain ≥75% coverage
**Reviews**: Request specific reviewers
**CI**: Ensure all checks pass before requesting review
**Links**: Reference related issues/PRs

### Issue Best Practices

**Search first**: Check for duplicates before creating
**Specificity**: Provide reproduction steps, environment details
**Labels**: Apply appropriate labels
**Assignees**: Assign when someone takes ownership
**Milestones**: Group related issues
**Projects**: Track progress in project boards

### Branch Protection Rules

**Recommended settings** for `main`:

- ✅ Require pull request reviews (1+ approvals)
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Require conversation resolution
- ✅ Require linear history (optional but recommended)
- ❌ Allow force pushes (NEVER)
- ❌ Allow deletions (NEVER)

### Security

**Secrets management**:

- Use GitHub Secrets for CI/CD credentials
- Never commit secrets to repo
- Keep secrets in `secrets/` dir locally (gitignored)
- Rotate secrets regularly
- Use least-privilege access

**Dependabot**:

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "pip" # or "gomod", "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

## Common Workflows

### Hotfix Workflow

```bash
# Create hotfix branch from main
git switch main
git pull
git switch -c fix/critical-bug

# Make fix
# ... edit files ...

# Test thoroughly
task check

# Commit and push
git add .
git commit -m "fix(component): resolve critical bug"
git push -u origin fix/critical-bug

# Create PR with priority label
gh pr create --title "fix(component): resolve critical bug" \
             --label "priority:critical" \
             --body "Fixes critical production issue.

Closes #issue"

# After approval, merge immediately
gh pr merge --squash --delete-branch
```

### Feature Development

```bash
# Create feature branch
git switch -c feat/new-feature

# Develop incrementally
# ... commit frequently ...

# Keep up to date with main
git fetch origin
git rebase origin/main

# Push and create draft PR early
gh pr create --draft

# Mark ready when complete
gh pr ready

# Respond to review feedback
# ... make changes ...
git add .
git commit -m "fix(review): address review comments"
git push
```

## Compliance

- Use Conventional Commits for all PR titles
- Maintain ≥75% test coverage
- Pass all CI checks before merge
- Request reviews from appropriate team members
- Link PRs to related issues
- Use gh CLI for automation where possible
- Never force-push to protected branches
- Keep PR scope focused and size reasonable
- Update documentation with code changes
