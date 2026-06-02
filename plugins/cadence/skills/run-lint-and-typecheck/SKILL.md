---
name: run-lint-and-typecheck
description: Use after editing source code — run the project's linter and type checker and fix anything you introduced before declaring done.
---

# Run lint and typecheck after changes

Before declaring a change done:

1. Run the project's formatter/linter (e.g. `eslint`, `biome`, `ruff`, etc.).
2. Run the project's type checker (e.g. `tsc`, `tsgo`, `pyright`, `mypy`).
3. Fix everything you introduced. Filter `node_modules` / `.venv` noise from output.
4. Don't suppress an error with `// eslint-disable-next-line`, `# type: ignore`, `any`, or `as` to silence the tool — fix the underlying issue or ask.

If the project ships a single "check" script, prefer it. If it doesn't, ask which commands to run rather than guessing.
