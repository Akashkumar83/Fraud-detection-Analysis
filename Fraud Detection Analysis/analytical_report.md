# 🛡️ Analytical Report: Transactional Fraud Detection Analysis
**Project:** Month 1 Portfolio Project — Financial Fraud Detection  
**Prepared For:** Risk & Compliance Team, Product Management, Engineering Stakeholders  
**Status:** Completed & Validated  
**Dataset:** 284,807 European Cardholder Transactions  

---

## 1. Executive Summary
Financial fraud is an existential threat to electronic payment ecosystems, creating severe financial losses and eroding consumer confidence. The core analytical challenge is detecting rare fraudulent transactions (**0.17%** of all activity) without falsely declining legitimate purchases.

This project delivers:
1. **SQL Ingestion & Business Extraction:** Automated queries capturing transaction trends, hourly patterns, and fraud concentrations.
2. **Exploratory Data Analysis:** Key findings uncovering time-of-day vulnerabilities and fraudulent spend tactics.
3. **Machine Learning Models:** A transparent baseline (**Logistic Regression**) and an optimized production challenger (**Random Forest Classifier**) that achieves an **84.7% fraud detection rate** while reducing false alarms by **97.7%**.
4. **Interactive Dashboard & Business Recommendations:** A browser-based executive dashboard with a live transaction risk simulator, plus pre-aggregated datasets for Tableau and Power BI.

---

## 2. Key Business Metrics at a Glance

| Metric | Business Value | Operational Context |
| :--- | :---: | :--- |
| **Total Transactions Analyzed** | **284,807** | Two days of transaction activity |
| **Total Financial Volume** | **$25,162,590.01** | Total ecosystem spend |
| **Total Fraud Incidents** | **492** | 0.1727% of total volume |
| **Total Stolen Amount** | **$60,127.97** | Average fraud: $122.21 |
| **Peak Fraud Risk Hours** | **02:00 – 04:00 AM** | Fraud rate reaches 1.71% (10x baseline) |
| **Best Model Recall** | **84.7%** | Intercepts 83 out of 98 fraud attempts in test |
| **False Positive Reduction** | **97.7% reduction** | Only 34 false flags vs. 1,501 in linear model |

---

## 3. Phase 1 & 2: Exploratory Data Findings (EDA)

### 3.1 The "Needle in a Haystack" Reality (Class Imbalance)
- **Legitimate Transactions:** 284,315 (99.827%)
- **Fraudulent Transactions:** 492 (0.173%)
- **Why Accuracy Fails:** If a fraud detection rule blocks nothing, it registers **99.83% accuracy** but incurs **100% loss**. Models must be measured on **Recall (fraud captured)** and **Precision (low false alarms)**.

### 3.2 Transaction Amount Strategy: Fraudsters Stay Under the Radar
- **Legitimate Transactions:**
  - Mean: **$88.29** | Max: **$25,691.16**
- **Fraudulent Transactions:**
  - Mean: **$122.21** | Max: **$2,125.87**
- **Insight:** Fraudulent actors rarely execute mega-transactions because large amounts immediately trip hard limit security controls. Instead, they make multiple mid-sized transactions ($50 to $300) to blend in with everyday grocery and electronics purchases.

### 3.3 Temporal Patterns: The Midnight Vulnerability
- Transaction volume drops significantly between 01:00 AM and 06:00 AM as legitimate users sleep.
- In contrast, automated bot attacks and cross-border fraud run around the clock.
- **Hour 2 (2:00 AM)** experiences a fraud rate of **1.713%**—nearly **10 times higher** than the average daily rate of 0.17%.

---

## 4. Phase 3: Machine Learning Model Benchmarking

We evaluated two distinct modeling approaches on a stratified 20% holdout test set (56,962 transactions, containing 98 actual frauds):

| Evaluation Metric | Baseline Model: Logistic Regression | Challenger Model: Random Forest | Recommended Champion |
| :--- | :---: | :---: | :---: |
| **Fraud Recall (% Caught)** | **90.82%** (89 / 98) | **84.69%** (83 / 98) | Logistic Regression (+6.1%) |
| **Precision (% True Alarms)** | **5.60%** | **70.94%** | 🏆 **Random Forest (+65.3%)** |
| **False Positives (Unhappy Customers)** | **1,501** | **34** | 🏆 **Random Forest (97.7% Fewer)** |
| **F1-Score (Harmonic Balance)** | 0.1055 | **0.7721** | 🏆 **Random Forest** |
| **ROC-AUC Score** | 0.9717 | **0.9741** | 🏆 **Random Forest** |

### Why Random Forest is the Clear Production Winner:
1. **Customer Experience:** Under Logistic Regression, 1,501 genuine customers had their cards blocked on a single day. This creates massive call center backlog and churn. Random Forest blocked only 34 genuine users while catching 83 frauds.
2. **Operational Cost Savings:** The cost of reviewing 1,501 false alerts in a risk ops queue far outweighs the slight 6% recall difference.
3. **Primary Predictive Features:** The top fraud predictors are PCA components `V14` (21.3% importance), `V10` (11.6%), `V4` (11.3%), and `V17` (9.4%), reflecting behavioral anomalies in terminal interactions and transaction sequencing.

---

## 5. Phase 4: Strategic Recommendations for Fraud Operations

### 1. Implement Tiered Decisioning Architecture
- **Low Risk (Score < 0.30):** Automatic approval with sub-second latency.
- **Medium Risk (Score 0.30 – 0.70):** Trigger non-intrusive step-up authentication (SMS OTP or Push Notification).
- **High Risk (Score > 0.70):** Immediate transaction hold and automated fraud queue alert.

### 2. Time-Based Heuristic Rule
- Between **01:00 AM and 05:00 AM**, lower the automated step-up authentication threshold by 25% to neutralize the overnight fraud spike.

### 3. Integration with Business Intelligence
- The pre-aggregated summary dataset has been exported to `outputs/tableau_powerbi_dataset.csv`.
- Risk managers can monitor hourly fraud spikes and regional channel spend directly inside Power BI or Tableau.

---

## 6. How to Run and Verify
- **Interactive Web Dashboard:** Double-click `dashboard.html` in your browser.
- **Jupyter Notebook:** Open `fraud_detection_analysis.ipynb`.
- **SQL Data Pipeline:** Run `python sql_pipeline.py`.
- **Complete Python Retraining:** Run `python run_analysis.py`.
