# AGENTS.md

## Repository Scope
These rules apply to `my-awesome-ai`.

## Git Workflow (Mandatory)
- Always start with `git status --short` and `git diff --name-status`.
- Split changes into logical commits by intent:
  - content/domain updates -> `feat(...)`
  - documentation -> `docs(...)`
  - maintenance/release/process -> `chore(...)`
- Never mix unrelated files in one commit.

## Commit Message Style
- Subject format: `#<next_number> <type>(<scope>): <summary>`
- Continue numbering from the latest commit subject.
- Keep subject concise and action-oriented.
- Add 1–3 body bullets only when useful.

## SemVer and Tags
- If `README.md` SemVer changes, create annotated tag on current release commit:
  - `git tag -a vX.Y.Z -m "Release vX.Y.Z"`
- Push both branch and tag:
  - `git push origin <branch>`
  - `git push origin vX.Y.Z`

## Release Automation
- Preferred script: `scripts/release.ps1`
- Run from inside `my-awesome-ai`:
  - `powershell -ExecutionPolicy Bypass -File .\scripts\release.ps1 -Version X.Y.Z`

## AI Execution Prompt (Copy/Paste)
Use this prompt when asking AI to perform release work:

"Analyze git changes in `my-awesome-ai` and do the following:
1) Split changes into logical commits in this repo style: `#N type(scope): summary`.
2) Commit without mixing unrelated files.
3) If SemVer changed in README, create annotated tag `v<version>` and push branch + tag.
4) Print final checks: `git log --oneline -n 5`, `git tag --list`, `git status --short`."
