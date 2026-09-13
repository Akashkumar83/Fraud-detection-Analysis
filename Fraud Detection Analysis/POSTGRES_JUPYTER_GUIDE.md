# 🐘 PostgreSQL (pgAdmin 4) & Jupyter Notebook Architecture

```mermaid
flowchart LR
    subgraph DB ["1. Database Layer (PostgreSQL & pgAdmin 4)"]
        CSV["Raw Dataset<br><b>project.csv</b><br>(284,807 rows)"] -->|Import / Ingest| PG[("PostgreSQL Database<br><b>fraud_db</b><br>Table: transactions")]
        PGA["<b>pgAdmin 4 GUI</b><br>(Query Tool & Indexes)"] --- PG
    end

    subgraph BRIDGE ["2. Connection Bridge"]
        PG -->|SQLAlchemy + psycopg2<br>postgresql://localhost:5432/fraud_db| PY["<b>Python SQL Engine</b><br>pd.read_sql_query()"]
    end

    subgraph ANALYTICS ["3. Data Science & ML Layer"]
        PY --> JUP["<b>Jupyter Notebook</b><br>fraud_detection_analysis.ipynb<br>• SQL Aggregations<br>• Exploratory Data Analysis (EDA)"]
        JUP --> ML["<b>Scikit-Learn ML Models</b><br>• Logistic Regression (Baseline)<br>• Random Forest (Challenger)"]
    end

    subgraph OUTPUTS ["4. Business Reporting & Presentation"]
        ML --> DASH["<b>Interactive Web Dashboard</b><br>dashboard.html<br>(Live Fraud Risk Simulator)"]
        ML --> BI["<b>Tableau & Power BI</b><br>tableau_powerbi_dataset.csv"]
    end

    style DB fill:#0f172a,stroke:#3b82f6,stroke-width:2px,color:#f8fafc
    style BRIDGE fill:#0f172a,stroke:#10b981,stroke-width:2px,color:#f8fafc
    style ANALYTICS fill:#0f172a,stroke:#f59e0b,stroke-width:2px,color:#f8fafc
    style OUTPUTS fill:#0f172a,stroke:#8b5cf6,stroke-width:2px,color:#f8fafc
```

---

### 🔄 How Data Flows:
1. **Store in PostgreSQL:** Ingest `project.csv` into `fraud_db` inside **pgAdmin 4**.
2. **Connect via Python:** Jupyter Notebook connects via `create_engine("postgresql://postgres:password@localhost:5432/fraud_db")`.
3. **Analyze & Train:** Extract queries into Pandas DataFrames, engineer features, and train fraud detection models.
4. **Present to Team:** Present insights through `dashboard.html` and export data for Power BI / Tableau.
