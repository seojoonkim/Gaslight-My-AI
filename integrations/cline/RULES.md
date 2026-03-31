# Gaslight My AI — Cline Integration

Cline works best when the task envelope is narrow.

## Best practices
- Use `--mode isolated` prompts from Gaslight My AI.
- Pass one artifact at a time.
- Do not encourage workspace exploration during benchmarking or prompt experiments.

## Suggested commands
- `gaslight.sh context --stage planning --model <model> --mode isolated`
- `gaslight.sh review path/to/file`
- `gaslight.sh micro-chain review "artifact here"`
