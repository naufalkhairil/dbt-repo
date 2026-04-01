.PHONY: run-silver run-gold

# Run staging models with silver target
run-silver:
	dbt run --profiles-dir /home/pal/ICS/github/dbt-repo/projects/ecommerce_order --target silver --select silver

# Run gold models with gold target
run-gold:
	dbt run --profiles-dir /home/pal/ICS/github/dbt-repo/projects/ecommerce_order  --target gold --select gold

# Run gold models with duckdb gold target
run-gold-duckdb:
	dbt run --profiles-dir /home/pal/ICS/github/dbt-repo/projects/ecommerce_order  --target gold_duckdb__order --select gold