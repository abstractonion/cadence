---
name: no-hacking-central-infra
description: Use when a backend test or eval fails — fix it at the edges (test, fixture, feature code); do not modify central settings, base classes, middleware, or shared fixtures to make it pass.
---

# Don't hack central infra to make tests pass

When a test, eval, or local run fails, fix it at the edges — in the test, the fixture, the feature code under test — not by reaching into shared settings, base classes, middleware, or framework-level configuration.

## Why

Central infra changes have blast radius far beyond the failing test. A toggle that makes the failure go away usually masks the real cause, breaks other tests subtly, or leaks into production behavior. The signal you'd have gotten from the failure is lost.

## What counts as "central infra"

- Settings modules / environment configuration (`settings.py`, `config/*`, `.env.test`).
- Base classes / mixins that every model, view, or test inherits from.
- Middleware, auth backends, request/response hooks.
- Shared conftest fixtures used by many test files.
- ORM defaults, signal handlers, cache backends, queue plumbing.

## Do instead

- Fix the test or its local fixture if the failure is test-specific.
- Fix the feature code if the test is correct and the code is wrong.
- Add a narrowly-scoped override (e.g. `@override_settings` for one test) rather than mutating the global default.

## When central infra really is the root cause

Say so explicitly. Propose the change as its own focused commit with a justification — not bundled into the test/feature work. The user should agree the change belongs at the infra level before it lands.
