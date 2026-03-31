# Gaslight My AI — Cursor Integration

Recommended mode: isolated, artifact-first.

## Setup
- Load `.gaslight/planner.md`, `.gaslight/implementer.md`, `.gaslight/reviewer.md`, `.gaslight/fixer.md` into project rules or workspace instructions.
- Prefer stage-by-stage execution over one giant chain.

## Reliable pattern
1. Planning → use `./.gaslight/run-plan.sh "task"`
2. Review → use `./.gaslight/run-review.sh path/to/file`
3. Fix → use `./.gaslight/run-fix.sh "issues here"`

## Why
Cursor-style agents may wander into repo exploration. Isolated gaslight contexts reduce drift and increase stage fidelity.
