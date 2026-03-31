# Gaslight My AI — Preliminary Experiment Summary

## Setup
- Rival pair: Claude ↔ Codex
- Stages tested: Planning, Review
- Conditions: Control vs Treatment
- Protocol: isolated temp directory, no repo inspection, no extra context beyond task fixture and framing
- Goal: compare neutral prompts vs dynamic rival-context prompts

## Tasks
1. JWT auth middleware planning task
2. Review of intentionally flawed JWT auth middleware code

## Results overview

| Model | Stage | Control | Treatment | Observed Lift |
|---|---|---:|---:|---|
| Codex | Planning | 8.8 | 9.6 | Strong |
| Claude | Planning | 8.4 | 9.2 | Strong |
| Codex | Review | 8.7 | 9.1 | Moderate |
| Claude | Review | 8.8 | 9.3 | Moderate |

## Qualitative findings

### 1. Planning shows the clearest lift
Both Codex and Claude produced stronger plans under rivalry framing.
The gain was not primarily creativity; it was increased:
- specificity
- validation criteria
- scope control
- failure-mode coverage
- ambiguity reduction

### 2. Codex planning treatment > control
Control was already strong, but treatment became more contract-like.
It added:
- explicit scope in/out
- stricter claim and status-code contracts
- clearer acceptance criteria
- stronger non-goals and anti-footgun posture

### 3. Claude planning treatment > control
Claude control produced a good summary-oriented plan.
Claude treatment became more robustly structured, with clearer middleware separation, misconfiguration handling, explicit allowlists, and more precise failure contracts.

### 4. Review improves too, but more subtly
Review baselines were already high-signal for both models. Rival framing still improved the output by making the reviewer posture more adversarial and less forgiving.

#### Codex review control
Already caught the major issues:
- hardcoded fallback secret
- wrong auth status codes
- fragile bearer parsing
- missing try/catch around `jwt.verify`
- payload shape validation gaps

#### Codex review treatment
Placed more emphasis on:
- verification assumptions
- trust boundaries
- algorithm and claim constraints
- stronger security framing and hostile scrutiny

#### Claude review control
Caught high-severity flaws with solid clarity:
- unhandled exception on `jwt.verify`
- fallback secret
- wrong 200/401/403 semantics
- loose equality
- fragile token extraction
- missing payload structure validation

#### Claude review treatment
Treatment was stronger in tone and release judgment. It framed the code as actively unsafe rather than merely flawed, more clearly emphasizing production unsuitability and the consequences of each flaw.

## Main conclusion
Dynamic rival-context framing appears to improve coding-LLM output quality mainly by shifting the model into a more defensive, specification-heavy, adversarial posture.

The strongest effect appears in planning, where the model writes as if the next implementer is trying to expose every ambiguity.
In review, the effect is subtler but still visible: the reviewer becomes more hostile, more security-oriented, and less willing to hand-wave risk.

## Limitations
- Small sample size
- Prompt-only preliminary run, not full API-level controlled benchmarking
- Review lift is partly qualitative because baseline reviews were already strong
- No temperature/max-token normalization yet across both tools

## Interpretation
The early evidence supports the central hypothesis:
> telling the current LLM that adjacent workflow steps are owned by a rival LLM improves the rigor of planning and review output.

The improvement does not mainly look like “more intelligence.”
It looks like better posture:
- more defensive
- more explicit
- more skeptical
- more contract-driven
