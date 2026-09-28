# 🍞 Bakery Sales, Customer & Inventory Analytics

## 📌 Project Overview

An end-to-end **Data Analytics and Business Intelligence project** built to analyze bakery sales, customers, promotions, inventory, profitability, and waste.

The project follows a complete analytical workflow:

**Python → SQL → DAX → Power BI → Business Insights → Recommendations**

Rather than using Power BI only for visualization, the project starts with data preparation and exploratory analysis, moves into database-level validation and business analysis using **PostgreSQL and Microsoft SQL Server**, creates a reusable **DAX semantic layer**, and finally communicates the validated results through Power BI dashboards.

---

## 🎯 Business Objective

The objective is to understand:

* What drives bakery sales and revenue?
* Which categories perform strongly?
* How do quantity sold and profitability relate?
* How do seasonality and festivals affect demand?
* What is the relationship between promotions and business performance?
* How does stock availability relate to sales?
* Where are waste and expiry risks occurring?
* What customer patterns can be identified?
* How can the analysis support better inventory, sales and profitability decisions?

---

# 🔄 End-to-End Analytical Workflow

```text
Raw Dataset
     ↓
┌─────────────────────────────┐
│ 1. Python                   │
│ Cleaning + EDA + Discovery  │
└─────────────────────────────┘
     ↓
┌─────────────────────────────┐
│ 2. SQL                      │
│ Validation + Analysis       │
│ PostgreSQL + SQL Server     │
└─────────────────────────────┘
     ↓
┌─────────────────────────────┐
│ 3. DAX                     │
│ Semantic / Business Layer   │
└─────────────────────────────┘
     ↓
┌─────────────────────────────┐
│ 4. Power BI                 │
│ Dashboard + Storytelling    │
└─────────────────────────────┘
     ↓
┌─────────────────────────────┐
│ 5. Business Insights        │
│ Recommendations             │
└─────────────────────────────┘
```

### Project philosophy

> **Python discovers → SQL validates & explains → DAX models → Power BI communicates → Business Insights guide recommendations.**

---

# 📊 Dataset

The project uses a synthetic bakery business dataset containing:

| Attribute    |             Details |
| ------------ | ------------------: |
| Transactions |              16,569 |
| Customers    |               2,173 |
| Stores       |                   3 |
| Employees    |                  20 |
| Products     |                  35 |
| Categories   |                  10 |
| Time Period  | Jan 2023 – Dec 2024 |
| Columns      |                  41 |

The validated analytical grain is a **transaction/product record per row**.

---

# 1️⃣ Python — Data Preparation & Exploration

## Purpose

Python is used as the **data preparation and analytical discovery layer**.

The objective is to understand the dataset before moving into database-level analysis.

### Main activities

* Dataset inspection
* Structure and schema validation
* Data-type checks
* Missing-value analysis
* Duplicate detection
* Transaction ID validation
* Data cleaning
* Exploratory Data Analysis
* Category-level analysis
* Monthly revenue analysis
* Initial pattern discovery
* Analytical question generation

### Python libraries

```text
Pandas
NumPy
Matplotlib
Seaborn
```

### Example

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv("bakery_sales.csv")

# Inspect structure
print(df.shape)
print(df.columns.tolist())
print(df.info())

# Data quality checks
print(df.isnull().sum())
print("Duplicate rows:", df.duplicated().sum())
print(
    "Duplicate transaction IDs:",
    df["transaction_id"].duplicated().sum()
)

# Category-level analysis
category_summary = (
    df.groupby("category", as_index=False)
      .agg(
          revenue=("total_bill", "sum"),
          quantity_sold=("quantity", "sum"),
          profit=("profit", "sum"),
          waste_cost=("waste_cost", "sum")
      )
      .sort_values("revenue", ascending=False)
)

print(category_summary)

# Monthly revenue
df["transaction_date"] = pd.to_datetime(
    df["transaction_date"]
)

df["year_month"] = (
    df["transaction_date"]
    .dt.to_period("M")
    .astype(str)
)

monthly_revenue = (
    df.groupby("year_month", as_index=False)["total_bill"]
      .sum()
)

print(monthly_revenue)
```

### Python's role in the project

Python is intentionally not used as the final reporting layer.

Its role is:

```text
Raw Data
   ↓
Inspection
   ↓
Cleaning
   ↓
EDA
   ↓
Pattern Discovery
   ↓
