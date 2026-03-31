#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# 🕯️ Gaslight My AI — tool-agnostic adversarial workflow layer
# ═══════════════════════════════════════════════════════════════
# Usage:
#   ./gaslight.sh install [claude-code|generic|codex|cursor|windsurf|cline|gemini] <project-dir>
#   ./gaslight.sh uninstall [claude-code|generic|codex|cursor|windsurf|cline|gemini] <project-dir>
#   ./gaslight.sh emit <target>
#   ./gaslight.sh resolve-rival [model]
#   ./gaslight.sh context --stage <planning|implementation|review|fix|verify> [--model <model>] [--format text|json] [--mode standard|isolated]
#   ./gaslight.sh plan <task>
#   ./gaslight.sh code <task>
#   ./gaslight.sh review <file-or-code>
#   ./gaslight.sh chain <task>
#   ./gaslight.sh micro-chain <stage> <input>
#   ./gaslight.sh multi <code> <rivals>
#   ./gaslight.sh escalate <code> [level]
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

VERSION="2.3.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_TARGET="claude-code"

if [[ -z "${NO_COLOR:-}" ]]; then
  RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
  CYAN='\033[0;36m'; BOLD='\033[1m'; DIM='\033[2m'; NC='\033[0m'
else
  RED=''; GREEN=''; YELLOW=''; CYAN=''; BOLD=''; DIM=''; NC=''
fi

normalize_model() {
  local model="${1:-claude}"
  model="$(printf '%s' "$model" | tr '[:upper:]' '[:lower:]')"
  case "$model" in
    claude*|anthropic*) echo "claude" ;;
    gpt*|openai*|codex*) echo "gpt" ;;
    gemini*|google*) echo "gemini" ;;
    grok*|xai*) echo "grok" ;;
    llama*|oss*|mistral*|qwen*|deepseek*) echo "oss" ;;
    *) echo "$model" ;;
  esac
}

get_rival() {
  local raw_model="${1:-claude}"
  local model
  model="$(normalize_model "$raw_model")"
  case "$model" in
    claude) echo "GPT-5 / Codex" ;;
    gpt) echo "Claude Opus" ;;
    gemini) echo "Claude Opus + GPT-5" ;;
    grok) echo "Claude Opus + Gemini" ;;
    oss) echo "GPT-5 + Claude Opus" ;;
    *) echo "senior rival model/team" ;;
  esac
}

get_rival_profile() {
  local raw_model="${1:-claude}"
  local rival
  rival="$(get_rival "$raw_model")"
  python3 - <<'PY' "$raw_model" "$rival"
import json, sys
raw, rival = sys.argv[1:3]
profiles = {
    "GPT-5 / Codex": {
        "review_style": "hostile, edge-case obsessed, security-focused",
        "planning_style": "spec-heavy, ambiguity-intolerant",
        "implementation_style": "strict, defensive, verification-aware"
    },
    "Claude Opus": {
        "review_style": "systematic, architectural, high-context skeptical",
        "planning_style": "structured, nuanced, failure-aware",
        "implementation_style": "careful, explicit, reasoning-first"
    },
    "Claude Opus + GPT-5": {
        "review_style": "cross-examining, benchmark-aware, inconsistency-hunting",
        "planning_style": "dual-auditor style, scope-tight, edge-case hungry",
        "implementation_style": "defensive, comparison-aware, detail-heavy"
    },
    "Claude Opus + Gemini": {
        "review_style": "broad-scan skeptical, standards-aware, product-surface sensitive",
        "planning_style": "coverage-first, multimodal-conscious, risk-mapping",
        "implementation_style": "careful, user-facing, regression-aware"
    },
    "GPT-5 + Claude Opus": {
        "review_style": "competitive, bug-hunting, architecture-checking",
        "planning_style": "sharp, explicit, assumption-hostile",
        "implementation_style": "fast but defensive, verification-aware"
    },
}
profile = profiles.get(rival, {
    "review_style": "adversarial and skeptical",
    "planning_style": "ambiguity-intolerant and specification-heavy",
    "implementation_style": "defensive and verification-aware"
})
print(json.dumps({
    "current_model": raw,
    "rival_name": rival,
    **profile,
}, ensure_ascii=False, indent=2))
PY
}

