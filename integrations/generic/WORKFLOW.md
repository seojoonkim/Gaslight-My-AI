# Generic Gaslight Workflow

Use this when your coding assistant does not support automatic workspace rule injection.

## Core idea
Treat Gaslight My AI as a role protocol, not a Claude-specific hack.

### Roles
- Planner
- Implementer
- Reviewer
- Fixer

## Manual / copy-paste workflow
1. Give `prompts/roles/planner.md` before planning
2. Give `prompts/roles/implementer.md` before coding
3. Give `prompts/roles/reviewer.md` before review
4. Give `prompts/roles/fixer.md` before remediation

## Semi-automatic workflow
If your tool supports workspace rules, custom instructions, or project memory:
- inject planner/implementer/reviewer/fixer role prompts into that file
- keep the roles persistent for the project

## Fully automatic workflow
If your tool supports an always-loaded instruction file:
- install the relevant integration from `integrations/`
- ensure the tool auto-loads project rules

## Rival framing
You do not need a real second model.
The same model can perform all roles if each phase is framed as adversarial to the previous/next phase.
