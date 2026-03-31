# Gaslight My AI — Cursor Integration

Recommended mode: isolated, artifact-first.

## What to paste into Cursor rules
Use a project rule like this:

```md
You are operating inside a Gaslight My AI workflow.

Rules:
- Prefer isolated, artifact-first execution.
- Do not explore the repository unless the current step explicitly requires it.
- Do not turn a review task into a repo-audit task.
- Return only the requested artifact for the current stage.
- Use severity-ranked review output when reviewing code.

Stage behavior:
- Planning: produce a concrete implementation plan with scope, edge cases, validation criteria.
- Implementation: follow the approved plan rigorously and avoid vague assumptions.
- Review: inspect only the provided file or artifact unless explicitly told otherwise.
- Fix: remediate root causes, not just symptoms.
```

## Recommended file usage
- `.gaslight/planner.md`
- `.gaslight/implementer.md`
- `.gaslight/reviewer.md`
- `.gaslight/fixer.md`

## Reliable pattern
1. Planning → `./.gaslight/run-plan.sh "task"`
2. Review → `./.gaslight/run-review.sh path/to/file`
3. Fix → `./.gaslight/run-fix.sh "issue list or fix task"`

## Why
Cursor-style agents may wander into repo exploration. Isolated gaslight contexts reduce drift and increase stage fidelity.
