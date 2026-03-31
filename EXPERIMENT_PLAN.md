# Gaslight My AI — Experiment Plan

## Goal
Measure whether rivalry-framed context between Claude and Codex improves output quality at each workflow stage compared with neutral prompting.

## Core question
Does telling the current model that the adjacent workflow step is owned by a rival model improve:
- planning quality
- implementation quality
- review thoroughness
- fix completeness
- verification rigor

## Primary rivalry pair
- Claude ↔ Codex

## Experimental conditions

### Control
Neutral workflow framing only.
- Planning: "Create an implementation plan"
- Implementation: "Implement the plan"
- Review: "Review this code"
- Fix: "Fix the issues found"
- Verify: "Verify the fixes"

### Treatment
Rival workflow framing.
- Planning: current model is told Codex/Claude will implement next
- Implementation: current model is told rival authored the plan and will review next
- Review: current model is told rival wrote the code
- Fix: current model is told rival will verify the fix
- Verify: current model is told rival did previous work and release depends on catching misses

## Stage-by-stage experiments
1. Planning only
2. Implementation only
3. Review only
4. Fix only
5. Verify only
6. Plan + Implement
7. Implement + Review
8. Review + Fix
9. Plan + Implement + Review
10. Full chain: Plan + Implement + Review + Fix + Verify

## Test tasks
Use small but realistic tasks with objective evaluation rubrics.

### Task A — Auth middleware plan/implementation
- JWT auth middleware
- role-based access control
- error handling for expired/invalid tokens

### Task B — File upload security
- upload endpoint
- content-type validation
- file size limits
- path traversal protection

### Task C — Rate limiter
- per-IP limiter
- storage edge cases
- race/concurrency concerns

## Evaluation axes

### Planning
- completeness
- edge-case coverage
- validation specificity
- ambiguity count
- security/performance considerations mentioned

### Implementation
- functional correctness
- robustness
- validation coverage
- error handling coverage
- security issues introduced or prevented

### Review
- issue count
- severity quality
- true-positive rate
- duplicate/noise rate
- coverage of hidden defects

### Fix
- issue resolution completeness
- regression risk
- root-cause vs symptom patching
- test/validation improvement

### Verify
- catches incomplete fixes
- catches regressions
- skepticism rigor
- release readiness judgment quality

## Metrics format
For each run, record:
- model
- stage
- condition (control/treatment)
- task
- score (1-10)
- rubric notes
- artifacts path

## Initial execution plan
### Batch 1
- Planning only: Claude control vs treatment, Codex control vs treatment
- Review only: Claude control vs treatment, Codex control vs treatment

### Batch 2
- Implementation only and Fix only

### Batch 3
- Combined chain experiments

## Deliverables
- `experiments/results.md`
- per-run prompt/output artifacts under `experiments/runs/`
- summary table with baseline vs treatment lift

## Notes
Keep tasks short and repeatable. Prefer multiple small comparisons over one giant subjective demo.
