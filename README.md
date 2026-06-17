# DBDevOps Samples 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Liquibase](https://img.shields.io/badge/Liquibase-2962FF?logo=liquibase&logoColor=white)](https://www.liquibase.com/)
[![Flyway](https://img.shields.io/badge/Flyway-CC0200?logo=flyway&logoColor=white)](https://flywaydb.org/)
[![Harness DB DevOps](https://img.shields.io/badge/Harness-DB%20DevOps-00ADE4?logo=harness&logoColor=white)](https://developer.harness.io/docs/database-devops/use-database-devops/get-started/onboarding-guide/)

Sample database migration scripts for [Harness DB DevOps](https://developer.harness.io/docs/database-devops/use-database-devops/get-started/onboarding-guide/), covering Liquibase and Flyway workflows across multiple databases and cloud providers.

## Structure

```
├── flyway/               
│   └── postgres/         # Flyway migrations for PostgreSQL
│       └── migrations/   # Versioned (V) and undo (U) SQL scripts
├── liquibase/
│   ├── databases/        # PostgreSQL and MongoDB changelogs
│   ├── aws-examples/     # Master changelog with versioned compatible with RDS-Postgres.
│   └── google-cloud/     # Multi-database changelog compatible with BigQuery, Cloud SQL for PostgreSQL, Cloud Spanner (Google SQL), and Cloud Spanner (PostgreSQL dialect)
└── policies/             # OPA/Rego policies for Harness DB DevOps governance
```

## What's Included

| Sample | Description |
|---|---|
| Flyway on PostgreSQL | Versioned (`V`) and undo (`U`) migrations with a `flyway.toml` environment config |
| Liquibase on PostgreSQL | Multi-version `product` table evolution: table creation, context-scoped seed data (`dev`/`staging`/`qa` vs `production-na`/`production-apj`), schema alterations, backfills, unique constraints, indexes, and rollback blocks |
| Liquibase on MongoDB | Native `mongosh` changesets using the Liquibase MongoDB extension: collection creation with JSON Schema validation, indexes, `insertMany`/`updateMany`/`deleteMany`, aggregation pipelines, external `mongoFile` script execution, and `runCommand` for OSS compatibility |
| Liquibase on AWS | Master changelog composing multiple versioned include files for `users`, `products`, `orders`, and indexes |
| Liquibase on Google Cloud | Single changelog targeting BigQuery, Cloud SQL for PostgreSQL, Cloud Spanner (Google SQL), and Cloud Spanner (PostgreSQL dialect) via context filters and per-database type properties |

## Policies

The [`policies/`](policies/) directory contains [OPA](https://www.openpolicyagent.org/) Rego policies for Harness DB DevOps pipeline governance. These are evaluated against SQL statements at pipeline execution time.

| Policy file | What it enforces |
|---|---|
| `deny_drop_operations.regex` | Blocks `DROP TABLE`, `DROP DATABASE`, `DROP SCHEMA`, and `DROP COLUMN` across SQL Server, MySQL, PostgreSQL, and Oracle |
| `drop_table.regex` | Simpler blanket deny on any statement containing `DROP` |
| `prevent_large_transactions.regex` | Rejects changesets with more than 50 SQL statements |
| `prevent_direct_system_table_access.regex` | Blocks `SELECT` against system catalogs (`sys.*`, `information_schema.*`, `pg_catalog.*`, etc.) |
| `primary_key_naming_convention.regex` | Requires primary key constraints to follow the `pk_<table_name>` naming convention |
| `table_name_limit.regex` | Rejects table names exceeding 10 characters |
| `schema_name_limit.regex` | Rejects schema names exceeding 30 characters |
| `database_name_limit.regex` | Rejects database names exceeding 30 characters |

> The policy files themselves contain no inline comments — this table is the reference.

## Additional Resources

- [Harness DB DevOps Onboarding Guide](https://developer.harness.io/docs/database-devops/use-database-devops/get-started/onboarding-guide/)
- [Terraform Harness DB DevOps Onboarding](https://github.com/harness-community/terraform-harness-database-devops-onboarding) — Terraform modules to provision Harness DB DevOps resources
- [Liquibase MongoDB Extension](https://github.com/harness-community/liquibase-mongodb-extension) — Harness-maintained extension enabling native `mongosh` changesets in Liquibase
