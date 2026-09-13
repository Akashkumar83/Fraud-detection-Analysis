"""
PostgreSQL Data Ingestion Script for Fraud Detection Project
Loads 'project.csv' into PostgreSQL (fraud_db) in chunks.

Usage:
1. Install dependencies: pip install psycopg2-binary sqlalchemy
2. Edit DB_PASSWORD below with your PostgreSQL master password.
3. Run: python postgres_loader.py
"""

import os
import sys
import time
import pandas as pd

# ==========================================
# ⚙️ CONFIGURATION - Update your details here
# ==========================================
DB_USER = "postgres"
DB_PASSWORD = "your_postgres_password"  # <-- Replace with your pgAdmin password
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "fraud_db"
CSV_PATH = "project.csv"

def check_dependencies():
    try:
        from sqlalchemy import create_engine
        import psycopg2
        return create_engine
    except ImportError:
        print("[ERROR] Required libraries are missing.")
        print("Please run: pip install psycopg2-binary sqlalchemy")
        sys.exit(1)

def load_to_postgres():
    create_engine = check_dependencies()
    
    connection_url = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    print(f"[*] Connecting to PostgreSQL at {DB_HOST}:{DB_PORT}/{DB_NAME}...")
    
    try:
        engine = create_engine(connection_url)
        with engine.connect() as conn:
            print("[OK] Successfully connected to PostgreSQL!")
    except Exception as e:
        print(f"[ERROR] Could not connect to PostgreSQL: {e}")
        print("Tip: Ensure PostgreSQL service is running and your DB_PASSWORD is correct.")
        sys.exit(1)

    print(f"[*] Reading '{CSV_PATH}' and inserting into PostgreSQL table 'transactions'...")
    start_time = time.time()
    
    chunksize = 50000
    total_rows = 0
    for i, chunk in enumerate(pd.read_csv(CSV_PATH, chunksize=chunksize)):
        if_exists = 'replace' if i == 0 else 'append'
        chunk.to_sql('transactions', engine, if_exists=if_exists, index=False)
        total_rows += len(chunk)
        print(f"    -> Ingested batch {i+1} ({total_rows:,} rows total)...")
        
    duration = time.time() - start_time
    print(f"\n[SUCCESS] Loaded {total_rows:,} rows into PostgreSQL in {duration:.2f} seconds!")
    print("You can now view this table inside pgAdmin 4 and query it in Jupyter Notebook.")

if __name__ == "__main__":
    load_to_postgres()
