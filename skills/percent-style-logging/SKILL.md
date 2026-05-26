---
name: percent-style-logging
description: Use when writing Python log calls — pass format args as separate parameters (`logger.info("...%s", value)`); do not pre-format with f-strings, which breaks log aggregator grouping.
---

# Python logging: `%s` style, not f-strings

Use the logger's lazy-formatting interface so log aggregators (Sentry, Datadog, etc.) can group identical log statements together regardless of the dynamic values inside them.

## Do

```python
logger.info("Loaded user %s with %d projects", user_id, project_count)
logger.exception("Failed to ingest file %s", file_id)
```

## Don't

```python
logger.info(f"Loaded user {user_id} with {project_count} projects")   # breaks Sentry grouping
logger.error(f"Failed: {exc}")                                         # use logger.exception
```

## Why

- f-string messages produce a unique string per call → every event becomes its own group.
- The lazy form skips formatting when the log level is filtered out (perf win at scale).
- `logger.exception(...)` automatically attaches the active traceback — prefer it over manually formatting `{exc}`.
