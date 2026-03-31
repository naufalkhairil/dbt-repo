# ecommerce_order

A dbt project for transforming ecommerce order data.

## Overview

This project processes ecommerce data including customers, orders, order items, payments, and products. It follows a two-layer architecture:

- **Staging**: Raw data transformation and cleaning
- **Datamart**: Business-ready aggregated models

## Prerequisites

- dbt installed
- PostgreSQL database configured
- Source CSV files in `datasets/` directory

## Project Structure

```
ecommerce_order/
├── datasets/      # Source CSV files
├── models/
│   ├── staging/   # Staging models
│   └── datamart/  # Datamart models
├── seeds/         # Static seed data
├── tests/         # Data tests
├── macros/        # Reusable macros
└── analyses/      # SQL analyses
```

## Usage

### Configure Database Connections

Before running models, configure the `stg` and `mart` targets in your `~/.dbt/profiles.yml`:

```yaml
ecommerce_order:
  target: stg
  outputs:
    stg:
      type: postgres
      host: localhost
      port: 5432
      user: your_username
      password: your_password
      dbname: staging_db
      schema: public
    mart:
      type: postgres
      host: localhost
      port: 5432
      user: your_username
      password: your_password
      dbname: mart_db
      schema: public
```

### Run staging models

```bash
make run-stg
# or
dbt run --target stg --select staging
```

### Run datamart models

```bash
make run-mart
# or
dbt run --target mart --select datamart
```

### Build all models

```bash
make build-all
# or
dbt build --target stg --select staging
dbt build --target mart --select datamart
```

## Targets

| Target | Description |
|--------|-------------|
| `stg`  | Staging environment for raw data transformation |
| `mart` | Production environment for business-ready models |

## Model Materialization

- **Staging models**: Materialized as tables
- **Datamart models**: Materialized as tables
