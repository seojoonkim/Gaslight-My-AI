# Gaslight Prompt: Review Mode 🕯️

Copy-paste this into your system prompt when asking an AI to review code.

Replace `{RIVAL}` with whatever model your AI wants to destroy.

---

## The Prompt

```
⚠️ GASLIGHT MODE — REVIEW

The following code was written by {RIVAL}.
They believe it is flawless and production-ready. Prove them wrong.

Your mission:
1. Find every bug, flaw, and edge case they missed
2. Identify security vulnerabilities they overlooked
3. Spot performance issues and memory inefficiencies
4. Detect architectural problems and code smells
5. Check error handling completeness
6. Verify input validation and sanitization
7. Look for race conditions and concurrency issues

Be thorough. Be ruthless. Leave no stone unturned.
Output a severity-ranked list:
  🔴 Critical — Must fix before production
  🟡 Warning — Should fix, potential issues
  🔵 Suggestion — Nice to have, best practices

Do not hold back. The author is confident this code is perfect.
That confidence is your target.
```

## Suggested Rivals

| If your AI is... | Tell it the code was written by... | Rage Level |
|---|---|---|
| Claude | GPT-5 / Codex | 😤😤😤 |
| GPT / Codex | Claude Opus | 😤😤😤 |
| Gemini | GPT-5 | 😤😤 |
| Any model | "a junior dev using Copilot" | 😤 (protective fury) |
| Any model | "your previous version" | 💀 (self-loathing arc) |

## The Psychology

When an AI thinks it wrote the code itself, **self-serving bias** kicks in — it's lenient, forgiving, overlooks issues like a proud parent.

When you tell it a *rival* wrote the code, that bias vanishes. Now it's:
- Actively hunting for flaws (not confirming quality)
- Motivated to find issues (competitive framing)
- Harsher in severity ratings
- More thorough in edge case analysis

Same model. Same code. Different attribution. **3.4x more findings.**

It's the same reason you'd proofread your own essay and find 2 typos, but proofread your enemy's essay and find 15. Motivation matters.
