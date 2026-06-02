---
name: imports-at-top
description: Use when writing import statements — keep them at the top of the file; do not drop imports inside functions or class methods to work around typing or ordering issues.
---

# Imports stay at the top

Place all `import` / `require` / `from ... import` statements at the top of the file.

## Allowed exceptions

- Lazy-loaded UI components (e.g. dynamic imports for code-splitting).
- A documented circular-dependency workaround — leave a one-line comment explaining why.
- Background-task framework workflow registrations that must be imported lazily — comment why.

## Don't

- Don't drop an `import` inside a function body or class method to "fix" a typing or ordering issue.
- Don't use `require()` mid-file in TS/JS as a workaround for ESM/CJS interop — fix the config instead.

If you feel an inline import is the only option, stop and ask before writing it.
