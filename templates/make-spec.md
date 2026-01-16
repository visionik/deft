# Specification Generation

Agent workflow for creating project specifications via structured interview.

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

## Input Template

```
I want to build ________ that has the following features:
1. (feature)
2. (feature)
3. (feature)
```

## Interview Process

- ~ Use Claude AskInterviewQuestion when available
- ! If placeholders remain: ask overview, then features, then details
- ! Ask one focused, non-trivial question per step
- ~ Provide numbered answer options when appropriate
- ! Include "other" option for custom/unknown responses

**Question Areas:**
- ! Missing decisions (language, framework, deployment)
- ! Edge cases (errors, boundaries, failure modes)
- ! Implementation details (architecture, patterns, libraries)
- ! Requirements (performance, security, scalability)
- ! UX/constraints (users, timeline, compatibility)
- ! Tradeoffs (simplicity vs features, speed vs safety)

**Completion:**
- ! Continue until little ambiguity remains
- ! Ensure spec is comprehensive enough to implement

## Output Generation

- ! Generate as SPECIFICATION.md
- ! Break into phases, subphases, tasks
- ! Mark all dependencies explicitly: "Phase 2 (depends on: Phase 1)"
- ! Design for parallel work (multiple agents)
- ⊗ Write code (specification only)

**Structure:**
```markdown
# Project Name
## Overview
## Requirements
## Architecture
## Implementation Plan
### Phase 1: Foundation
#### Subphase 1.1: Setup
- Task 1.1.1: (description, dependencies, acceptance criteria)
#### Subphase 1.2: Core (depends on: 1.1)
### Phase 2: Features (depends on: Phase 1)
## Testing Strategy
## Deployment
```

## Best Practices

- ! Detailed enough to implement without guesswork
- ! Clear scope boundaries (in vs out)
- ! Include rationale for major decisions
- ~ Size tasks for 1-4 hours
- ! Minimize inter-task dependencies
- ! Define clear component interfaces

## Anti-Patterns

- ⊗ Multiple questions at once
- ⊗ Assumptions without clarifying
- ⊗ Vague requirements
- ⊗ Missing dependencies
- ⊗ Sequential tasks that could be parallel
