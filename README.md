# 🍞 XYZ Foods — Sales & Operations Analysis

> An end-to-end data analysis project using Python, SQL and Power BI on 2 years of daily bakery sales data.

---

## 📌 Project Overview

This project analyses 2 years of daily sales and operations data (Jan 2022 – Dec 2023) from XYZ Foods, a bakery business based in India — manufacturing Cookies, Bread and Rusk.

The goal was to move beyond manual Excel tracking and build a full data pipeline — from raw data to interactive dashboard — uncovering actionable business insights along the way.

---

## 🎯 Business Questions Answered

- Which product generates the most revenue and profit?
- What seasonal demand patterns exist across the year?
- Which months and days of the week perform best?
- Where is wastage highest — and what does it cost the business?
- How did revenue and profit grow from 2022 to 2023?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Python (Pandas, Matplotlib, Seaborn) | Data cleaning, EDA, visualisations |
| Microsoft SQL Server | Data storage, business queries, stored procedures |
| Power BI (DAX) | Interactive 4-page dashboard |
| Microsoft Excel | Source data & manual tracking reference |
| Google Colab | Python notebook environment |

---

## 📁 Repository Structure

```
Food-Manufacturing-Unit-Sales-Analysis/
│
├── XYZ_Foods_sales_data.csv        # 2-year daily sales dataset (1,875 rows)
│
├── XYZ Foods Analysis.ipynb        # Full EDA notebook (11 steps, 6 charts)
│
├── XYZ_Foods_SQL_Analysis.sql      # 10 business questions + stored procedure
│
├── XYZFoodsDashboard.pbix        # 4-page interactive Power BI dashboard
│
└── README.md
```

---

## 📊 Dataset Overview

| Detail | Value |
|---|---|
| Total rows | 1,875 |
| Date range | Jan 2022 — Dec 2023 |
| Products | Cookies, Bread, Rusk |
| Working days | Mon – Sat (Sundays closed) |

**Columns:**

| Column | Description |
|---|---|
| Date, Month, Year, Quarter, Day_of_Week | Time dimensions |
| Product | Cookies / Bread / Rusk |
| Units_Produced | Daily production volume |
| Units_Sold | Actual units sold |
| Wastage_Units | Unsold or damaged units |
| Raw_Material_Cost_INR | Production cost in ₹ |
| Revenue_INR | Sales revenue in ₹ |
| Profit_INR | Revenue minus cost |
| Profit_Margin_Pct | Profit as % of revenue |

---

## 🐍 Python Analysis (Google Colab)

**File:** `XYZ_Foods_Analysis.ipynb`

The notebook covers 11 steps:

1. Import libraries
2. Load dataset
3. Data overview & quality check
4. Business KPIs summary
5. Monthly revenue vs profit trend
6. Product performance comparison
7. Seasonal demand analysis
8. Day of week performance
9. Wastage analysis by product
10. Year on year comparison
11. Key insights summary

**Charts produced:**

- Monthly revenue & profit trend line chart
- Product revenue, profit & margin bar charts
- Seasonal demand column chart with annotations
- Day of week revenue vs wastage dual-axis chart
- Wastage rate bar chart + pie chart by product
- Year on year revenue comparison

**To run:**
1. Open [Google Colab](https://colab.research.google.com)
2. Upload `XYZ_Foods_Analysis.ipynb`
3. Upload `XYZ_Foods_sales_data.csv` to the Files panel
4. Runtime → Run all

---

## 🗄️ SQL Analysis (MS SQL Server)

**File:** `XYZ_Foods_SQL_Analysis.sql`

10 business questions answered with SQL:

| # | Business Question |
|---|---|
| Q1 | Total revenue, profit and cost by year |
| Q2 | Which product generates the most revenue and profit? |
| Q3 | Top 5 best performing months |
| Q4 | Top 5 worst performing months |
| Q5 | Which day of the week has the highest average revenue? |
| Q6 | Wastage rate and estimated cost of waste per product |
| Q7 | Quarter by quarter revenue comparison |
| Q8 | Year on year revenue growth by product |
| Q9 | Top 10 single best sales days |
| Q10 | Rolling 30-day average revenue trend (window function) |
| Q11 | Stored procedure: `GetMonthlyReport` for any month/year |

**To run:**
1. Open SQL Server Management Studio (SSMS)
2. Run Step 1 to create the database and table
3. Right-click `XYZFoods` → Tasks → Import Flat File → select the CSV
4. Run each query section individually

---

## 📈 Power BI Dashboard

**File:** 'XYZ_Foods_Dashboard.pbix'

4-page interactive dashboard:

| Page | Content |
|---|---|
| 1. Executive Summary | 5 KPI cards, monthly trend line, revenue by product |
| 2. Product Deep Dive | Column chart, donut charts, full metrics table |
| 3. Seasonal & Time Analysis | 2022 vs 2023 comparison, seasonal patterns, day of week |
| 4. Wastage & Operations | Wastage rate, production vs wastage combo, operational KPIs |

**DAX Measures built:**
- Total Revenue, Total Profit, Total Cost
- Avg Profit Margin %, Wastage Rate %
- Total Units Sold, Total Units Produced, Total Wastage Units
- Revenue 2022, Revenue 2023, YoY Revenue Growth %

**Dynamic slicers:** Year | Product | Quarter (synced across all pages)

---

## 💡 Key Insights

- **November–January** is the peak revenue season driven by festivals and winter demand
- **May–June** shows a consistent summer dip in sales across all products
- **Saturdays** generate the highest average daily revenue across both years
- **Bread** delivers the highest revenue per unit despite lower production volumes
- Wastage rates remain between **9–11%** across all products — indicating room for production optimisation
- Overall revenue grew **year on year from 2022 to 2023**

---

## 👤 Author

**Satjot Singh Bhatia**
Aspiring Data & AI Analyst | 7 Years Running a Business, Now Solving It with Data

- 🔗 [LinkedIn](https://www.linkedin.com/in/satjot-singh-bhatia)
- 📧 satjot3@gmail.com

---

## 📝 Notes

- Dataset is based on business operations.
- All monetary values are in Indian Rupees (₹)
- Sundays are excluded from the dataset as the bakery was closed
