---
name: never-edit-generated-code
description: Use when generated code (OpenAPI clients, GraphQL types, protobuf, migrations, etc.) looks wrong — change the source schema or template and regenerate, never hand-edit the output.
---

# Don't hand-edit generated code

Files produced by a code generator (OpenAPI client, GraphQL codegen, protobuf, ORM migrations, etc.) are derived artifacts. Editing them by hand silently desyncs the source of truth.

## Rules

- Identify generated dirs/files (common signals: `generated/`, `__generated__/`, top-of-file "DO NOT EDIT" banner, `*.gen.ts`, `*_pb2.py`).
- To change generated output: change the schema, codegen config, or template, then re-run the generator.
- If you must work around a generator bug, do it in a wrapper module that imports the generated code — never inside it.
- Migrations are a special case: generate via the migration tool, don't hand-edit the migration body except for data backfills the tool can't express.
