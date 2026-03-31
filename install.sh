#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/seojoonkim/Gaslight-My-AI.git"
INSTALL_DIR_DEFAULT="$HOME/.gaslight-my-ai"
TARGET_DIR="${1:-$PWD}"
INSTALL_DIR="${GASLIGHT_HOME:-$INSTALL_DIR_DEFAULT}"
SCRIPT_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE_TARGET="${GASLIGHT_TARGET:-}"

say() { printf '%s\n' "$*"; }

prepare_repo() {
  if [ -f "$SCRIPT_SOURCE_DIR/gaslight.sh" ] && [ -d "$SCRIPT_SOURCE_DIR/prompts" ]; then
    say "[gaslight] using local source repo: $SCRIPT_SOURCE_DIR"
    INSTALL_DIR="$SCRIPT_SOURCE_DIR"
    return
  fi

  if ! command -v git >/dev/null 2>&1; then
    say "[gaslight] error: git is required when no local source repo is available"
    exit 1
  fi

  if [ -d "$INSTALL_DIR/.git" ]; then
    say "[gaslight] updating existing install in $INSTALL_DIR"
    git -C "$INSTALL_DIR" pull --ff-only >/dev/null 2>&1 || true
  else
    say "[gaslight] cloning repo into $INSTALL_DIR"
    rm -rf "$INSTALL_DIR"
    git clone "$REPO_URL" "$INSTALL_DIR" >/dev/null 2>&1
  fi
}

detect_target() {
  local dir="$1"
  if [ -n "$FORCE_TARGET" ]; then
    echo "$FORCE_TARGET"
    return
  fi
  if [ -f "$dir/CLAUDE.md" ]; then
    echo "claude-code"
    return
  fi
  if [ -f "$dir/AGENTS.md" ] || [ -f "$dir/agents.md" ]; then
    echo "codex"
    return
  fi
  if [ -d "$dir/.cursor" ] || [ -f "$dir/.cursor/rules" ] || [ -f "$dir/.cursorrules" ]; then
    echo "cursor"
    return
  fi
  if [ -f "$dir/.windsurfrules" ] || [ -d "$dir/.windsurf" ]; then
    echo "windsurf"
    return
  fi
  if [ -d "$dir/.cline" ] || [ -f "$dir/.clinerules" ]; then
    echo "cline"
    return
  fi
  if [ -f "$dir/gemini.md" ] || [ -d "$dir/.gemini" ]; then
    echo "gemini"
    return
  fi
  echo "generic"
}

install_adapter_notes() {
  local target_dir="$1"
  local detected="$2"
  mkdir -p "$target_dir/.gaslight"
  case "$detected" in
    codex)
      cp "$INSTALL_DIR/integrations/codex/AGENTS.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
    cursor)
      cp "$INSTALL_DIR/integrations/cursor/RULES.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
    windsurf)
      cp "$INSTALL_DIR/integrations/windsurf/RULES.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
    cline)
      cp "$INSTALL_DIR/integrations/cline/RULES.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
    gemini)
      cp "$INSTALL_DIR/integrations/gemini/RULES.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
    generic)
      cp "$INSTALL_DIR/integrations/generic/WORKFLOW.md" "$target_dir/.gaslight/ADAPTER.md"
      ;;
  esac
}

write_install_report() {
  local target_dir="$1"
  local detected="$2"
  cat > "$target_dir/.gaslight/INSTALL_REPORT.md" <<'EOF'
# Gaslight My AI — Install Report

- Install mode: best-effort auto-adaptation

## What was installed
- Stage role prompts
- Wrapper scripts (run-plan.sh, run-review.sh, run-fix.sh)
- Adapter note (.gaslight/ADAPTER.md)

## Recommended next steps
1. Use isolated mode for agent-style tools.
2. Prefer file-first review and micro-chain execution.
3. Use gaslight.sh emit rival-profile to inspect the current rivalry persona.
EOF
  python3 - <<'PY' "$target_dir/.gaslight/INSTALL_REPORT.md" "$target_dir" "$detected"
import sys, pathlib
p=pathlib.Path(sys.argv[1])
text=p.read_text()
text = text.replace('# Gaslight My AI — Install Report\n', f'# Gaslight My AI — Install Report\n\n- Target directory: {sys.argv[2]}\n- Detected workflow: {sys.argv[3]}\n')
p.write_text(text)
PY
}

main() {
  TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd)"
  prepare_repo

  local detected
  detected="$(detect_target "$TARGET_DIR")"

  say "[gaslight] target dir: $TARGET_DIR"
  say "[gaslight] detected workflow: $detected"
  bash "$INSTALL_DIR/gaslight.sh" install "$detected" "$TARGET_DIR"
  install_adapter_notes "$TARGET_DIR" "$detected"
  write_install_report "$TARGET_DIR" "$detected"

  say "[gaslight] done"
  case "$detected" in
    claude-code)
      say "[gaslight] ambient install applied via CLAUDE.md"
      ;;
    codex)
      say "[gaslight] codex-compatible files installed in .gaslight/"
      ;;
    cursor|windsurf|cline|gemini|generic)
      say "[gaslight] workflow files and adapter note installed in .gaslight/"
      say "[gaslight] use isolated mode and wrapper scripts for best reliability"
      ;;
  esac
}

main "$@"