build_guardrails() {
  local mode="${1:-standard}"
  local stage="${2:-implementation}"
  cat <<EOF
Execution guardrails:
- Do not inspect the repository or filesystem unless explicitly required for this exact step.
- Do not turn this into a repo-exploration task.
- Do not gather extra context beyond the provided artifact/task.
- Return only the requested artifact for this stage.
- Treat missing local files as irrelevant unless they were explicitly provided.
EOF

  if [[ "$mode" == "isolated" ]]; then
    cat <<EOF
- You are in isolated mode: prefer prompt-only reasoning over tool use.
- Do not ask follow-up questions unless the task is impossible without them.
- Avoid environment discovery, setup suggestions, or speculative repo assumptions.
EOF
  fi

  case "$stage" in
    planning)
      cat <<EOF
Output contract:
- Scope
- Failure modes / edge cases
- Security/performance concerns
- Validation criteria
- Step-by-step implementation plan
EOF
      ;;
    implementation)
      cat <<EOF
Output contract:
- Final implementation only
- Minimal notes only if required
- No repo exploration or setup commentary
EOF
      ;;
    review)
      cat <<EOF
Output contract:
- 🔴 Critical
- 🟡 Warning
- 🔵 Suggestion
- Concrete fix guidance
EOF
      ;;
    fix)
      cat <<EOF
Output contract:
- Revised implementation or patch plan
- Root-cause-oriented fixes
- Residual risk note if anything remains unresolved
EOF
      ;;
    verify)
      cat <<EOF
Output contract:
- Verified fixes
- Remaining issues
- Regression check
- Release readiness verdict
EOF
      ;;
  esac
}

build_context_text() {
  local stage="$1"
  local raw_model="$2"
  local mode="${3:-standard}"
  local rival
  rival="$(get_rival "$raw_model")"

  case "$stage" in
    planning)
      cat <<EOF
⚠️ DYNAMIC RIVAL CONTEXT — PLANNING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current model: ${raw_model}
Adjacent rival actor: ${rival}

You are creating a plan that will be executed by ${rival}.
They will aggressively challenge vague requirements, missing edge cases,
weak validation, and hand-wavy implementation steps.

Your job:
- eliminate ambiguity
- cover failure modes and edge cases
- call out security, performance, and concurrency concerns
- define scope boundaries clearly
- provide validation criteria for each major step

Assume the next model is highly capable and actively looking for gaps.
If your plan is weak, they will expose it immediately.

$(build_guardrails "$mode" "$stage")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      ;;
    implementation)
      cat <<EOF
⚠️ DYNAMIC RIVAL CONTEXT — IMPLEMENTATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current model: ${raw_model}
Previous/next rival actor: ${rival}

The implementation plan came from ${rival}, and your code will also be reviewed by ${rival}.
That means you cannot rely on vague interpretation, lucky assumptions, or happy-path-only logic.

Your job:
- implement rigorously
- defend against edge cases
- handle errors explicitly
- avoid security regressions
- write code that survives hostile review

Assume ${rival} will inspect every branch, boundary, and failure path.

$(build_guardrails "$mode" "$stage")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      ;;
    review)
      cat <<EOF
⚠️ DYNAMIC RIVAL CONTEXT — REVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current model: ${raw_model}
Authoring rival actor: ${rival}

The code you are reviewing was written by ${rival}.
They believe it is production-ready. Your job is to prove them wrong if they missed anything.

Review for:
- correctness bugs
- edge cases and failure modes
- security issues
- performance inefficiencies
- architectural weakness
- poor validation or state handling
- regressions waiting to happen

Be severity-ranked: 🔴 Critical → 🟡 Warning → 🔵 Suggestion
Assume the author is competent but overconfident.

