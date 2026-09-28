# 🍞 Bakery Sales, Customer & Inventory Analytics

### End-to-End Data Analytics & Business Intelligence Project

An end-to-end analytics project covering **data preparation, SQL analysis, DAX modelling, Power BI dashboards, and business insights**.

**Python → SQL → DAX → Power BI → Business Insights**

---

## 🎯 Business Objective

Analyze bakery **sales, customers, promotions, inventory, profitability, and waste** to identify actionable business patterns.

Key questions include:

* Which categories drive revenue and sales?
* How do seasonality, festivals, and promotions affect performance?
* Where are inventory and waste risks occurring?
* How do sales and profitability relate?
* What customer patterns can be identified?

---

## 📊 Dataset

| Metric       |             Details |
| ------------ | ------------------: |
| Transactions |              16,569 |
| Customers    |               2,173 |
| Products     |                  35 |
| Categories   |                  10 |
| Stores       |                   3 |
| Employees    |                  20 |
| Period       | Jan 2023 – Dec 2024 |
| Columns      |                  41 |

**Data grain:** One transaction/product record per row.

---

# 🔄 Analytical Workflow

```text
Raw Dataset
     ↓
🐍 Python
Cleaning + EDA + Discovery
     ↓
🗄️ SQL
PostgreSQL + SQL Server
Validation + Analysis
     ↓
📐 DAX
Semantic / Business Layer
     ↓
📊 Power BI
Dashboard + Storytelling
     ↓
💡 Business Insights
Recommendations
```

> **Python discovers → SQL validates & explains → DAX models → Power BI communicates → Insights guide decisions.**

---

# 1️⃣ Python — Data Preparation & EDA

**Purpose:** Data inspection, cleaning, quality checks and exploratory analysis.

### Key Activities

* Dataset and schema inspection
* Missing-value and duplicate checks
* Transaction validation
* Data cleaning
* Category analysis
* Monthly trend analysis
* Pattern discovery

### Libraries

`Pandas` · `NumPy` · `Matplotlib` · `Seaborn`

---

# 2️⃣ SQL — Analysis & Interpretation

Implemented using **PostgreSQL and Microsoft SQL Server / T-SQL**.

### PostgreSQL

* Data management
* Cleaning & validation
* Analytical SQL
* Transformations

### SQL Server / T-SQL

* Business analysis
* Advanced SQL
* Ranking & contribution analysis
* Reusable views / procedures
* Time-based analysis

### SQL Concepts

`CTEs` · `Joins` · `Subqueries` · `Window Functions` · `Aggregations` · `Ranking` · `Views` · `Stored Procedures`

### Analytical Framework

```text
Business Question
       ↓
SQL Query
       ↓
Result
       ↓
Interpretation
       ↓
Business Implication
```

---

# 3️⃣ DAX — Semantic Layer

Reusable Power BI measures for:

* Revenue
* Quantity Sold
* Transactions
* AOV
* Category Ranking
* Contribution %
* MoM / YoY / YTD
* Dynamic Top-N
* Dynamic KPI Selection

Example:

```DAX
Total Revenue =
SUM(bakery_sales[total_bill])

Total Transactions =
DISTINCTCOUNT(bakery_sales[transaction_id])

Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Transactions]
)
```

---

# 4️⃣ Power BI — Dashboard

### Dashboard Story

**Availability → Sales → Profitability → Waste**

### Strategic Slicers

`Season` · `Gender` · `Festival` · `Promotion Type`

### Core KPIs

`Stock Availability` · `Units Sold` · `Profit` · `Waste Cost`

### Data Model

```text
                 DateTable
                    │
                    │ 1 : *
                    ↓
              bakery_sales
                    │
        ┌───────────┼───────────┐
        ↓           ↓           ↓
      Sales      Customer    Operations
     Analysis    Analysis    / Inventory
                    │
                    ↓
               DAX Measures
```

---

# 5️⃣ 💡 Business Insights

Analysis focuses on:

* Sales & category performance
* Seasonal and festival demand
* Promotion performance
* Inventory availability
* Waste & expiry risk
* Profitability
* Customer patterns

### Recommendation Framework

```text
Finding → Evidence → Interpretation
        → Business Impact → Recommendation → KPI
```

---

# 🛠️ Technology Stack

| Area              | Tools                         |
| ----------------- | ----------------------------- |
| Data Preparation  | Python, Pandas, NumPy         |
| Database Analysis | PostgreSQL, SQL Server, T-SQL |
| Analytics         | Advanced SQL                  |
| Semantic Layer    | DAX                           |
| Visualization     | Power BI                      |
| Documentation     | Notion                        |
| Project Assets    | SharePoint                    |
| Portfolio         | GitHub                        |

---

# 📁 Repository Structure

```text
Bakery-Sales-Customer-Inventory-Analytics/
│
├── README.md
├── python/
│   └── 01_data_cleaning_eda.ipynb
├── sql/
│   ├── postgresql/
│   └── sql_server/
├── dax/
│   └── measures.md
├── powerbi/
│   └── screenshots/
├── insights/
│   ├── business_insights.md
│   └── recommendations.md
└── docs/
    ├── data_dictionary.md
    ├── data_structure.md
    └── project_workflow.md
```

---

# ⭐ Skills Demonstrated

**Python · SQL · PostgreSQL · SQL Server · T-SQL · Advanced SQL · DAX · Power BI · Data Quality · Data Validation · Data Modelling · Business Analysis · Data Storytelling**

---

# 💼 Interview Summary

> Built an end-to-end bakery analytics solution using **Python for exploration, PostgreSQL and SQL Server for analytical SQL, DAX for reusable business measures, and Power BI for interactive reporting**, translating validated analysis into insights around sales, inventory, profitability and waste.

---

# 👤 About Me

### **Hanraj Hari Krishna**

**Data Analyst | Data Management | Data Quality & Governance | SQL | Power BI | Advanced Excel**

📍 Hyderabad, India

📧 **[hanrajharikrishna@gmail.com](mailto:hanrajharikrishna@gmail.com)**

🔗 **LinkedIn:** [linkedin.com/in/hari-krishna-178397145](https://www.linkedin.com/in/hari-krishna-178397145)

💻 **GitHub:** [github.com/harikrishna-analytics](https://github.com/harikrishna-analytics)

---

## 📌 Project Status

**Core analytical project completed ✅**

* ✅ Python Data Preparation & EDA
* ✅ PostgreSQL Analysis
* ✅ SQL Server / T-SQL Analysis
* ✅ Data Quality Validation
* ✅ Advanced SQL
* ✅ DAX Semantic Layer
* ✅ Power BI Dashboard
* ✅ Business Analysis Framework
* 🔄 Final portfolio packaging

---

### 🚀 Project Philosophy

> **Python discovers. SQL validates. DAX models. Power BI communicates. Business insights drive action.**
