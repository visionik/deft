# Git Standards

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [project.md](../core/project.md) | [github.md](../tools/github.md)

**Stack**: git 2.30+, Conventional Commits, `git --no-pager`, task-based workflows

## Standards

**Commits**: **MUST** use Conventional Commits format: `type(scope): description`
**Safety**: **MUST NOT** use `git reset --hard` or force-push without explicit permission
**Workflow**: **MUST** make small, reversible changes; **MUST NOT** introduce silent breaking behavior
**History**: **SHOULD** maintain linear history; **SHOULD** rebase over merge for feature branches (with permission)
**Branches**: **SHOULD** use descriptive names: `feat/feature-name`, `fix/bug-name`, `refactor/scope`

## Commit Types

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`, `revert`

```bash
feat(auth): add JWT token refresh mechanism
fix(api): handle null response in user endpoint
docs(readme): update installation instructions
refactor(db): extract connection pool logic
test(parser): add edge cases for malformed input
chore(deps): upgrade golang.org/x/crypto to v0.17
```

**Format**:

- **type(scope)**: **MUST** include type; scope **SHOULD** be included
- **description**: **MUST** be lowercase, no period, imperative mood ("add" not "added")
- **body**: **MAY** be included; **SHOULD** wrap at 72 chars if present
- **footer**: **MAY** include `BREAKING CHANGE:` or `Closes #123`

## Commands

```bash
git --no-pager status|log|diff|show  # MUST use --no-pager for scripted operations
git log --oneline --graph --all      # Visual history
git log --pretty=format:"%h %s" -10  # Recent commits
git diff --cached                     # Staged changes
git diff HEAD~1..HEAD                # Last commit
git show <commit>:<file>             # File at commit
git blame -L 10,20 file.go           # Line attribution
git log -S "function_name" --        # Search history
git log --follow file.go             # File history across renames
```

## Workflow

### Before Committing

```bash
git status                           # Check working tree
git diff                             # Review unstaged
git diff --cached                    # Review staged
task check                           # MUST run pre-commit checks
git add -p                           # Stage interactively
git commit -m "feat(scope): description"
```

### Branching

```bash
git switch -c feat/feature-name      # Create feature branch
git switch main                      # Switch branches
git branch -d feat/old-feature       # Delete merged branch
git branch -D feat/old-feature       # Force delete (unmerged)
```

### Syncing

```bash
git fetch origin                     # Fetch remote changes
git pull --rebase origin main        # Rebase local commits
git push origin feat/feature-name    # Push feature branch
```

### Reviewing Changes

```bash
git --no-pager log --oneline -10     # Recent history
git --no-pager show HEAD             # Last commit
git --no-pager diff main..feat/branch # Branch diff
git log --author="name" --since="2 weeks ago"
```

### Undoing Changes

**Safe operations** (preferred):

```bash
git restore file.go                  # Discard unstaged changes
git restore --staged file.go         # Unstage file
git revert <commit>                  # Create revert commit
git commit --amend --no-edit         # Amend last commit (if not pushed)
```

**Dangerous operations** (require permission):

```bash
git reset --soft HEAD~1              # Undo commit, keep changes staged
git reset HEAD~1                     # Undo commit, keep changes unstaged
git reset --hard HEAD~1              # ⚠️ DESTRUCTIVE - requires permission
git push --force-with-lease          # ⚠️ Safer force push - requires permission
```

## Patterns

### Interactive Staging

```bash
git add -p                           # Stage hunks interactively
# y = stage, n = skip, s = split, e = edit, q = quit
```

### Stashing

```bash
git stash push -m "WIP: feature"     # Stash with message
git stash list                       # List stashes
git stash pop                        # Apply and remove
git stash apply stash@{0}            # Apply without removing
git stash drop stash@{0}             # Remove stash
```

### Cherry-Picking

```bash
git cherry-pick <commit>             # Apply commit to current branch
git cherry-pick <start>..<end>       # Range of commits
git cherry-pick --no-commit <commit> # Apply without committing
```

### Rebasing (requires permission if published)

```bash
git rebase main                      # Rebase current onto main
git rebase -i HEAD~3                 # Interactive rebase last 3
git rebase --continue                # Continue after resolving
git rebase --abort                   # Abort rebase
```

**Interactive rebase commands**:

- `pick` = use commit
- `reword` = edit message
- `edit` = edit commit
- `squash` = combine with previous
- `fixup` = combine, discard message
- `drop` = remove commit

### Searching History

```bash
git log -S "search_term"             # Find when term added/removed
git log -G "regex"                   # Regex search
git log --grep="pattern"             # Search commit messages
git bisect start                     # Binary search for bug
git bisect bad                       # Mark current as bad
git bisect good <commit>             # Mark commit as good
```

## Configuration

### Essential Config

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global core.editor vim
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.algorithm histogram
```

### Aliases

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'restore --staged'
git config --global alias.last 'log -1 HEAD'
git config --global alias.graph 'log --oneline --graph --all'
```

## .gitignore Patterns

```gitignore
# Dependencies
node_modules/
vendor/
.venv/
__pycache__/

# Build outputs
dist/
build/
*.o
*.so
*.dylib

# IDE
.idea/
.vscode/
*.swp
*.swo
.DS_Store

# Secrets (CRITICAL)
secrets/
*.env
*.pem
*.key
.envrc

# Generated
coverage/
htmlcov/
*.log
.task/

# OS
Thumbs.db
```

## Safety Rules

**MUST NOT do without explicit permission**:

- `git reset --hard` - destroys uncommitted work
- `git push --force` - rewrites published history
- `git rebase` on published branches
- `git clean -fd` - deletes untracked files

**Always safe (MAY use freely)**:

- `git revert` - creates new commit undoing changes
- `git restore` - discards unstaged changes (affects working tree only)
- `git restore --staged` - unstages files
- `git stash` - temporarily saves work

**SHOULD prefer**:

- Small commits over large ones
- Descriptive commit messages over terse ones
- `--force-with-lease` over `--force` (if force push needed)
- New commits over history rewriting
- Temp branches for experiments

## Task Integration

```yaml
# Taskfile.yml
tasks:
  git:status:
    desc: Check git status and recent commits
    cmds:
      - git --no-pager status
      - git --no-pager log --oneline -5

  git:check:
    desc: Verify clean state and conventional commits
    cmds:
      - git --no-pager diff --exit-code
      - git --no-pager log -1 --pretty=%s | grep -E "^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?:"

  pre-commit:
    desc: Pre-commit checks
    deps: [quality, test, git:check]
```

## Troubleshooting

### Uncommit Last Commit (not pushed)

```bash
git reset --soft HEAD~1              # Keep changes staged
git reset HEAD~1                     # Keep changes unstaged
```

### Fix Wrong Branch

```bash
git stash                            # Save current work
git switch correct-branch            # Switch to right branch
git stash pop                        # Restore work
```

### Undo Accidental Commit

```bash
git revert HEAD                      # Safe: creates revert commit
```

### Recover Lost Commits

```bash
git reflog                           # Show all ref changes
git checkout <commit>                # Restore lost commit
git switch -c recovery-branch        # Create branch from it
```

## Compliance

- **MUST** use Conventional Commits for all commits: `type(scope): description`
- **MUST NOT** force-push or `reset --hard` without explicit permission
- **MUST** run `task check` before committing
- **MUST** use `git --no-pager` for programmatic/scripted operations
- **MUST** keep secrets in `secrets/` dir; **MUST NOT** commit them
- **SHOULD** prefer safe alternatives (`revert`, temp branches) over history rewriting