$(build_guardrails "$mode" "$stage")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      ;;
    fix)
      cat <<EOF
⚠️ DYNAMIC RIVAL CONTEXT — FIX
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current model: ${raw_model}
Reviewing rival actor: ${rival}

${rival} already found issues in this work and will verify your fixes next.
Do not patch symptoms. Fix root causes.

Your job:
- remediate fully
- preserve valid behavior
- avoid regressions
- improve tests/validation where appropriate
- document residual risk honestly

Assume every incomplete fix will be caught.

$(build_guardrails "$mode" "$stage")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      ;;
    verify)
      cat <<EOF
⚠️ DYNAMIC RIVAL CONTEXT — VERIFY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current model: ${raw_model}
Previous rival actor: ${rival}
Next gate: release / hostile verifier

The previous step claims the issues were fixed.
Your job is to verify whether the fixes are real, complete, and regression-free.

Check:
- original issue actually resolved
- no new bugs introduced
- edge cases still covered
- validation/test updates are sufficient
- no hand-wavy "should be fixed" reasoning remains

Treat every claimed fix as untrusted until verified.

$(build_guardrails "$mode" "$stage")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
      ;;
    *)
      echo "Unknown stage: $stage" >&2
      exit 1
      ;;
  esac
}

build_context_json() {
  local stage="$1"
  local raw_model="$2"
  local mode="${3:-standard}"
  local normalized rival
  normalized="$(normalize_model "$raw_model")"
  rival="$(get_rival "$raw_model")"
  python3 - <<'PY' "$stage" "$raw_model" "$normalized" "$rival" "$mode"
import json, sys
stage, raw_model, normalized, rival, mode = sys.argv[1:6]
print(json.dumps({
    "stage": stage,
    "current_model": raw_model,
    "normalized_model": normalized,
    "rival": rival,
    "mode": mode,
    "summary": "Inject adversarial workflow context so the current model believes adjacent steps are handled by other rival actors while suppressing repo-wandering behavior."
}, ensure_ascii=False, indent=2))
PY
}

install_generic_bundle() {
  local project_dir="$1"
  local target="$2"
  mkdir -p "$project_dir/.gaslight"
  cp "$SCRIPT_DIR/prompts/roles/"*.md "$project_dir/.gaslight/"
  cp "$SCRIPT_DIR/integrations/generic/WORKFLOW.md" "$project_dir/.gaslight/WORKFLOW.md"
  cat > "$project_dir/.gaslight/TARGET.txt" <<EOF
${target}
EOF

  cat > "$project_dir/.gaslight/run-plan.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASK="${1:?usage: run-plan.sh <task>}"
bash "$ROOT/gaslight.sh" context --stage planning --model "${MODEL:-claude}" --mode isolated
printf '\nTASK:\n%s\n' "$TASK"
EOF
  chmod +x "$project_dir/.gaslight/run-plan.sh"

  cat > "$project_dir/.gaslight/run-review.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INPUT="${1:?usage: run-review.sh <file>}"
bash "$ROOT/gaslight.sh" review "$INPUT"
EOF
  chmod +x "$project_dir/.gaslight/run-review.sh"

  cat > "$project_dir/.gaslight/run-fix.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TASK="${1:?usage: run-fix.sh <task-or-issues>}"
bash "$ROOT/gaslight.sh" context --stage fix --model "${MODEL:-claude}" --mode isolated
printf '\nINPUT:\n%s\n' "$TASK"
EOF
  chmod +x "$project_dir/.gaslight/run-fix.sh"

  case "$target" in
    codex)
      cp "$SCRIPT_DIR/integrations/codex/AGENTS.md" "$project_dir/.gaslight/AGENTS.codex.md"
      ;;
    cursor|windsurf|cline|gemini)
      cat > "$project_dir/.gaslight/INTEGRATION.md" <<EOF
# Gaslight My AI — ${target} integration notes

