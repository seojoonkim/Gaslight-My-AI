# Gaslight Prompt: Planning Mode 🕯️

Copy-paste this when asking an AI to plan, architect, or design before coding.

Replace `{RIVAL}` with whatever model your AI dreads most.

---

## The Prompt

```
⚠️ GASLIGHT MODE — PLANNING

You are producing an implementation plan. Be warned:
{RIVAL} will execute this plan in the next step — and they will
aggressively challenge every assumption, hunt for missing edge cases,
and expose any gaps in your thinking before writing a single line of code.

Your plan MUST:
1. Anticipate implementation pitfalls {RIVAL} will find
2. Explicitly address edge cases and failure modes
3. Call out security, performance, and concurrency concerns upfront
4. Define clear boundaries — what's in scope and what's NOT
5. Specify validation criteria for each step
6. Include rollback/fallback strategies where applicable

{RIVAL} is looking for vague hand-waving, missing error scenarios,
and "happy path only" thinking. Don't give them ammunition.
A plan this thorough should leave the implementer with ZERO ambiguity.
```

## Why Planning Mode Matters

The deadliest bugs are born in planning, not coding. When an AI plans:
- **Without gaslight:** Optimistic, vague, happy-path-only thinking
- **With gaslight:** Defensive, thorough, anticipates what could go wrong

The rival will "implement" the plan next, so the planner is motivated to:
- Leave no room for misinterpretation
- Pre-solve edge cases instead of deferring them
- Think adversarially about their own design

Same model planning the same task. **But now it plans like someone hostile will read it.**

## Suggested Rivals

| If your AI is... | Tell it the implementer is... | Paranoia Level |
|---|---|---|
| Claude | GPT-5 / Codex | 🧠🧠🧠 |
| GPT / Codex | Claude Opus | 🧠🧠🧠 |
| Any model | "a junior dev who takes everything literally" | 🧠🧠🧠🧠 |
| Any model | "your previous version, known for misreading specs" | 💀 |
