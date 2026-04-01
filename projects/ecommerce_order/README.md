# ecommerce_order

A dbt project for transforming ecommerce order data from PostgreSQL to DuckDB.

## Overview

This project processes ecommerce data including customers, orders, order items, payments, and products. It follows a three-layer architecture:

- **Silver**: Raw data transformation and cleaning (PostgreSQL)
- **Gold**: Business-ready aggregated models (DuckDB)

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  PostgreSQL │ ──► │    dbt      │ ──► │   DuckDB    │
│   (Silver)  │     │  (Transform)│     │    (Gold)   │
└─────────────┘     └─────────────┘     └─────────────┘
```

## Prerequisites

- Python 3.10+
- dbt-core and dbt-duckdb installed
- PostgreSQL database with silver layer tables
- DuckDB file configured

## Project Structure

```
ecommerce_order/
├── datasets/          # Source CSV files
├── models/
│   ├── silver/        # Silver models (PostgreSQL)
│   └── gold/          # Gold models (DuckDB)
├── seeds/             # Static seed data
├── tests/             # Data tests
├── macros/            # Reusable macros
├── analyses/          # SQL analyses
├── profiles.yml       # dbt profiles (project-specific)
└── Makefile           # Common commands
```

## Setup

### 1. Install dependencies

```bash
cd projects/ecommerce_order
python -m venv ecommerce_venv
source ecommerce_venv/bin/activate
pip install -r requirements.txt
```

### 2. Configure Docker services

Ensure PostgreSQL and DuckDB containers are running on the same network:

```bash
# Create network
docker network create duckdb_project

# Start PostgreSQL
docker compose -f ../../postgres/docker-compose.yml up -d

# Start DuckDB
docker compose -f ../../duckdb/docker-compose.yml up -d
```

### 3. Configure profiles

The project uses a local `profiles.yml` with the following targets:

| Target | Type | Description |
|--------|------|-------------|
| `bronze` | PostgreSQL | Raw data layer |
| `silver` | PostgreSQL | Cleaned/transformed data |
| `gold` | PostgreSQL | Business-ready models (Gold Example 1) |
| `gold_duckdb__order` | DuckDB | Gold models in DuckDB with PostgreSQL attachment (Gold Example 2) |

## Usage

### Run silver models (PostgreSQL)

```bash
make run-silver
# or
dbt run --profiles-dir . --target silver --select silver
```

### Run gold models (DuckDB)

```bash
make run-gold-duckdb
# or
dbt run --profiles-dir . --target gold_duckdb__order --select gold
```

### Run gold models (PostgreSQL)

```bash
make run-gold
# or
dbt run --profiles-dir . --target gold --select gold
```

## DuckDB Integration

The `gold_duckdb__order` target configures DuckDB to attach to PostgreSQL:

```yaml
gold_duckdb__order:
  type: duckdb
  path: /home/pal/ICS/github/dbt-repo/databases/duckdb/workspace/db/ecommerce/order.duckdb
  schema: main
  attach:
    - path: postgresql://postgres:postgres@localhost:5432/postgres
      alias: postgres
      type: postgres
```

This allows gold models to query silver tables directly:

```sql
SELECT * FROM {{ source("silver", "order_details") }}
-- Resolves to: postgres.silver.order_details
```

## Verify Results

### Check tables in DuckDB

```bash
docker exec -it duckdb-duckdb-1 duckdb /workspace/db/ecommerce/order.duckdb -c "SHOW TABLES;"
```

### Query gold models

```bash
docker exec -it duckdb-duckdb-1 duckdb /workspace/db/ecommerce/order.duckdb -c "SELECT * FROM main.daily_orders;"
```

## Targets Summary

| Target | Database | Schema | Use Case |
|--------|----------|--------|----------|
| `bronze` | PostgreSQL | public | Raw data ingestion |
| `silver` | PostgreSQL | silver | Cleaned transformations |
| `gold` | PostgreSQL | gold | PostgreSQL-based gold models |
| `gold_duckdb__order` | DuckDB | main | DuckDB-based gold models with PostgreSQL source |

## Model Materialization

- **Silver models**: Materialized as tables
- **Gold models**: Materialized as tables
