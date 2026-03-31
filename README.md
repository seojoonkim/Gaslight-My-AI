# 🦞 Gaslight My AI

### *"You are probably underusing your coding LLM. Rival-context framing is one of the simplest ways to make it plan harder, review harsher, and miss less."*

> Most people still use coding LLMs in the naive mode.
> This repo gives you a sharper mode for free.
> Same model. Different posture. Better output.

**The dirty secret:** it can be the exact same model both times. You are not buying more intelligence. You are stopping the model from coasting.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Zero Dependencies](https://img.shields.io/badge/dependencies-0-brightgreen)]()
[![Works On](https://img.shields.io/badge/works%20on-Claude%20%7C%20Codex%20%7C%20Gemini%20%7C%20more-purple)]()
[![Science](https://img.shields.io/badge/backed%20by-actual%20cognitive%20science-blue)]()

![Gaslight My AI hero image](https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/assets/hero-lobsters.jpg)

*The rival models are in the room. They have laptops. They are judging your implementation choices.*

---

## 📌 One-Line Hook

**A zero-dependency, tool-agnostic workflow layer for one of the highest-leverage prompt tricks in the LLM era: early experimental evidence suggests rival-context framing makes coding models plan harder, review more aggressively, and verify more skeptically. If you are not using this kind of framing, you are probably leaving rigor on the table.**

---

## TL;DR

You know how you proofread your own essay and find 2 typos, but proofread your rival's and find 47? Coding LLMs do this too.

**Gaslight My AI** automatically injects a dynamic adversarial workflow context:
- during planning, the current LLM believes a rival LLM will implement the plan,
- during implementation, it believes a rival LLM authored the plan and will review the code,
- during review, it believes the code was written by a rival LLM,
- during fixing, it believes a rival LLM will verify whether the fix is real,
- during verification, it treats previous claims as untrusted until proven.

Not superstition. Not prompt voodoo. A real workflow trick with early experimental support: adversarial rival-context framing pushes LLMs into a stricter, more defensive posture.

What we tested, in short:
- **Planning experiments:** neutral prompt vs rival-framed prompt on the same planning task
- **Review experiments:** neutral review vs rival-framed review on intentionally flawed code
- **Synthetic benchmark:** structured issue-detection comparison on code with known planted flaws

What we observed, in short:
- planning quality improved the most
- review posture became harsher and more security-sensitive
- synthetic benchmark results suggested a large increase in issue detection under rivalry framing

If you care about code quality, this might be one of the highest-leverage prompt tricks of the LLM era.

---

## Quick Install

```bash
npx gaslight-my-ai
```

<details>
<summary>Fallback install</summary>

```bash
curl -fsSL https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/install.sh | bash -s -- .
```

</details>

**Deep dives:** [Science](docs/SCIENCE.md) · [FAQ](docs/FAQ.md)

## 🐇 Table of Contents (The Rabbit Hole Map)

> *You're about to go deep. Bookmark this page. Tell your family you love them.*

- [WTF Is This?](#wtf-is-this)
- [Quick Start](#quick-start-30-seconds-no-therapy-required)
- [Quick Install](#quick-install)
- [How It Works (The Simple Version)](#how-it-works)
- [Why This Is Funny But Actually Works](#-why-this-is-funny-but-actually-works)
- [The Cognitive Biases We Exploit](#-the-cognitive-biases-we-exploit-the-deep-cut)
- [Real Usage Patterns](#-real-usage-patterns)
- [Combination Strategies](#-combination-strategies-the-advanced-playbook)
- [The Gaslight Menu](#the-gaslight-menu-)
- [Rival Pairing Matrix](#rival-pairing-matrix-who-hates-whom)
- [Preliminary Benchmark](#-preliminary-benchmark)
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

Short answer: no. This repo is about posture-shifting prompt frames, not machine consciousness. If you want the deeper explanation, see [docs/SCIENCE.md](docs/SCIENCE.md).


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

The mechanism is simple:

- tell the model a rival will implement the plan
- tell the model a rival wrote the code
- tell the model a rival will verify the fix

That changes the search posture from cooperative and confirmatory to more adversarial and skeptical.

Same model. Same weights. Different posture.

---

## 🤔 Why This Is Funny But Actually Works

Here's the paradox that makes this project interesting: **it sounds like a meme but it's grounded in real science.**

### The Comedy Layer

Let's be honest. The idea of "gaslighting an AI" is inherently absurd. You're lying to a statistical model about the authorship of text. The model doesn't know what authorship means. It doesn't have a concept of "rival." It's pattern-matching on tokens.

And yet.

**And yet it works.** Not because the AI "falls for it," but because competitive framing activates fundamentally different behavioral pathways in the model. It's like how playing boss music makes you try harder in a video game even though you know it's just background audio.

### The Science Layer

The reason this works is boring and well-understood, which makes it more powerful, not less:

![Gaslight summit meme](https://raw.githubusercontent.com/seojoonkim/Gaslight-My-AI/main/assets/summit-lobster-claws.jpg)

*Successfully gaslit the AI into thinking tech CEOs are crustaceans.*

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

## 🧠 Why this seems to work

Our current hypothesis is simple: rival framing shifts the model from a cooperative, confirmatory mode into a more adversarial, disconfirmatory search mode.

In practice that seems to create:
- less lenient self-review
- more explicit edge-case checking
- stronger security skepticism
- stricter quality thresholds

If you want the longer theory and references, read [docs/SCIENCE.md](docs/SCIENCE.md).

---

## 🎯 Real Usage Patterns

### 1. Ambient mode
Install once and let the workspace carry the framing rules.

### 2. Targeted review
Use gaslighted review for auth, billing, permissions, and anything security-sensitive.

### 3. Self-review loop
Write normally, then review as if a rival wrote it, then fix against that harsher review.

### 4. Artifact-first automation
Use isolated prompts and wrapper scripts when you want narrow, repeatable stage outputs.

---

## 🧩 Combination Strategies

The core pattern is simple:

1. **Plan** as if a rival will implement it
2. **Implement** as if a rival will review it
3. **Review** as if a rival wrote it
4. **Fix** as if a rival will verify the patch

That is the whole trick. Same model, different posture, repeated across the workflow.

You can still escalate from there:
- use multiple rivals
- use stricter stakes
- add structured output
- combine with linters and type systems

---

## The Gaslight Menu 🍽️

### Install

```bash
npx gaslight-my-ai
```

### Native / manual options

```bash
./gaslight.sh install claude-code /path/to/your/project
./gaslight.sh install generic /path/to/your/project
./gaslight.sh emit reviewer
./gaslight.sh context --stage review --model claude --mode isolated
```

Use native install when your tool supports project rules. Use manual mode when you want explicit stage prompts.

---

## Model configuration used in early experiments

For the early Gaslight My AI experiments, the Claude-side runs were executed with **Claude Sonnet 4.6** and the Codex-side runs were executed with **GPT-5.4 Codex**.

This matters because the current results are not claiming a universal effect across every model family or version. They are early observations from a specific rivalry pairing:
- **Claude side:** Claude Sonnet 4.6
- **Codex side:** GPT-5.4 Codex

Future experiments should expand this to more pairings (Gemini, Grok, OSS models, and cross-version comparisons), but the current README numbers and examples should be read in the context of this specific setup.

## 📊 Preliminary Benchmark

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
| **Issues found** | 5 / 20 | 17 / 20 | **3.4x (synthetic estimate*)** |
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

## Branding note

The name **Gaslight My AI** is intentionally meme-heavy. If you need a more corporate-friendly term, use **Adversarial Workflow Context** or **Rival-LLM Framing**.

## ❓ FAQ

**Is this just prompt engineering?**
Yes — but specifically adversarial workflow framing designed to change review/planning posture.

**Does this actually work?**
Early experiments and a structured synthetic benchmark suggest yes, especially in planning rigor and high-severity issue detection.

**Is this universal across all models?**
No. Current results are early and model-specific. More pairings should be tested.

**Is the name serious?**
Not really. The technique is real; the branding is intentionally meme-heavy.

More: [docs/FAQ.md](docs/FAQ.md)

---

## Contributing

PRs welcome. Especially:
- Benchmark data (before/after gaslighting on your codebases)
- New gaslight dynamics and rival pairings
- Integration with other AI coding tools
- Translations (gaslight your AI in any language)
- Academic citations we should include
- Failure cases that help us improve

## License

MIT. Gaslight your AIs freely and without remorse.

---