Business Questions
```

The important findings are then reproduced and validated using SQL.

---

# 2️⃣ SQL — Data Quality, Analysis & Interpretation

SQL is the **analytical foundation** of the project.

The same business dataset was implemented in both:

* PostgreSQL
* Microsoft SQL Server / T-SQL

This demonstrates cross-platform SQL capability and transferable analytical logic.

---

## 🐘 PostgreSQL

PostgreSQL was used for:

* Data management
* Data cleaning
* Data-quality validation
* Transformation
* Analytical SQL
* Business analysis

Database:

```text
bakerysalespgdb
```

Table:

```text
bakery_sales
```

---

## 🪟 Microsoft SQL Server

SQL Server / T-SQL was used for:

* Data management
* Data validation
* Business analysis
* Advanced SQL
* Reusable analytical logic
* Interpretation of business questions

Database:

```text
bakerysalesdb
```

Table:

```text
bakery_sales
```

---

## SQL Analysis Areas

### Data Quality

* Null checks
* Duplicate checks
* Transaction ID validation
* Date validation
* Expiry-date analysis
* Data consistency checks

### Sales Analysis

* Revenue
* Quantity sold
* Transactions
* Average order value
* Category performance
* Monthly trends
* Peak selling periods

### Advanced SQL

* CTEs
* Joins
* Subqueries
* Window functions
* Ranking
* Aggregations
* Views
* Stored procedures
* Contribution analysis
* Time-based analysis

---

## SQL Business Question Framework

Each analytical problem follows:

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

Example:

```text
Which categories generate the highest revenue?
            ↓
SQL aggregation + ranking
            ↓
Category-level revenue result
            ↓
Interpret the ranking
            ↓
Identify categories requiring attention
```

This makes SQL an analytical reasoning layer rather than simply a query-writing exercise.

---

# 3️⃣ DAX — Semantic & Business Calculation Layer

After SQL validation, DAX is used to create reusable Power BI business measures.

## Core KPIs

```DAX
Total Revenue =
SUM(bakery_sales[total_bill])
```

```DAX
Total Quantity Sold =
SUM(bakery_sales[quantity])
```

```DAX
Total Transactions =
DISTINCTCOUNT(bakery_sales[transaction_id])
```

```DAX
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Transactions]
)
```

```DAX
Average Selling Price =
DIVIDE(
    [Total Revenue],
    [Total Quantity Sold]
)
```

---

## Category Ranking

```DAX
Category Revenue Rank =
RANKX(
    ALL(bakery_sales[category]),
    [Total Revenue],
    ,
    DESC,
    DENSE
)
```

## Category Contribution

```DAX
Category Contribution % =
DIVIDE(
    [Total Revenue],
    CALCULATE(
        [Total Revenue],
        ALL(bakery_sales[category])
    )
)
```

---

## Time Intelligence

The project includes:

* Previous Month Revenue
* MoM Revenue Change
* MoM Revenue %
* Previous Year Revenue
* YoY Revenue Change
* YoY Revenue %
* YTD Revenue

Example:

```DAX
Previous Month Revenue =
CALCULATE(
    [Total Revenue],
    DATEADD(
        DateTable[Date],
        -1,
        MONTH
    )
)
```

```DAX
YoY Revenue % =
DIVIDE(
    [YoY Revenue Change],
    [Previous Year Revenue]
)
```

---

## Dynamic Top-N

The project includes a disconnected Top-N selection table:

```text
5
10
15
```

The user can dynamically change the number of categories displayed in ranking visuals.

---

## Dynamic KPI Selection

The project also includes a dynamic KPI selector for:

```text
Revenue
Quantity
Transactions
AOV
```

This allows the dashboard to change analytical focus without creating unnecessary duplicate visuals.

---

# 4️⃣ Power BI — Visualization & Business Storytelling

Power BI is used as the final **communication and decision-support layer**.

The dashboard is not designed simply as a collection of charts.

Each visual is connected to an analytical question or business decision.

---

# 📊 Final Dashboard Story

The final dashboard direction focuses on:

```text
Availability
      ↓
Sales
      ↓
Profitability
      ↓
Waste
```

## Strategic Slicers

The final dashboard uses:

* Season
* Gender
* Festival
* Promotion Type

These provide business-oriented segmentation rather than relying only on generic date filters.

---

## Core KPIs

The final dashboard emphasizes:

* Stock Availability
* Units Sold
* Profit
* Waste Cost

This allows the user to move from operational availability to commercial performance and finally to profitability and waste.

---

# 🧩 Power BI Data Model

```text
                 DateTable
                    │
                    │ 1 : *
                    ↓
              bakery_sales
                    │
        ┌───────────┼───────────┐
        ↓           ↓           ↓
     Sales       Customer    Operations
     Analysis    Analysis    / Inventory
        │           │           │
        └───────────┼───────────┘
                    ↓
              DAX Measures


