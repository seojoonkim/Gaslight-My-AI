# Gaslight My AI — Gemini Integration

Gemini-family tools benefit from explicit rival-workflow framing plus strong output contracts.

## Recommended flow
- Planning and review show the clearest lift.
- Use isolated mode to suppress context drift.
- Prefer file-first review and artifact-first stage handoff.

## Commands
- `gaslight.sh context --stage planning --model gemini --mode isolated`
- `gaslight.sh context --stage review --model gemini --mode isolated`
- `gaslight.sh emit rival-profile`