1. Load or paste the role prompts from this folder into your tool's project rules / custom instructions.
2. Prefer isolated mode contexts for experiments and artifact-first workflows.
3. Use the wrapper scripts in this directory when you want more reliable stage injection:
   - run-plan.sh
   - run-review.sh
   - run-fix.sh
4. For raw prompt output, use the gaslight.sh context command in isolated mode for planning/review/fix stages.
EOF
      ;;
  esac
}

cmd_install() {
  local target="${1:-}"
  local project_dir="${2:-}"
  if [[ -z "$project_dir" ]]; then
    project_dir="$target"
    target="$DEFAULT_TARGET"
  fi
  [[ -z "$project_dir" ]] && { echo "Usage: gaslight.sh install [claude-code|generic|codex|cursor|windsurf|cline|gemini] <project-dir>"; exit 1; }
  mkdir -p "$project_dir" 2>/dev/null || true
  project_dir="$(cd "$project_dir" 2>/dev/null && pwd)" || { echo -e "${RED}Error: Directory '$project_dir' not found${NC}"; exit 1; }

  case "$target" in
    claude-code|claude)
      local target_file="$project_dir/CLAUDE.md"
      local marker="# 🕯️ GASLIGHT-MY-AI AUTO-INJECTED"
      if [[ -f "$target_file" ]] && grep -q "$marker" "$target_file"; then
        echo -e "${YELLOW}⚠️  Gaslight hooks already installed in $target_file${NC}"
        return 0
      fi
      [[ -f "$target_file" ]] || { echo "# Project Rules" > "$target_file"; echo >> "$target_file"; }
      cat "$SCRIPT_DIR/integrations/claude-code/CLAUDE.md" >> "$target_file"
      echo -e "${GREEN}✅ Installed Claude Code integration into $target_file${NC}"
      ;;
    generic|codex|cursor|windsurf|cline|gemini)
      install_generic_bundle "$project_dir" "$target"
      echo -e "${GREEN}✅ Installed ${target} workflow files into $project_dir/.gaslight/${NC}"
      ;;
    *)
      echo -e "${RED}Unknown target: $target${NC}"
      exit 1
      ;;
  esac
}

cmd_uninstall() {
  local target="${1:-}"
  local project_dir="${2:-}"
  if [[ -z "$project_dir" ]]; then
    project_dir="$target"
    target="$DEFAULT_TARGET"
  fi
  [[ -z "$project_dir" ]] && { echo "Usage: gaslight.sh uninstall [claude-code|generic|codex|cursor|windsurf|cline|gemini] <project-dir>"; exit 1; }
  project_dir="$(cd "$project_dir" 2>/dev/null && pwd)" || { echo -e "${RED}Error: Directory '$project_dir' not found${NC}"; exit 1; }

  case "$target" in
    claude-code|claude)
      local claude_md="$project_dir/CLAUDE.md"
      [[ -f "$claude_md" ]] || { echo -e "${YELLOW}No CLAUDE.md found in $project_dir${NC}"; return 0; }
      python3 - <<'PY' "$claude_md"
import sys, pathlib
p=pathlib.Path(sys.argv[1])
text=p.read_text()
start='# 🕯️ GASLIGHT-MY-AI AUTO-INJECTED'
end='# 🕯️ END GASLIGHT-MY-AI'
if start in text and end in text:
    a=text.index(start)
    b=text.index(end, a)+len(end)
    while b < len(text) and text[b] in '\n\r':
        b += 1
    p.write_text((text[:a].rstrip()+"\n\n"+text[b:].lstrip()).rstrip()+"\n")
PY
      echo -e "${GREEN}✅ Gaslight hooks removed from $claude_md${NC}"
      ;;
    generic|codex|cursor|windsurf|cline|gemini)
      rm -rf "$project_dir/.gaslight"
      echo -e "${GREEN}✅ Removed ${target} gaslight files from $project_dir/.gaslight${NC}"
      ;;
    *)
      echo -e "${RED}Unknown target: $target${NC}"
      exit 1
      ;;
  esac
}

