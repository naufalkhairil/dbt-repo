.PHONY: run-stg run-mart

# Run staging models with stg target
run-stg:
	dbt run --target stg --select staging

# Run datamart models with mart target
run-mart:
	dbt run --target mart --select datamart

# Build both (if needed)
build-all:
	dbt build --target stg --select staging
	dbt build --target mart --select datamart