# 🎤 5-Minute Team Presentation Guide
## Project: Transactional Fraud Detection Analysis
*Designed for presenting to your team, manager, or stakeholders in simple, clear language.*

---

## ⏱️ Quick Summary (The 30-Second Elevator Pitch)
> *"Hi everyone, today I'm presenting our Transactional Fraud Detection Analysis. We analyzed 284,800 transactions representing $25 Million in payment volume. Fraud is very rare—only 0.17% of transactions—which means standard accuracy metrics don't work. We uncovered that fraud spikes by 10x in the early morning hours between 2 AM and 4 AM, and fraudsters strategically keep amounts moderate to avoid basic limit rules. By engineering time and spending features, our Random Forest model successfully catches 85% of fraud attempts while slashing false alarms by 97.7% compared to the baseline, saving the business both customer trust and tens of thousands of dollars in chargeback losses."*

---

## 📽️ Slide-by-Slide Presentation Walkthrough

### Slide 1: The Business Problem
- **Visual to show:** `outputs/class_distribution.png` (or open `dashboard.html`)
- **What to say:**
  > *"Every day, millions of dollars flow through payment cards. Fraud accounts for $60,000 in this dataset, but it is hidden in 284,800 transactions. Notice the extreme imbalance: 99.83% of transactions are legitimate, and only 0.17% are fraudulent. If a system blindly approves everything, it looks '99.8% accurate' on paper—but it costs the company $60,000. That's why our team's objective was to build an intelligent detection model evaluated on Recall and Precision, not naive accuracy."*

### Slide 2: Data Findings & Discovery (EDA)
- **Visual to show:** `outputs/hourly_fraud_pattern.png` and `outputs/amount_distribution.png`
- **What to say:**
  > *"When we analyzed transaction patterns, we made two critical business discoveries:*
  > *1. **The Midnight Spike:** Fraud rate surges from an average of 0.17% up to 1.71% between 2:00 AM and 4:00 AM. While normal users are asleep, automated attacks and cross-border fraudsters strike.*
  > *2. **Discreet Amount Strategy:** The average legitimate transaction is $88, while the average fraud is $122. Fraudsters rarely attempt $10,000 swipes because they know that triggers basic bank limits. They stay under the radar with medium amounts."*

### Slide 3: The Machine Learning Solution
- **Visual to show:** `outputs/confusion_matrix.png` and `outputs/roc_curve.png`
- **What to say:**
  > *"We benchmarked two models on a holdout test set of 57,000 transactions:*
  > * *Our **Baseline Model (Logistic Regression)** caught 91% of frauds, but it generated **1,501 false alarms**—blocking over 1,500 good customers!*
  > * *Our **Challenger Model (Random Forest)** caught **85% of frauds** while reducing false alarms down to **just 34**! That is a **97.7% reduction in false alarms**.*
  > * *This means our risk operations team doesn't drown in false tickets, and legitimate customers experience frictionless payments."*

### Slide 4: Interactive Live Demo
- **Visual to show:** Open `dashboard.html` in browser -> Scroll to **"Live Fraud Risk Simulator"**
- **Action:**
  1. Slide amount to `$150`, set Time to `03:00 AM`, select `High Risk Signals`.
  2. Click **"Check Transaction Risk"**.
  3. Show the team how the risk score calculates in real time and triggers an "IMMEDIATE BLOCK & AGENT REVIEW".
- **What to say:**
  > *"Here in our dashboard, we have built a live simulator. Any transaction can be evaluated in milliseconds against our engineered features and model weights."*

### Slide 5: Next Steps & Business Recommendations
- **What to say:**
  > *"Based on our findings, we recommend 3 clear next steps:*
  > *1. **Staging Rollout:** Deploy the Random Forest model with a tiered decision rule (Auto-Approve, OTP Verification, Hard Decline).*
  > *2. **Overnight Protection:** Lower the OTP threshold between 1:00 AM and 5:00 AM to defend against the early morning spike.*
  > *3. **BI Monitoring:** Connect our pre-aggregated SQL extracts directly into the team's Tableau / Power BI workspace for continuous tracking."*

---

## ❓ Anticipated Questions from Your Team & How to Answer Them

**Q1: "Why did you choose Recall over Accuracy?"**
> **Answer:** *"Because in a 99.8% legitimate dataset, a model that does nothing is 99.8% accurate. Recall tells us what percentage of the actual $60,000 in fraud we successfully caught."*

**Q2: "Why Random Forest instead of Logistic Regression if Logistic Regression had a slightly higher recall (91% vs 85%)?"**
> **Answer:** *"Logistic Regression produced 1,501 false positives in just two days of test data. Blocking 1,500 real customers creates massive churn and operational cost. Random Forest cut false positives down to 34—a 97.7% drop—making it vastly superior for real-world operations."*

**Q3: "Can our team connect this to Power BI or Tableau?"**
> **Answer:** *"Yes! We have already generated `outputs/tableau_powerbi_dataset.csv`, which is pre-aggregated by hour, spend tier, and fraud flag, ready to drag-and-drop into Power BI or Tableau."*