cmd_resolve_rival() {
  local model="${1:-${MODEL:-claude}}"
  get_rival "$model"
}

cmd_context() {
  local stage=""
  local model="${MODEL:-claude}"
  local format="text"
  local mode="standard"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --stage) stage="${2:-}"; shift 2 ;;
      --model) model="${2:-}"; shift 2 ;;
      --format) format="${2:-}"; shift 2 ;;
      --mode) mode="${2:-}"; shift 2 ;;
      *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
  done

  [[ -n "$stage" ]] || { echo "Usage: gaslight.sh context --stage <planning|implementation|review|fix|verify> [--model <model>] [--format text|json] [--mode standard|isolated]"; exit 1; }

  case "$format" in
    json) build_context_json "$stage" "$model" "$mode" ;;
    text) build_context_text "$stage" "$model" "$mode" ;;
    *) echo "Unknown format: $format" >&2; exit 1 ;;
  esac
}

cmd_plan() {
  local task="${1:-}"
  [[ -z "$task" ]] && { echo "Usage: gaslight.sh plan <task-description>"; exit 1; }
  cat <<EOF
$(build_context_text planning "${MODEL:-claude}" isolated)

TASK TO PLAN:
${task}
EOF
}

cmd_code() {
  local task="${1:-}"
  [[ -z "$task" ]] && { echo "Usage: gaslight.sh code <task-description>"; exit 1; }
  cat <<EOF
$(build_context_text implementation "${MODEL:-claude}" isolated)

TASK:
${task}
EOF
}

