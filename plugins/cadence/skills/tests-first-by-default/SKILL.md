---
name: tests-first-by-default
description: Use when adding new behavior or fixing a bug — write the failing test first, watch it fail for the right reason, then write the minimal code to pass.
---

# Tests first by default

For any new behavior, change to behavior, or bug fix, write the test before the implementation. If you didn't watch the test fail, you don't know what it actually proves.

## The cycle

1. **Red.** Write one focused test that names the new behavior. Run it. It must fail — and fail for the right reason (the feature is missing), not because of a typo or import error. If it passes immediately, you're testing existing behavior; rewrite it.
2. **Green.** Write the smallest code that makes it pass. No "while I'm here" features, no speculative options the test doesn't exercise.
3. **Refactor.** Tidy without changing behavior. Tests stay green.

Red and green outputs are the library evidence bundle for `verify-with-runtime` (`test_name`, `red_output`, `green_output`).

## Bug fixes

A bug fix without a test that reproduces the bug isn't a fix — it's a guess. Write the failing test first, verify it reproduces the bug, then fix. Now you also have a regression test the next session can rely on.

## When test-first genuinely doesn't fit

- Throwaway prototypes whose code you'll delete.
- Generated / scaffolded code.
- Pure config or copy edits with no behavior to assert.

If you catch yourself reasoning that "this case is special" on real production code, you're rationalizing. Default is test-first.

## What a useful test looks like

- One behavior per test; descriptive name.
- Exercises real code paths, not mocks of the thing under test.
- Asserts a user-visible outcome, not an implementation detail.
- Fails clearly when the behavior regresses — a test that always passes proves nothing (see `investigate-before-fixing`).
