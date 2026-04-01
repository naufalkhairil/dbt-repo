#!/usr/bin/env python3
"""Ingest all CSV files from Ecommerce Order Dataset/train into PostgreSQL."""

import sys
import pandas as pd
from pathlib import Path
from sqlalchemy import create_engine

# PostgreSQL connection
DB_URL = "postgresql://postgres:postgres@localhost:5432/postgres"

# CSV directory
if len(sys.argv) == 1:
    raise Exception("\n\nMissing csv directory. \n\nUsage: python ingest_csv_to_postgres.py <CSV_DIR>\n")

CSV_DIR = Path(sys.argv[1])

# Create database engine
engine = create_engine(DB_URL)

# Ingest each CSV file
for csv_file in CSV_DIR.glob("*.csv"):
    table_name = csv_file.stem  # e.g., "df_Customers" from "df_Customers.csv"
    
    print(f"Loading {csv_file.name} into {table_name}...")
    
    # Read CSV and write to PostgreSQL
    df = pd.read_csv(csv_file)
    df.to_sql(table_name, engine, if_exists="replace", index=False)
    
    print(f"  ✓ Loaded {len(df)} rows")

print("\nIngestion complete!")