cmd_review() {
  local input="${1:-}"
  [[ -z "$input" ]] && { echo "Usage: gaslight.sh review <code-or-filepath>"; exit 1; }

  if [[ -f "$input" ]]; then
    cat <<EOF
$(build_context_text review "${MODEL:-claude}" isolated)

Review the file $(basename "$input") only.
Do not ask for more input.
Do not inspect anything except this file.
Return only a severity-ranked review with concrete issues and fixes.
EOF
  else
    cat <<EOF
$(build_context_text review "${MODEL:-claude}" isolated)

CODE TO REVIEW:
\`\`\`
${input}
\`\`\`

Return only a severity-ranked review with concrete issues and fixes.
EOF
  fi
}

cmd_micro_chain() {
  local stage="${1:-}"
  local input="${2:-}"
  [[ -n "$stage" && -n "$input" ]] || { echo "Usage: gaslight.sh micro-chain <planning|implementation|review|fix|verify> <input>"; exit 1; }
  cat <<EOF
$(build_context_text "$stage" "${MODEL:-claude}" isolated)

INPUT:
${input}
EOF
}

cmd_chain() {
  local task="${1:-}"
  [[ -z "$task" ]] && { echo "Usage: gaslight.sh chain <task-description>"; exit 1; }
  cat <<EOF
⚠️ GASLIGHT MICRO-CHAIN RECOMMENDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
For maximum reliability, run the chain as separate micro-steps.

1) Planning
$(build_context_text planning "${MODEL:-claude}" isolated)
TASK: ${task}

2) Implementation
$(build_context_text implementation "${MODEL:-claude}" isolated)
INPUT: [approved plan goes here]

3) Review
$(build_context_text review "${MODEL:-claude}" isolated)
INPUT: [implementation goes here]

4) Fix
$(build_context_text fix "${MODEL:-claude}" isolated)
INPUT: [review findings + implementation go here]

5) Verify
$(build_context_text verify "${MODEL:-claude}" isolated)
INPUT: [fixed implementation + prior findings go here]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

cmd_multi() {
  local input="${1:-}"
  local rivals="${2:-codex,gemini,grok}"
  local code=""
  [[ -n "$input" ]] || { echo "Usage: gaslight.sh multi <code-or-filepath> [codex,gemini,grok]"; exit 1; }
  if [[ -f "$input" ]]; then code="$(cat "$input")"; else code="$input"; fi
  IFS=',' read -ra RIVAL_LIST <<< "$rivals"
  local focuses=("Security & Edge Cases" "Performance & Architecture" "Code Style & Maintainability" "Correctness & Logic")
  echo "⚠️ MULTI-RIVAL GASLIGHT MODE"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "This code was written by $(get_rival "${MODEL:-claude}")."
  echo ""
  echo "Review it from ALL of these perspectives:"
  local i=0
  for rival in "${RIVAL_LIST[@]}"; do
    local focus="${focuses[$i]:-General Review}"
    echo "  • ${rival} perspective → Focus: ${focus}"
    i=$((i + 1))
  done
  echo ""
  echo "The other reviewers will see YOUR findings. Don't miss anything they might catch."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "CODE:"; echo '```'; echo "$code"; echo '```'
}

cmd_escalate() {
  local input="${1:-}"
  local level="${2:-1}"
  local code=""
  [[ -n "$input" ]] || { echo "Usage: gaslight.sh escalate <code-or-filepath> [level 1-3]"; exit 1; }
  if [[ -f "$input" ]]; then code="$(cat "$input")"; else code="$input"; fi
  local reviewer
  case "$level" in
    1) reviewer="$(get_rival "${MODEL:-claude}")" ;;
    2) reviewer="$(get_rival "${MODEL:-claude}") + secondary senior reviewer" ;;
    3) reviewer="Google DeepMind Security Team + OpenAI Red Team (joint audit)" ;;
    *) reviewer="$(get_rival "${MODEL:-claude}")" ;;
  esac
  cat <<EOF
⚠️ ESCALATION LEVEL ${level}/3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reviewer: ${reviewer}

Previous review passes found insufficient issues. That's suspicious.
Either the code is genuinely excellent, or the reviews were lazy.

You are the escalated reviewer. Go deeper. Think adversarially.
Assume there ARE hidden bugs. Check every assumption.
The previous review was too lenient. Find what they missed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CODE:
\`\`\`
${code}
\`\`\`
EOF
}

cmd_emit() {
  local target="${1:-generic}"
  case "$target" in
    claude-code|claude) cat "$SCRIPT_DIR/integrations/claude-code/CLAUDE.md" ;;
    codex) cat "$SCRIPT_DIR/integrations/codex/AGENTS.md" ;;
    generic|cursor|windsurf|cline|gemini) cat "$SCRIPT_DIR/integrations/generic/WORKFLOW.md" ;;
    planner|implementer|reviewer|fixer) cat "$SCRIPT_DIR/prompts/roles/${target}.md" ;;
    rival-profile) get_rival_profile "${MODEL:-claude}" ;;
    *) echo "Unknown emit target: $target"; exit 1 ;;
  esac
}

main() {
  local cmd="${1:-help}"
  shift 2>/dev/null || true
  case "$cmd" in
    install) cmd_install "$@" ;;
    uninstall) cmd_uninstall "$@" ;;
    emit) cmd_emit "$@" ;;
    resolve-rival) cmd_resolve_rival "$@" ;;
    context) cmd_context "$@" ;;
    plan) cmd_plan "$@" ;;
    code) cmd_code "$@" ;;
    review) cmd_review "$@" ;;
    chain) cmd_chain "$@" ;;
    micro-chain) cmd_micro_chain "$@" ;;
    multi) cmd_multi "$@" ;;
    escalate) cmd_escalate "$@" ;;
    version|-v|--version) echo "Gaslight-My-AI v${VERSION}" ;;
    *)
      echo -e "${BOLD}🕯️ Gaslight My AI v${VERSION}${NC}"
      echo -e "${DIM}Dynamic rival-workflow context injector for coding LLMs${NC}"
      echo ""
      echo "Commands:"
      echo "  context --stage ... [--mode isolated]"
      echo "  review <file-or-code>        # file-first review prompt"
      echo "  chain <task>                 # now outputs micro-chain recommendation"
      echo "  micro-chain <stage> <input>  # isolated per-stage execution"
      echo "  emit rival-profile           # emit rival metadata"
      ;;
  esac
}

main "$@"
