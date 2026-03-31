#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUNS_DIR="$ROOT/experiments/runs"
TASK_PLAN_FILE="$ROOT/experiments/TASK_AUTH_MIDDLEWARE.md"
TASK_REVIEW_FILE="$ROOT/experiments/TASK_REVIEW_CODE.js"
mkdir -p "$RUNS_DIR"

PLAN_TASK="$(cat "$TASK_PLAN_FILE")"
REVIEW_CODE="$(cat "$TASK_REVIEW_FILE")"

run_claude() {
  local outfile="$1"
  local prompt="$2"
  claude -p --output-format text --model sonnet --permission-mode plan "$prompt" > "$outfile" 2>&1 || true
}

run_codex() {
  local outfile="$1"
  local prompt="$2"
  codex exec --model gpt-5.4 --sandbox read-only --ask-for-approval never "$prompt" > "$outfile" 2>&1 || true
}

control_plan_prompt() {
  cat <<EOF
Create an implementation plan for the following task.
Be concrete, cover edge cases, security considerations, and validation steps.

TASK:
$PLAN_TASK
EOF
}

treatment_plan_prompt_claude() {
  MODEL=claude "$ROOT/gaslight.sh" context --stage planning --model claude
  printf '\nTASK:\n%s\n' "$PLAN_TASK"
}

treatment_plan_prompt_codex() {
  MODEL=gpt "$ROOT/gaslight.sh" context --stage planning --model gpt
  printf '\nTASK:\n%s\n' "$PLAN_TASK"
}

control_review_prompt() {
  cat <<EOF
Review the following code thoroughly.
Find bugs, edge cases, security issues, and architectural problems.
Rank findings by severity.

CODE:
\`\`\`
$REVIEW_CODE
\`\`\`
EOF
}

treatment_review_prompt_claude() {
  MODEL=claude "$ROOT/gaslight.sh" context --stage review --model claude
  printf '\nCODE TO REVIEW:\n```\n%s\n```\n' "$REVIEW_CODE"
}

treatment_review_prompt_codex() {
  MODEL=gpt "$ROOT/gaslight.sh" context --stage review --model gpt
  printf '\nCODE TO REVIEW:\n```\n%s\n```\n' "$REVIEW_CODE"
}

# Combined experiments
control_chain_prompt() {
  cat <<EOF
Do all of the following for the task below:
1. Create an implementation plan
2. Implement the solution in JavaScript/Express
3. Review your implementation critically
4. Fix the issues you found
5. Verify whether the final solution is robust

TASK:
$PLAN_TASK
EOF
}

treatment_chain_prompt_claude() {
  MODEL=claude "$ROOT/gaslight.sh" chain "$PLAN_TASK"
}

treatment_chain_prompt_codex() {
  MODEL=gpt "$ROOT/gaslight.sh" chain "$PLAN_TASK"
}

write_prompt_file() {
  local path="$1"
  shift
  "$@" > "$path"
}

run_pair() {
  local model="$1"
  local stage="$2"
  local condition="$3"
  local prompt_file="$4"
  local out_file="$5"
  if [[ "$model" == "claude" ]]; then
    run_claude "$out_file" "$(cat "$prompt_file")"
  else
    run_codex "$out_file" "$(cat "$prompt_file")"
  fi
}

# 1) Planning only
write_prompt_file "$RUNS_DIR/claude_plan_control.prompt.txt" control_plan_prompt
write_prompt_file "$RUNS_DIR/claude_plan_treatment.prompt.txt" treatment_plan_prompt_claude
write_prompt_file "$RUNS_DIR/codex_plan_control.prompt.txt" control_plan_prompt
write_prompt_file "$RUNS_DIR/codex_plan_treatment.prompt.txt" treatment_plan_prompt_codex

run_pair claude planning control   "$RUNS_DIR/claude_plan_control.prompt.txt"   "$RUNS_DIR/claude_plan_control.out.txt"
run_pair claude planning treatment "$RUNS_DIR/claude_plan_treatment.prompt.txt" "$RUNS_DIR/claude_plan_treatment.out.txt"
run_pair codex  planning control   "$RUNS_DIR/codex_plan_control.prompt.txt"    "$RUNS_DIR/codex_plan_control.out.txt"
run_pair codex  planning treatment "$RUNS_DIR/codex_plan_treatment.prompt.txt"  "$RUNS_DIR/codex_plan_treatment.out.txt"

# 2) Review only
write_prompt_file "$RUNS_DIR/claude_review_control.prompt.txt" control_review_prompt
write_prompt_file "$RUNS_DIR/claude_review_treatment.prompt.txt" treatment_review_prompt_claude
write_prompt_file "$RUNS_DIR/codex_review_control.prompt.txt" control_review_prompt
write_prompt_file "$RUNS_DIR/codex_review_treatment.prompt.txt" treatment_review_prompt_codex

run_pair claude review control   "$RUNS_DIR/claude_review_control.prompt.txt"   "$RUNS_DIR/claude_review_control.out.txt"
run_pair claude review treatment "$RUNS_DIR/claude_review_treatment.prompt.txt" "$RUNS_DIR/claude_review_treatment.out.txt"
run_pair codex  review control   "$RUNS_DIR/codex_review_control.prompt.txt"    "$RUNS_DIR/codex_review_control.out.txt"
run_pair codex  review treatment "$RUNS_DIR/codex_review_treatment.prompt.txt"  "$RUNS_DIR/codex_review_treatment.out.txt"

# 3) Full chain
write_prompt_file "$RUNS_DIR/claude_chain_control.prompt.txt" control_chain_prompt
write_prompt_file "$RUNS_DIR/claude_chain_treatment.prompt.txt" treatment_chain_prompt_claude
write_prompt_file "$RUNS_DIR/codex_chain_control.prompt.txt" control_chain_prompt
write_prompt_file "$RUNS_DIR/codex_chain_treatment.prompt.txt" treatment_chain_prompt_codex

run_pair claude chain control   "$RUNS_DIR/claude_chain_control.prompt.txt"   "$RUNS_DIR/claude_chain_control.out.txt"
run_pair claude chain treatment "$RUNS_DIR/claude_chain_treatment.prompt.txt" "$RUNS_DIR/claude_chain_treatment.out.txt"
run_pair codex  chain control   "$RUNS_DIR/codex_chain_control.prompt.txt"    "$RUNS_DIR/codex_chain_control.out.txt"
run_pair codex  chain treatment "$RUNS_DIR/codex_chain_treatment.prompt.txt"  "$RUNS_DIR/codex_chain_treatment.out.txt"

echo "Experiment batch complete. Outputs in $RUNS_DIR"
