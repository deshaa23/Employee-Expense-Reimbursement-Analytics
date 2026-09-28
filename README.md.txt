# Employee Expense & Reimbursement Analytics Dashboard

An interactive Power BI dashboard for analyzing employee expenses, reimbursement performance, departmental spending, and pending claims.

## 📊 Project Overview

This project transforms raw employee expense data into an interactive business intelligence dashboard.

The system uses PostgreSQL and SQL for data storage and cleaning, followed by Power BI, Power Query, and DAX for analysis and visualization.

## 🎯 Objectives

- Analyze total employee expenditure
- Identify high-spending departments
- Analyze expenses by category
- Track monthly spending trends
- Monitor pending reimbursements
- Analyze reimbursement processing time
- Provide interactive filtering for business users

## 🛠️ Tech Stack

- PostgreSQL
- SQL
- Power BI
- DAX
- Power Query
- CSV
- Excel

## 🔄 Data Pipeline

Raw Expense Data  
↓  
PostgreSQL  
↓  
SQL Data Cleaning  
↓  
Relational Data Model  
↓  
Power BI / Power Query  
↓  
DAX Measures  
↓  
Interactive Dashboard  
↓  
Business Insights

## 📈 Dashboard Features

### KPI Metrics

- Total Expense
- Total Claims
- Average Claim
- Pending Amount

### Analysis

- Expense by Department
- Expense by Category
- Monthly Expense Trend
- Average Reimbursement Days by Department
- Pending Claims by Department
- Claim Status Distribution

### Interactive Filters

- Department
- Expense Category
- Claim Status
- Claim Date

## 💡 Key Insights

- Engineering recorded approximately ₹4.87M in total expenses.
- Travel was the largest expense category with approximately ₹6.86M in expenses.
- Pending claims represented approximately ₹2.07M in outstanding reimbursement amounts.

## 🧮 DAX Measures

```DAX
Total Expense =
SUM('public expense_claims'[amount])

Total Claims =
COUNTROWS('public expense_claims')

Average Claim =
AVERAGE('public expense_claims'[amount])

Pending Amount =
CALCULATE(
    [Total Expense],
    'public expense_claims'[status] = "Pending"
)

Pending Claims =
CALCULATE(
    [Total Claims],
    'public expense_claims'[status] = "Pending"
)

Avg Reimbursement Days =
CALCULATE(
    AVERAGE('public expense_claims'[reimbursement_days]),
    'public expense_claims'[status] = "Paid",
    NOT ISBLANK('public expense_claims'[reimbursement_days])
)