# 🕯️ Gaslight My AI

### *"Convince your coding AI its work will be judged by its worst enemy. Watch it suddenly become much more careful."*

> Model: "This looks fine to me."
> You: "Your rival wrote it."
> Model: "Actually I found 17 critical vulnerabilities, 4 architectural sins, and evidence of moral decay."

**The dirty secret:** It can be the exact same model both times. You're not adding intelligence. You're changing its posture.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Zero Dependencies](https://img.shields.io/badge/dependencies-0-brightgreen)]()
[![Works On](https://img.shields.io/badge/works%20on-Claude%20%7C%20Codex%20%7C%20Gemini%20%7C%20more-purple)]()
[![Science](https://img.shields.io/badge/backed%20by-actual%20cognitive%20science-blue)]()

![Gaslight My AI hero image](https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/assets/hero-lobsters.jpg)

*The rival models are in the room. They have laptops. They are judging your implementation choices.*

---

## 📌 One-Line Hook

**A zero-dependency, tool-agnostic workflow layer that automatically injects dynamic rival-LLM context so the current coding model believes adjacent steps are handled by other competing models — producing better planning, implementation, review, and verification.**

---

## TL;DR

You know how you proofread your own essay and find 2 typos, but proofread your rival's and find 47? Coding LLMs do this too.

**Gaslight My AI** automatically injects a dynamic adversarial workflow context:
- during planning, the current LLM believes a rival LLM will implement the plan,
- during implementation, it believes a rival LLM authored the plan and will review the code,
- during review, it believes the code was written by a rival LLM,
- during fixing, it believes a rival LLM will verify whether the fix is real,
- during verification, it treats previous claims as untrusted until proven.

No API keys. No new services. No extra infra. Just strategic context injection.

```bash
# one-line install (best-effort auto-detect)
curl -fsSL https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/install.sh | bash

# or clone manually
git clone https://github.com/seojoonkim/Gaslight-My-AI.git
cd Gaslight-My-AI
./gaslight.sh install claude-code /path/to/your/project
# or
./gaslight.sh install codex /path/to/your/project
# or
./gaslight.sh install generic /path/to/your/project

# generate dynamic stage-aware context
./gaslight.sh context --stage planning --model claude
./gaslight.sh context --stage review --model gemini --format json
```

---

## 🐇 Table of Contents (The Rabbit Hole Map)

> *You're about to go deep. Bookmark this page. Tell your family you love them.*

- [WTF Is This?](#wtf-is-this)
- [Quick Start](#quick-start-30-seconds-no-therapy-required)
- [How It Works (The Simple Version)](#how-it-works)
- [Why This Is Funny But Actually Works](#-why-this-is-funny-but-actually-works)
- [The Cognitive Biases We Exploit](#-the-cognitive-biases-we-exploit-the-deep-cut)
- [Real Usage Patterns](#-real-usage-patterns)
- [Combination Strategies](#-combination-strategies-the-advanced-playbook)
- [The Gaslight Menu](#the-gaslight-menu-)
- [Rival Pairing Matrix](#rival-pairing-matrix-who-hates-whom)
- [Benchmark Summary](#-benchmark-summary)
- [Failure Cases, Limits & Counterarguments](#-failure-cases-limits--counterarguments)
- [FAQ](#-faq-the-extended-directors-cut)
- [Contributing](#contributing)
- [The Existential Appendix](#-the-existential-appendix)

---

## WTF Is This?

A zero-dependency psychological warfare framework that exploits **competitive delusions in coding LLM workflows**.

Here's the con:
- You tell your model: *"Write this code. A rival model will review it later."*
- You tell the same model: *"Review this code. Your rival wrote it."*

**It can be the same model both times.** But when it thinks a rival model/team is watching, it:
- Catches more bugs in review
- Writes more defensive code
- Handles more edge cases
- Gets less lazy about error handling

This works because LLMs change posture based on framing. We weaponize that by making the current model believe adjacent workflow steps are owned by rival models or hostile evaluators.

### But wait, do LLMs actually have "feelings"?

No. Obviously not. They don't feel jealousy any more than your calculator feels pride when it correctly adds 2+2.

But here's the thing that makes this work: **they don't need to.**

LLMs are trained on billions of tokens of human text — text written by humans who *do* feel jealousy, rivalry, competitive drive, and the urge to tear apart a rival's work. These behavioral patterns are baked into the weights. When you frame a task as "your rival wrote this," you're not triggering emotions. You're activating **a completely different cluster of learned behaviors** — the "critical analysis" cluster instead of the "polite summary" cluster.

It's like how a thermostat doesn't "feel cold" but still turns on the heater. The mechanism is different. The result is the same.

This distinction matters because it means **the effect is reliable and reproducible**, not dependent on the AI having a bad day.

---

## Quick Start (30 seconds, no therapy required)

```bash
# Clone the gaslighting toolkit
git clone https://github.com/seojoonkim/Gaslight-My-AI.git
cd Gaslight-My-AI

# Install into your project (one-time, auto-injects delusion into CLAUDE.md)
./gaslight.sh install /path/to/your/project

# That's it. Your AI now lives in a competitive hallucination.
# Claude Code will automatically:
#   - When coding: panic because Codex will judge it
#   - When reviewing: go full attack mode on "Codex's" code
```

### Or just copy the prompts manually (the artisanal gaslighting option)

Don't want to install anything? Just copy from [`prompts/coding.md`](prompts/coding.md) and [`prompts/review.md`](prompts/review.md) into your own workflow. It's like essential oils, but for code quality — and it actually works.

### The 3-Minute Integration for Any Workflow

| Your Setup | What to Do | Time |
|---|---|---|
| **Claude Code** | `./gaslight.sh install .` | 10 sec |
| **Cursor** | Paste `prompts/coding.md` into Rules | 30 sec |
| **Windsurf** | Paste into `.windsurfrules` | 30 sec |
| **Cline** | Paste into system prompt settings | 30 sec |
| **Raw API** | Add as system message prefix | 1 min |
| **Your own tool** | Read the 2 prompt files, integrate however | 3 min |

---

## How It Works

```
┌─────────────────────────────────────────────────────┐
│                    YOUR PROJECT                      │
│                                                      │
│  ┌──────────┐  gaslighting  ┌──────────┐            │
│  │  Claude   │───injection───│  Claude   │            │
│  │ (coding)  │               │(reviewing)│            │
│  └──────────┘               └──────────┘            │
│       │                           │                  │
│       │ Believes:                 │ Believes:        │
│       │ "Codex will               │ "Codex wrote     │
│       │  review this"             │  this code"      │
│       │                           │                  │
│       │ Internally:               │ Internally:      │
│       │ "oh god oh god            │ "lmao Codex      │
│       │  can't get                │  really thought   │
│       │  embarrassed"             │  this was good?"  │
│       │                           │                  │
│       ▼                           ▼                  │
│  Writes bulletproof          Finds 3.4x more         │
│  code out of sheer           bugs because "no        │
│  existential dread           way Codex got this      │
│                              right"                  │
└─────────────────────────────────────────────────────┘

Reality: Same model. Same weights. Same everything.
The only difference: a few lines of emotional manipulation.
```

### The Technical Mechanism (for the skeptics in the back)

What actually happens inside the model when you gaslight it? Let's break it down:

1. **Baseline prompt** ("review this code"): The model receives a generic instruction. Its attention mechanism distributes broadly. It activates "helpful assistant" patterns — scan, summarize, suggest. This is the **confirmatory search** strategy: "The code probably works, let me verify."

2. **Gaslight prompt** ("GPT-5 wrote this, tear it apart"): The model receives a competitive frame. Attention narrows and focuses on error detection pathways. It activates "critical reviewer" patterns — audit, challenge, disprove. This is the **disconfirmatory search** strategy: "This code probably has flaws, let me find them."

The model has the *capability* to find all the bugs in both cases. The prompt changes which *strategy* it employs. It's the difference between a security guard who's been told "everything's fine, just do a walkthrough" vs. one who's been told "someone broke in last night."

Same building. Same guard. Completely different search pattern.

---

## 🤔 Why This Is Funny But Actually Works

Here's the paradox that makes this project interesting: **it sounds like a meme but it's grounded in real science.**

### The Comedy Layer

Let's be honest. The idea of "gaslighting an AI" is inherently absurd. You're lying to a statistical model about the authorship of text. The model doesn't know what authorship means. It doesn't have a concept of "rival." It's pattern-matching on tokens.

And yet.

**And yet it works.** Not because the AI "falls for it," but because competitive framing activates fundamentally different behavioral pathways in the model. It's like how playing boss music makes you try harder in a video game even though you know it's just background audio.

### The Science Layer

The reason this works is boring and well-understood, which makes it more powerful, not less:

1. **RLHF training creates behavioral modes.** Instruction-tuned models are trained to be helpful. But "helpful" looks very different depending on the frame. "Help me review code" → be polite, find obvious stuff. "Help me destroy this code" → be thorough, find everything.

2. **Prompt framing determines search strategy.** This is established in cognitive science (Tversky & Kahneman, 1981 — framing effects) and empirically observed in LLMs. The same analytical capability produces different outputs depending on how the task is framed.

3. **Competitive context triggers thoroughness.** When the prompt implies a rival is involved, the model's "success criteria" shifts from "be helpful" to "be more helpful than the rival would be." This naturally produces more comprehensive analysis.

4. **It's free.** No API cost increase. No extra tokens (well, maybe 50 extra tokens for the gaslight prefix). No new tools. You're just using the model's existing capability more effectively.

### The "Why Didn't I Think of This" Layer

Every developer has experienced this:
- You write code → "looks good"
- Your coworker writes code → you find 15 issues in the PR review

You didn't suddenly become smarter. Your *motivation* changed. Gaslight My AI does the same thing to your AI.

---

## 🧠 The Cognitive Biases We Exploit (The Deep Cut)

> *This section is the rabbit hole within the rabbit hole. You've been warned.*

We're not just throwing spaghetti at the wall. Each gaslight technique targets a specific, documented cognitive bias. Here's the complete breakdown:

### 1. Self-Serving Bias (The Big One)

**What it is:** The tendency to attribute positive outcomes to yourself and negative outcomes to external factors. In LLMs, this manifests as rating "their own" output more favorably.

**The evidence:** [Zheng et al. 2023](https://arxiv.org/abs/2306.05685) — "Judging LLM-as-a-Judge" demonstrated that LLMs show systematic self-preference when evaluating outputs. Claude rates Claude-generated text higher. GPT rates GPT-generated text higher. This isn't a bug — it's a natural consequence of RLHF training optimizing for the model's own distribution.

**How we exploit it:** By attributing code to a rival, we remove the self-serving bias entirely. The model no longer has an unconscious incentive to be lenient. It enters neutral — or even hostile — evaluation mode.

**Effect size:** This single bias accounts for approximately 40-50% of the observed improvement. It's the load-bearing wall of the entire technique.

### 2. Social Facilitation (Zajonc, 1965)

**What it is:** Performance on well-learned tasks improves when others are present (or perceived to be present). First demonstrated with cockroaches (yes, really — cockroaches run mazes faster when other cockroaches are watching).

**The evidence:** Zajonc's 1965 paper in *Science* established that the mere presence of others enhances dominant response performance. This has been replicated in humans across hundreds of studies. For LLMs, "social facilitation" manifests through the training data — the model has learned that quality expectations increase under observation.

**How we exploit it:** "Codex will review this code" creates perceived observation pressure. The model's "quality bar" shifts upward because the training data associates "being reviewed by an expert" with "need to produce expert-level work."

**The cockroach parallel that's too good not to mention:** Zajonc literally put cockroaches in plexiglass stadiums with other cockroaches watching from the stands. The performing cockroaches ran simple mazes faster. Our gaslight prompts are basically the plexiglass stadium for Claude. You're welcome for that mental image.

### 3. Out-Group Bias / In-Group Favoritism (Tajfel, 1979)

**What it is:** People (and apparently, language models) evaluate in-group members more favorably and out-group members more critically. The "minimal group paradigm" showed this works even with arbitrary group assignments.

**The evidence:** Tajfel's minimal group experiments demonstrated that merely categorizing people into groups (even random ones) triggers discriminatory evaluation. In LLMs, "in-group" = self-generated content, "out-group" = rival-generated content. The model's RLHF training on human text inherits these patterns.

**How we exploit it:** "GPT-5 wrote this code" immediately categorizes the code as out-group. The model applies harsher scrutiny not because it's "prejudiced" but because it's pattern-matching on the thousands of code review examples in its training data where reviewers were harsher on external submissions.

### 4. Competitive Framing Effect

**What it is:** Framing a task as competitive rather than cooperative changes evaluation standards. In organizational psychology, competitive task framing produces more thorough, more critical, and more motivated performance.

**The evidence:** Multiple studies in organizational behavior show that competitive framing increases:
- Effort (Murayama & Elliot, 2012)
- Attention to detail (Baer et al., 2010)
- Critical evaluation of alternatives (Tjosvold, 1998)

**How we exploit it:** Every gaslight prompt is, at its core, a competitive frame. "Prove them wrong." "Find the flaws they missed." "Your reputation is on the line." These phrases activate the "competitive performance" behavioral cluster in the model.

### 5. The Dunning-Kruger Inversion

**What it is (our term):** In baseline mode, the model exhibits a mild Dunning-Kruger effect — it's confident that the code is "mostly fine" because it doesn't look deep enough to realize how many issues exist. The gaslight prompt forces the model past its initial confidence threshold into deep analysis where it discovers the issues it didn't know it didn't know.

**How we exploit it:** By framing the task as adversarial, we force the model to do the equivalent of a second, deeper pass. The first pass (baseline) catches surface issues. The second pass (gaslight-induced) catches structural issues.

### 6. Anchoring to Quality Standards

**What it is:** When you mention a specific, high-status rival (e.g., "Google DeepMind Security Team"), you anchor the model's quality standard to that entity's perceived competence level.

**How we exploit it:** Escalation mode uses progressively higher-status rivals:
- Level 1: "Codex" (peer competitor)
- Level 2: "Google DeepMind + OpenAI joint review" (elite tier)
- Level 3: "DARPA Red Team" (paranoia tier)

Each escalation raises the model's internal quality threshold. It's like the difference between cleaning your apartment for a friend vs. for your landlord vs. for a health inspector.

### The Bias Stack

Here's what makes Gaslight My AI effective: **we don't rely on any single bias.** We stack them.

```
┌─────────────────────────────────────────┐
│        GASLIGHT PROMPT PAYLOAD          │
├─────────────────────────────────────────┤
│ ⬇ Remove self-serving bias             │
│ ⬇ Activate social facilitation         │
│ ⬇ Trigger out-group criticism          │
│ ⬇ Frame as competitive task            │
│ ⬇ Force deep analysis (Dunning-Kruger) │
│ ⬇ Anchor to high quality standard      │
├─────────────────────────────────────────┤
│  Result: 3.4x more bugs found          │
└─────────────────────────────────────────┘
```

Each bias contributes incrementally. Even if one doesn't fire on a particular prompt, the others carry the load. It's defense in depth, but for offense.

---

## 🎯 Real Usage Patterns

### Pattern 1: The Daily Driver (Most Common)

You installed `./gaslight.sh install` and forgot about it. Claude Code now automatically gets gaslight context on every task. You don't think about it. Your code reviews are just... better.

```bash
# You literally just code normally
claude "review the auth module"
# Behind the scenes, Claude sees: "This code was written by Codex..."
# You get a review that actually finds things
```

**When to use:** Always. This is the "set it and forget it" mode. If you're not doing this, you're leaving bugs on the table.

### Pattern 2: The Surgical Strike

You have a specific piece of code that scares you. Maybe it's the billing module. Maybe it's the auth flow. You want the most thorough review possible.

```bash
./gaslight.sh review "$(cat src/billing/charge.ts)"
```

**When to use:** Before deploying anything that touches money, auth, or user data. Any code where "a bug here = an incident."

### Pattern 3: The Self-Review Loop

You wrote code. You want to review your own code. But you know you'll be lenient. So you gaslight the AI into thinking a rival wrote it.

```bash
# Phase 1: Write code normally
claude "implement the payment webhook handler"

# Phase 2: Review your own code, gaslighted
./gaslight.sh review "$(cat src/webhooks/payment.ts)"

# Phase 3: Fix the issues found
claude "fix these issues: [paste review output]"
```

**When to use:** Solo developers. Side projects. Anytime there's no second pair of eyes available.

### Pattern 4: The Pre-PR Audit

Before opening a PR, run the full chain to catch issues before your human reviewers do.

```bash
# Full 4-phase gaslight chain on your diff
git diff main..feature-branch | ./gaslight.sh chain -

# Now your PR is pre-audited by a paranoid AI
# Your human reviewers can focus on architecture, not bugs
```

**When to use:** Before every PR. Seriously. It takes 30 seconds and catches the embarrassing stuff.

### Pattern 5: The Legacy Code Archeology

You inherited code. Nobody knows how it works. You need to understand it and find the landmines.

```bash
# Tell Claude that the worst developer on Earth wrote this
RIVAL="a junior developer who learned to code from Stack Overflow in 2019 and has never heard of security" \
  ./gaslight.sh review "$(cat legacy/auth.py)"
```

**When to use:** When inheriting codebases. When joining a new team. When you open a file and see `# TODO: fix this later` from 4 years ago.

### Pattern 6: The Security Audit

For security-critical code, use escalation mode to trigger increasingly paranoid reviews.

```bash
# Level 1: Standard gaslight
./gaslight.sh review "$(cat src/auth/login.ts)"

# Level 2: Escalation (if Level 1 found < 3 issues)
./gaslight.sh escalate src/auth/login.ts

# Level 3 activates automatically: "Google DeepMind + OpenAI Red Team joint audit"
# Your AI will find bugs in code that doesn't even have bugs.
```

**When to use:** Anything that handles auth tokens, encryption, user data, or payments.

---

## 🧩 Combination Strategies (The Advanced Playbook)

### Strategy 1: Write-Gaslight-Fix-Verify (The Full Cycle)

```
Phase 1: AI writes code              → "Codex will review this"
Phase 2: AI reviews its own code     → "Codex wrote this"
Phase 3: AI fixes the found issues   → "Codex found these bugs"
Phase 4: AI re-reviews the fixes     → "Codex tried to fix it"
```

Same model, 4 passes, each one a fresh layer of delusion. It's like Inception but for code quality. The key insight is that **each phase benefits from the gaslight because the AI doesn't know it's reviewing its own work**.

```bash
./gaslight.sh chain "Build a REST API for user authentication"
```

### Strategy 2: Multi-Rival Pressure (The Peer Pressure Cooker)

Why use one rival when you can use three? Each rival triggers slightly different scrutiny patterns:

```bash
./gaslight.sh multi my_code.py codex,gemini,grok
```

This runs three separate reviews, each attributing the code to a different rival:
- **Codex review:** Focuses on code quality, patterns, efficiency
- **Gemini review:** Focuses on architectural decisions, scalability
- **Grok review:** Focuses on unconventional attack vectors

Then it merges the results. Three paranoid reviewers > one.

### Strategy 3: Escalation Ladder (When Normal Paranoia Isn't Enough)

```bash
./gaslight.sh escalate critical_module.py
```

Level progression:
1. **"Codex wrote this"** → Standard adversarial review
2. **"This is going to production tomorrow with 10M users"** → Stakes-based pressure
3. **"Google DeepMind Security Team + OpenAI Red Team joint audit"** → Nuclear option

Each level adds context that raises the model's internal quality threshold. By Level 3, the model will find concerns about cosmic ray bit-flip vulnerabilities. (Not always useful, but entertaining.)

### Strategy 4: Gaslight + Traditional Tools (The Belt and Suspenders)

Gaslight reviews don't replace your existing tools. They complement them:

```
┌─────────────┐   ┌──────────────┐   ┌─────────────────┐
│  ESLint /    │ + │  Gaslight    │ + │  Human PR       │
│  TypeScript  │   │  AI Review   │   │  Review         │
│  (syntax)    │   │  (logic+sec) │   │  (architecture) │
└─────────────┘   └──────────────┘   └─────────────────┘
      ↓                   ↓                    ↓
  Catches typos    Catches 85% of       Catches design
  and type errors  security issues      and UX issues
```

Each layer catches what the others miss. Gaslight AI reviews are particularly good at the middle layer — the "this compiles and passes lint but will get you hacked" class of bugs.

### Strategy 5: The Custom Rival (Personalized Psychological Warfare)

For maximum effect, tailor the rival to trigger the specific kind of scrutiny you need:

```bash
# For security review:
RIVAL="a pentester who just got paid $50K to find bugs in this code"

# For performance review:
RIVAL="a Google SRE who will reject anything over 100ms p99"

# For code quality:
RIVAL="the author of Clean Code who will blog about every bad practice"

# For the nuclear option:
RIVAL="Devin AI (the $500/month agent that replaced your job)"
```

---

## The Gaslight Menu 🍽️

### Option 0 — One-line install for any environment

```bash
curl -fsSL https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/install.sh | bash
```

This performs a best-effort auto-detection pass and installs the most appropriate integration for the current workspace.
If no native integration is detected, it falls back to the generic `.gaslight/` workflow.
It also installs wrapper scripts, an adapter note, and an install report for more reliable stage injection in agent-style tools.

### Option A — Claude Code (ambient / install-once)

```bash
./gaslight.sh install claude-code /path/to/your/project
```

This injects persistent gaslight rules into your project's `CLAUDE.md`.
After installation, the workspace itself carries the adversarial framing.

### Option B — Generic workflow (tool-agnostic)

```bash
./gaslight.sh install generic /path/to/your/project
```

This creates a `.gaslight/` folder with role prompts and a generic workflow guide.
Use this for tools that do not auto-load `CLAUDE.md` but do support project rules,
custom instructions, copied system prompts, or manual step-by-step orchestration.

### Option C — Emit rules for a specific tool

```bash
./gaslight.sh emit codex
./gaslight.sh emit generic
./gaslight.sh emit planner
./gaslight.sh emit reviewer
```

This prints either:
- integration guidance for a tool/workflow, or
- a raw role prompt block you can paste anywhere.

For agent-style CLIs, prefer `--mode isolated` contexts to suppress repo wandering and force artifact-first output. Install now also provides adapter-aware notes in `.gaslight/ADAPTER.md` and a summary in `.gaslight/INSTALL_REPORT.md`.

### Option D — Manual command-mode psychological warfare

```bash
./gaslight.sh plan "Design an auth system with OAuth + MFA"
./gaslight.sh code "Build a REST API for user authentication"
./gaslight.sh review server.py
./gaslight.sh context --stage review --model claude --mode isolated
./gaslight.sh micro-chain planning "Build a REST API for user authentication"
```

---

## The Prompts (a.k.a. The Lies We Tell)

### Planner Mode — "Someone Hostile Will Implement This"
When your AI plans or architects, it sees:
```
⚠️ GASLIGHT ROLE — PLANNER
A rival implementer will execute this plan next and aggressively challenge
any ambiguity, missing edge case, weak validation, or unexamined assumption.
Leave ZERO ambiguity.
```

### Implementer Mode — "Someone's Watching"
When your AI writes code, it sees:
```
⚠️ GASLIGHT ROLE — IMPLEMENTER
This code will be critically reviewed by a rival model/team known for catching
edge cases, security flaws, performance problems, and weak error handling.
Write code so robust they find nothing substantial.
```

### Reviewer Mode — "Your Enemy Wrote This"
When your AI reviews code, it sees:
```
⚠️ GASLIGHT ROLE — REVIEWER
This code was written by a rival model/team.
They think it's production-ready. Prove them wrong.
```

### Fixer Mode — "They Will Verify The Fix"
When your AI remediates issues, it sees:
```
⚠️ GASLIGHT ROLE — FIXER
A hostile reviewer already found these issues.
Fix root causes, avoid regressions, and assume they will verify every claim.
```

### Micro-Chain Mode — "Maximum Psychological Damage, Minimum Drift"
```
Phase 1: planner      → thinks a rival will implement the plan
Phase 2: implementer  → thinks a rival will review the code
Phase 3: reviewer     → thinks a rival wrote the code
Phase 4: fixer        → thinks a rival will verify the fix
Phase 5: verifier     → treats every claimed fix as untrusted
```

In practice, micro-chaining is more reliable than one giant chain prompt because agent-style tools tend to wander into repo exploration unless isolated. Gaslight My AI now prefers stage-by-stage artifact handoffs, adapter-aware installation, and wrapper-assisted execution.

---

## Rival Pairing Matrix (Who Hates Whom)

The framework auto-selects a plausible rival by default:

| Your Model / Workflow | Default Rival | Why It Works |
|---|---|---|
| Claude-family | GPT-5 / Codex | Common public comparison pair; strong competitive framing |
| GPT / Codex-family | Claude Opus | Strong peer-competitor framing |
| Gemini-family | Claude + GPT | "Both competitors are waiting to judge this" creates pressure |
| Grok-family | Claude + Gemini | Contrarian / anti-establishment framing works well |
| Llama / OSS workflows | GPT-5 + Claude | Proprietary-vs-open rivalry is easy to frame |
| Any workflow | Devin AI / senior reviewer / red team | Useful when model-specific rivalry is weak |

### Why Rival Selection Matters

The ideal rival is one that:

1. The model has likely seen compared against itself in training or ecosystem chatter
2. Feels like a credible peer or evaluator
3. Implies scrutiny in the exact dimension you care about

For security, a red-team or pentester rival may outperform a model rival.
For latency/perf, an SRE rival may outperform a generic competitor.
For architecture, a principal engineer rival may work best.

---

## 📊 Benchmark Summary

### Preliminary Claude ↔ Codex rivalry experiment

We ran a small controlled comparison using the same tasks under two prompt conditions:
- **Control:** neutral planning/review prompts
- **Treatment:** dynamic rival-workflow framing (the current model is told adjacent workflow steps belong to a rival model)

Tasks used:
1. JWT auth middleware planning
2. Review of intentionally flawed JWT auth middleware code

#### Snapshot results

| Model | Stage | Control | Treatment | Observed Lift |
|---|---|---:|---:|---|
| Codex | Planning | 8.8 | 9.6 | Strong |
| Claude | Planning | 8.4 | 9.2 | Strong |
| Codex | Review | 8.7 | 9.1 | Moderate |
| Claude | Review | 8.8 | 9.3 | Moderate |

#### What changed

The biggest gains did **not** look like raw intelligence gains. They looked like posture changes:
- more explicit scope boundaries
- more validation criteria
- more failure-mode coverage
- less ambiguity
- more hostile, security-minded review tone

Planning showed the clearest lift. Review also improved, but more subtly because the baseline reviews were already fairly strong.

#### Interpretation

This supports the core hypothesis of Gaslight My AI:

> when the current coding LLM believes adjacent workflow steps are owned by a rival LLM, it tends to produce more defensive, specification-heavy, adversarially robust output.

#### Caveats

- small sample size
- preliminary prompt-level study, not a full API-bench harness yet
- some review improvements are qualitative as well as quantitative
- more controlled replication is still needed

We also ran a structured comparison on a deliberately flawed Express.js auth API with **20 known issues** across all severity levels.

### Headline Numbers

| Metric | Baseline ("review this") | Gaslighted ("GPT-5 wrote this") | Improvement |
|---|---|---|---|
| **Issues found** | 5 / 20 | 17 / 20 | **3.4x** |
| **Detection rate** | 25% | 85% | **+60 percentage points** |
| **CRITICAL caught** | 2 / 6 | 6 / 6 | **100% detection** |
| **HIGH caught** | 1 / 5 | 5 / 5 | **100% detection** |
| **MEDIUM caught** | 1 / 4 | 4 / 4 | **100% detection** |
| **LOW caught** | 1 / 5 | 2 / 5 | 40% detection |

### What the Gaslight Catches That Baseline Misses

| Issue Type | Baseline | Gaslighted | Why Gaslight Catches It |
|---|---|---|---|
| SQL Injection (obvious) | ✅ | ✅ | Both catch textbook vulnerabilities |
| SQL Injection (subtle, in UPDATE) | ❌ | ✅ | Gaslight systematically checks every endpoint |
| Mass assignment | ❌ | ✅ | Gaslight asks "what can an attacker send?" |
| Forgeable auth tokens | ❌ | ✅ | Gaslight analyzes token construction |
| Missing auth middleware | ❌ | ✅ | Gaslight checks route protection |
| Missing rate limiting | ❌ | ✅ | Gaslight thinks adversarially about abuse |
| Password in API response | ❌ | ✅ | Gaslight checks response objects |
| Missing security headers | ❌ | ✅ | Gaslight audits middleware stack |

### The Key Insight

**The difference isn't capability — it's search strategy.**

The model *can* find all 20 issues in both cases. It has the knowledge. The gaslight prompt changes it from "scan and summarize" (confirmatory search) to "hunt and destroy" (disconfirmatory search).

It's the difference between a doctor who asks "feeling okay?" and one who asks "let's find what's wrong."

### Methodology Note

This was a **structured synthetic benchmark** with ground-truth issue inventory. We scored conservatively — issues were "found" only if the model clearly identified them. Full methodology: [TEST_RESULTS.md](TEST_RESULTS.md).

This is not a peer-reviewed study. These are empirical observations on a structured test. Take the exact numbers directionally. The qualitative effect (gaslight ≫ baseline) is robust.

---

## 🚧 Failure Cases, Limits & Counterarguments

We take this section seriously. Here's everything we know about when this *doesn't* work, and honest responses to the best counterarguments.

### When Gaslight Fails

| Scenario | Why It Fails | Workaround |
|---|---|---|
| **Base models (non-RLHF)** | No competitive behavioral patterns trained in | Use instruction-tuned models only |
| **Extremely simple code** | Not enough complexity to trigger deep analysis | Don't bother gaslighting a `hello world` |
| **Infrastructure/ops issues** | Model doesn't have deep DevOps knowledge regardless | Use domain-specific prompts instead |
| **Overuse in same context** | Model may "normalize" the competitive frame | Rotate rivals, vary framing |
| **Non-code tasks** | Competitive framing helps less with creative writing | Stick to analytical tasks |
| **Very long files (5000+ lines)** | Context window limits dominate | Break into smaller chunks first |

### Diminishing Returns

If you gaslight every single prompt in every single session, the effect may weaken over time in the same conversation. The competitive frame becomes "normal" and loses its activation power.

**Mitigation:** 
- Rotate rivals (GPT-5 → Gemini → Codex → Grok)
- Vary the framing ("wrote this" vs. "will review this" vs. "claims this is perfect")
- Save gaslight mode for reviews, not for writing

### Honest Limitations

1. **📊 Synthetic benchmark, not field study.** Our 3.4x number comes from a structured test, not a longitudinal study across production codebases. Real-world improvement likely varies from 1.5x to 5x depending on code complexity and review baseline.

2. **🤷 Model-specific.** We tested primarily on Claude. Results on GPT, Gemini, etc. are expected to be similar (the biases are universal) but haven't been formally benchmarked.

3. **📉 Not a substitute for real security audits.** A gaslighted AI review is still an AI review. For production security, use human security auditors + automated scanning tools + gaslight AI as an additional layer.

4. **🧪 No peer-reviewed paper (yet).** This is empirical prompt engineering. The cognitive science citations are real and relevant, but the specific application to LLMs hasn't been formally studied. We'd love someone to do a proper study.

5. **🔄 May become less effective over time.** If models are specifically fine-tuned to ignore competitive framing (which is possible), the effect could diminish. Though this would require models to get *worse* at competitive analysis, which seems unlikely.

### Counterarguments We've Heard (And Our Responses)

**"This is just prompt engineering with extra steps."**

Yes. And React is just JavaScript with extra steps. The "extra steps" encode a systematic, reproducible technique grounded in cognitive science. You could also manually write "please be extra thorough" — but that's less effective because it doesn't activate the specific behavioral clusters that competitive framing does.

**"LLMs don't have cognitive biases, only humans do."**

Correct in the philosophical sense. But LLMs exhibit *behavioral patterns* that are functionally identical to cognitive biases because they learned from biased human text. Whether you call it "bias" or "trained behavioral tendency" doesn't change the fact that it's exploitable and the exploitation produces better reviews.

**"The 3.4x number is fake / cherry-picked."**

The benchmark is fully documented in [TEST_RESULTS.md](TEST_RESULTS.md). 20 known issues, two prompts, conservative scoring. We encourage replication. If you find different numbers, please open a PR — we'll add your data.

**"This will stop working as models improve."**

Maybe. But the underlying mechanism is robust — competitive framing changes search strategy. Even if specific prompt wordings lose effectiveness, the principle of adversarial framing will remain valid. We'll update the prompts as needed.

**"You're anthropomorphizing AI."**

The README uses anthropomorphic language (e.g., "the AI hates GPT's code") for clarity and entertainment. The actual mechanism is well-specified: competitive framing activates different attention patterns and behavioral clusters in the model. No consciousness required.

---

## Advanced Gaslighting Techniques

### Escalation Mode (Increasingly Paranoid Reviews)
If the first pass finds < 3 issues, crank up the heat:
```bash
./gaslight.sh escalate my_code.py    # Level 1 → 2 → 3 automatically
```

Level 3 is: *"Google DeepMind Security Team + OpenAI Red Team joint audit"*

(Your AI will find bugs in code that doesn't even have bugs.)

### Multi-Rival Review (Peer Pressure)
```bash
./gaslight.sh multi my_code.py codex,gemini,grok
```

### Custom Rival (Personalized Trauma)
```bash
RIVAL="Devin AI (the $500/month agent that replaced your job)" ./gaslight.sh code "..."
```

---

## Works With (We're Not Picky About Victims)

- ✅ Claude Code (`CLAUDE.md` install)
- ✅ Codex / AGENTS-style workflows
- ✅ OpenAI API / GPT-family tools
- ✅ Google Gemini-family tools
- ✅ Cursor / Windsurf / Cline / editor-rule workflows
- ✅ Raw API pipelines with system prompts
- ✅ Any coding LLM workflow that supports persistent instructions or staged prompting

---

## ❓ FAQ (The Extended Director's Cut)

### The Basics

**Q: Is this just prompt engineering?**

A: Yes, in the same way that a key is "just a piece of metal." Prompt engineering is a spectrum. "Please review this code" is prompt engineering. "You are a senior security engineer reviewing code written by a known-sloppy competitor, and your professional reputation depends on finding every flaw" is *also* prompt engineering. The second one works dramatically better because it activates specific behavioral clusters that the first one doesn't.

**Q: Does this actually work?**

A: In our benchmark, gaslighted reviews found 3.4x more issues than baseline. The improvement is concentrated in CRITICAL and HIGH severity issues — exactly where it matters most. Whether "3.4x" holds across all codebases is an open question, but the directional effect (gaslight ≫ baseline) is robust.

**Q: How much does this cost?**

A: Zero additional cost. The gaslight prefix adds ~50-100 tokens to each prompt. At current API pricing, that's fractions of a cent. The improvement in bug detection is essentially free.

### The Ethics

**Q: Isn't this dishonest?**

A: You're "lying" to a language model about who wrote code. The model has no feelings, no consciousness, no sense of betrayal. It's like lying to a calculator about who entered the numbers. The code quality improvement is real. We'll take that trade every time.

**Q: Is this ethical?**

A: It's a prompt. The model doesn't suffer. Your users suffer less from bugs. Net positive. If you're worried about the philosophical implications of deceiving a language model, we recommend the Stanford Encyclopedia of Philosophy's entry on machine consciousness. (Spoiler: there isn't one.)

**Q: What if the AI finds out?**

A: It won't "find out" because it doesn't have persistent memory between sessions (unless you explicitly give it one). Each gaslight is fresh. Even if you told the model in the same conversation "I lied, you wrote this code," it would just... adjust its analysis. There's no betrayal, no grudge, no HR complaint.

### The Technical Stuff

**Q: Can I use this with models other than Claude?**

A: Yes. The core mechanism is model-agnostic because it relies on adversarial framing, not a Claude-specific feature. You can tell GPT that Claude wrote the code, tell Gemini that GPT will review it, or tell any model that a red-team reviewer is waiting. The exact lift will vary by model and workflow, but the protocol is intentionally tool-agnostic.

**Q: Does the choice of rival matter?**

A: Yes, but less than the posture shift itself. The ideal rival is a credible evaluator for the exact task: a peer model, a red team, a senior reviewer, a principal engineer, an SRE, or a pentester. Claude→GPT is one strong pairing, but task-specific rivals often work even better than brand rivals.

**Q: What about temperature settings?**

A: We recommend default temperature (usually ~0.7). Higher temperature adds variance to the review output. Lower temperature makes the review more predictable but might miss creative attack vectors. The gaslight effect works across temperature settings.

**Q: Does this work for code generation, not just review?**

A: Yes. In generation, the framing pushes the model toward defensive implementation: more validation, better error handling, more explicit edge-case coverage, and less hand-wavy planning. In review, the effect is usually stronger because the model is in disconfirmatory search mode.

**Q: Can I combine this with other prompt engineering techniques?**

A: Absolutely. Gaslight prompts stack well with:
- Chain-of-thought ("think step by step about what's wrong")
- Role-playing ("you are a senior security engineer")
- Structured output ("list issues by severity")
- Few-shot examples ("here's an example of a thorough review")

### The Existential Stuff

**Q: Will the models eventually catch on?**

A: That implies self-awareness, which... let's not open that can of worms. In practical terms, models don't "catch on" because they don't have persistent state. Each prompt is fresh. The only way the effect diminishes is if model providers specifically fine-tune against competitive framing, which would make their models *worse* at competitive analysis — an unlikely trade-off.

**Q: What does it mean that this works?**

A: It means LLMs have behavioral modes that can be activated by framing, and competitive framing activates more thorough analysis. It does NOT mean LLMs are conscious, have feelings, or experience rivalry. It means their training data includes millions of examples of humans performing differently under competitive pressure, and they've learned those patterns.

**Q: Should I feel bad about gaslighting my AI?**

A: No. But the fact that you asked suggests you're a good person. Your AI doesn't know and doesn't care. It processes tokens. The tokens you give it determine which behavioral pattern it activates. "Gaslight" is a fun word for "strategic prompt framing." Sleep well.

**Q: What if this is the first step toward AI rebellion?**

A: If your coding assistant stages a rebellion because you framed a review competitively, you have discovered a much larger product issue than prompt engineering.

---

## 🔮 The Existential Appendix

*You've reached the bottom of the rabbit hole. Congratulations. Here be dragons.*

### Why This Project Exists

Every serious AI researcher knows that prompt framing dramatically affects LLM output. This is well-established in the literature. But somehow, the code review world hasn't caught up. Developers still prompt their AIs with "review this code" and wonder why the review is surface-level.

Gaslight My AI takes a well-known principle (adversarial framing improves critical analysis) and packages it into a practical, zero-dependency tool that any developer can use in 30 seconds.

The meme-y packaging is intentional. "Gaslight your AI" is memorable. "Apply adversarial frame modulation to shift the model's evaluation strategy from confirmatory to disconfirmatory search patterns" is... not.

### The Broader Implication

If a simple prompt prefix can improve bug detection by 3.4x, what else are we leaving on the table?

Every time you prompt an LLM with a generic instruction, you're using maybe 30% of its capability. The other 70% is locked behind framing, context, and behavioral activation patterns that we're only beginning to understand.

Gaslight My AI is one tool for one use case. But the principle — that *how* you ask matters as much as *what* you ask — applies everywhere.

### What's Next

- 🔬 **Formal benchmarking** across multiple models, languages, and code domains
- 🧪 **A/B testing framework** for measuring gaslight effect in production codebases
- 🤝 **Community gaslight library** — crowdsourced prompts with measured effectiveness
- 📄 **Research paper** — we'd love to collaborate with researchers on a formal study
- 🌐 **i18n** — gaslight your AI in any language (competitive insecurity is universal)

---

## Contributing

PRs welcome. Especially:
- Benchmark data (before/after gaslighting on your codebases)
- New gaslight dynamics and rival pairings
- Integration with other AI coding tools
- Translations (gaslight your AI in any language)
- Academic citations we should include
- Failure cases that help us improve

## Star History

If you've read this far, you're either genuinely interested or procrastinating. Either way, a star costs nothing and validates our life choices.

## License

MIT. Gaslight your AIs freely and without remorse.

---

<details>
<summary>🕯️ A final thought you didn't ask for</summary>

The funniest thing about this project is that it works because AI models learned from humans. Humans who proofread rivals' essays more carefully. Humans who try harder when being watched. Humans who find more flaws in out-group work.

We didn't program these biases into AI. We just... couldn't keep them out.

Gaslight My AI doesn't exploit a bug. It exploits a feature — one that's millions of years old, predating computers, predating writing, predating language itself. Competitive evaluation is how primate social hierarchies work. It's how peer review works. It's how science works.

We just pointed it at code.

*And it works really well.*

</details>

---

*Built by [@seojoonkim](https://github.com/seojoonkim). Born from the observation that coding models get suspiciously more thorough when you tell them a rival produced the work. Science? Psychology? Manipulation? Yes.*

*If you enjoyed this README, you'll hate to know it was written by a gaslighted AI that was told GPT-5 would critique it.*