TopN Selection ──→ Disconnected Selector

KPI Selection ──→ Disconnected Selector
```

### Core Power BI tables

```text
bakery_sales
DateTable
TopN Selection
KPI Selection
```

Relationship:

```text
DateTable[Date]
       1
       ↓
bakery_sales[transaction_date]
       *
```

---

# 5️⃣ Business Insights & Recommendations

The final stage converts validated analytical findings into business actions.

The project uses the following framework:

```text
Finding
   ↓
Evidence
   ↓
Interpretation
   ↓
Business Impact
   ↓
Recommendation
   ↓
KPI to Monitor
```

## Analytical Areas

### 🥐 Sales & Category Performance

Identify high-performing and low-performing categories using:

* Revenue
* Units sold
* Profit
* Contribution %

### 🎉 Seasonal & Festival Demand

Analyze demand patterns across:

* Seasons
* Festivals
* Time periods

Use historical patterns to support production and inventory planning.

### 📢 Promotion Performance

Compare promotional and non-promotional performance using:

* Revenue
* Units sold
* Profit
* Promotion type

Promotions should be evaluated based on measured business impact rather than revenue alone.

### 📦 Inventory Availability

Use stock availability and sales patterns to identify:

* High-demand periods
* Potential stock shortages
* Availability issues

### 🗑️ Waste & Expiry Risk

Analyze:

* Unsold units
* Waste cost
* Expiry risk
* Production
* Sales

This can help identify areas where production or replenishment may need adjustment.

### 💰 Profitability

Revenue alone does not determine business performance.

The project evaluates:

```text
Revenue
+
Units Sold
+
Profit
+
Waste Cost
```

This helps identify situations such as high sales volume but comparatively weaker profitability.

### 👥 Customer Patterns

Customer attributes such as:

* Customer segment
* Gender
* Loyalty membership
* Rating

can be analyzed descriptively to identify patterns.

The analysis does not assume that demographic attributes cause customer behavior.

---

# 🧱 Data Structure

Main fields include:

```text
transaction_id
transaction_date
transaction_time
customer_id
customer_age
customer_gender
product
category
quantity
unit_price
discount_percentage
discount_amount
selling_price
total_bill
payment_method
weather
temperature
season
day_of_week
weekend
festival
store_id
employee_id
shelf_life_days
manufacturing_date
expiry_date
stock_available
units_produced
units_sold
unsold_units
expiry_risk
promotion_applied
promotion_type
promotion_score
customer_rating
customer_segment
loyalty_member
profit
waste_cost
recommended_product
recommended_discount
```

---

# 🛠️ Technology Stack

| Layer            | Technology         | Purpose                           |
| ---------------- | ------------------ | --------------------------------- |
| Data Preparation | Python             | Cleaning & EDA                    |
| Analysis         | PostgreSQL         | Data management & analytical SQL  |
| Analysis         | SQL Server / T-SQL | Advanced SQL & business analysis  |
| Semantic Layer   | DAX                | Business calculations             |
| Visualization    | Power BI           | Interactive dashboards            |
| Documentation    | Notion             | Project reasoning & documentation |
| Portfolio        | GitHub             | Code & project presentation       |
| File Management  | SharePoint         | Datasets & project assets         |

---

# 📁 Recommended Repository Structure

```text
Bakery-Sales-Customer-Inventory-Analytics/
│
├── README.md
│
├── data/
│   └── README.md
│
├── python/
│   ├── 01_data_cleaning_eda.ipynb
│   └── README.md
│
├── sql/
│   │
│   ├── postgresql/
│   │   ├── 01_data_quality.sql
│   │   ├── 02_sales_analysis.sql
│   │   ├── 03_customer_analysis.sql
│   │   ├── 04_product_analysis.sql
│   │   └── 05_advanced_analysis.sql
│   │
│   └── sql_server/
│       ├── 01_data_quality.sql
│       ├── 02_sales_analysis.sql
│       ├── 03_customer_analysis.sql
│       ├── 04_product_analysis.sql
│       └── 05_advanced_analysis.sql
│
├── dax/
│   └── measures.md
│
├── powerbi/
│   ├── screenshots/
│   └── README.md
│
├── insights/
│   ├── business_insights.md
│   └── recommendations.md
│
└── docs/
    ├── data_dictionary.md
    ├── data_structure.md
    └── project_workflow.md
```

---

# 🔍 Data Quality & Validation

The project includes validation at multiple stages.

### Python

```text
Missing values
Duplicate rows
Duplicate transaction IDs
Data types
Basic consistency
```

### SQL

```text
Null validation
Duplicate validation
Date validation
Expiry validation
Business-rule checks
Cross-checking analytical results
```

### Power BI

Major dashboard metrics are intended to be reconciled against SQL results.

Examples:

```text
Total Revenue
Total Quantity Sold
Total Transactions
AOV
Category Revenue
Monthly Revenue
Profit
Waste Cost
```

---

# 🔁 Cross-Platform SQL Approach

One of the key features of this project is implementing analytical logic across both:

```text
PostgreSQL
     +
Microsoft SQL Server
```

The purpose is not simply to duplicate queries.

It demonstrates that the underlying business logic can be transferred across database environments while accounting for differences in SQL syntax and functions.

---

# 💼 Interview Explanation

> **“I built an end-to-end bakery analytics project where I first used Python for data preparation, quality checks and exploratory analysis. I then implemented the dataset in PostgreSQL and Microsoft SQL Server for data validation, business analysis and advanced SQL. I converted the validated analytical logic into reusable DAX measures and then built Power BI dashboards to communicate the results. The final dashboard connects availability, sales, profitability and waste, and the project concludes with evidence-based business insights and recommendations.”**

---

# ⭐ What This Project Demonstrates

### Technical Skills

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* PostgreSQL
* Microsoft SQL Server
* T-SQL
* Advanced SQL
* DAX
* Power BI
* Data modelling
* Data validation
* Data quality
* Business intelligence

### Analytical Skills

* Exploratory Data Analysis
* Business-question-driven analysis
* Data interpretation
* KPI development
* Trend analysis
* Ranking
* Contribution analysis
* Time intelligence
* Profitability analysis
* Inventory analysis
* Waste analysis
* Business recommendations

### Professional Skills

* Analytical storytelling
* Requirement-to-insight thinking
* Cross-platform SQL
* Documentation
* Data-quality mindset
* Business-oriented dashboard design

---

# 🚀 Final Project Architecture

```text
                    RAW DATA
                       │
                       ▼
              ┌────────────────┐
              │    PYTHON      │
              │ Cleaning + EDA │
              └────────────────┘
                       │
                       ▼
              ┌────────────────┐
              │      SQL       │
              │ PostgreSQL +   │
              │ SQL Server     │
              │ Analysis +     │
              │ Interpretation │
              └────────────────┘
                       │
                       ▼
              ┌────────────────┐
              │      DAX       │
              │ Semantic Layer │
              └────────────────┘
                       │
                       ▼
              ┌────────────────┐
              │   POWER BI     │
              │ Visualization  │
              │ & Storytelling │
              └────────────────┘
                       │
                       ▼
              ┌────────────────┐
              │    INSIGHTS    │
              │ & RECOMMEND.   │
              └────────────────┘
```

---

# 📌 Portfolio Positioning

This project is designed to demonstrate that **Power BI is the final presentation layer of an analytical workflow, not the entire workflow itself**.

The core approach is:

```text
Business Question
       ↓
Python Exploration
       ↓
SQL Analysis
       ↓
SQL Interpretation
       ↓
DAX Calculation
       ↓
Power BI Visualization
       ↓
Business Insight
       ↓
Recommendation
```

The project therefore demonstrates an end-to-end **Data Analyst / BI Analyst workflow** combining technical analysis with business interpretation.

---

## 👤 Author

**Hanraj Hari Krishna**

**Data Analyst | Data Management | Data Quality & Governance | SQL | Power BI | Advanced Excel**

* LinkedIn: linkedin.com/in/hari-krishna-178397145
* GitHub: github.com/harikrishna-analytics
* Email: [hanrajharikrishna@gmail.com](mailto:hanrajharikrishna@gmail.com)

---

## 📌 Project Status

**Core analytical project completed.**

Completed:

* ✅ Python data preparation & EDA
* ✅ PostgreSQL implementation
* ✅ SQL Server / T-SQL implementation
* ✅ Data-quality validation
* ✅ Business-question-driven SQL analysis
* ✅ Advanced SQL
* ✅ DAX semantic layer
* ✅ Power BI dashboard construction
* ✅ Strategic slicers and KPIs
* ✅ End-to-end analytical architecture

Final portfolio activities:

* ⏳ SQL ↔ Power BI reconciliation evidence
* ⏳ Final validated numeric business insights
* ⏳ Evidence-based recommendation table
* ⏳ GitHub SQL organization
* ⏳ Dashboard screenshots
* ⏳ Final repository packaging

---

> **Python discovers. SQL validates. DAX models. Power BI communicates. Business insights drive action.**
