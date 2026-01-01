#  RetainX – Customer Retention & Churn Analytics Platform

RetainX is a full **end-to-end Customer Retention & Churn Analytics project** designed to replicate how analytics projects are executed in real organizations — from business understanding and data modeling to advanced analytics and executive dashboards.

The project focuses on identifying **churn drivers**, evaluating **customer health**, and quantifying **revenue at risk** using **SQL, Python, Excel, and Power BI**.

---

## 🧠 Business Problem Statement

Customer churn is one of the most critical challenges for subscription-based and service-driven businesses such as **Telecom, SaaS, OTT, and FinTech platforms**.

Losing customers not only impacts revenue but also increases customer acquisition costs and affects long-term growth. Organizations need a consolidated analytical view to proactively identify churn risks and take data-driven retention actions.

### Key business questions addressed:
- Why are customers churning?
- Which customers are at risk of churning?
- How does usage behavior affect churn?
- Which customer segments contribute most to revenue loss?
- Which geographic regions show higher churn patterns?

---

## 🎯 Project Objectives

- Analyze customer behavior to understand churn patterns  
- Segment customers based on usage, tenure, and revenue  
- Identify **high-value customers at risk of churn**  
- Quantify **revenue at risk** due to churn  
- Build an **executive-ready Power BI dashboard** for decision-makers  

---

## 🗂️ Project Structure

## Project Structure

- **01_Project_Documents**
  - Business_Requirement_Document.docx
  - KPIs_and_Business_Questions.docx
  - Scope_and_Objectives.docx

- **02_Data**
  - **raw**
    - telecom_churn.csv
  - **cleaned_python**
    - telecom_cleaned.csv
  - **analytical_sql**
    - retainx_customer_analytics.csv
  - **excel**
    - data_dictionary.xlsx
    - data_profiling.xlsx
    - data_quality_report.xlsx
    - segmentation_scoring.xlsx
    - segmentation_summary.csv

- **03_SQL**
  - 01_create_database_and_tables.sql
  - 02_data_transformation.sql
  - 03_derived_tables.sql
  - 04_business_queries.sql

- **04_Python_EDA**
  - 01_data_understanding.ipynb
  - 02_data_cleaning.ipynb
  - 03_eda_analysis.ipynb
  - **visuals**

- **05_PowerBI_Dashboard**
  - RetainX.pbix
  - **dashboard_screenshots**

- **06_Insights_and_Presentation**

- **07_Final_Deliverables**

- **README.md**





## 🛠️ Tech Stack Used

| Area | Tools |
|----|----|
| Data Source | Kaggle (Public Telecom Dataset) |
| Database | PostgreSQL |
| Data Processing | SQL |
| Analytics & EDA | Python (Pandas, NumPy, Matplotlib, Seaborn) |
| Reporting | Excel |
| Visualization | Power BI |
| Version Control | Git & GitHub |

---

## 📌 Data Source

- **Dataset:** Telecom Customer Churn Dataset  
- **Source:** Kaggle (Public Dataset)  
- **Description:** Customer-level data including demographics, usage behavior, tenure, revenue indicators, and churn status.

The dataset was treated as an **externally sourced dataset** and processed using **enterprise-style data workflows**.

---

## 🧱 Data Architecture (Enterprise Style)

### 1. Raw Layer
- Original dataset ingested into PostgreSQL  
- No transformations applied  

### 2. Transformation Layer
Feature engineering performed using SQL:
- Revenue Segmentation  
- Usage Score  
- Usage Category  
- Tenure Calculation  

### 3. Analytical (Gold) Layer
- Customer segmentation logic applied  
- Business-ready analytical table created  
- Optimized for Power BI consumption  

---

## 🔄 Data Processing Workflow

### SQL (Core Business Logic)
- Database and table creation  
- Feature engineering  
- Customer segmentation  
- Analytical table creation  
- Business KPIs and metrics  

### Python (EDA & Validation)
- Data understanding and profiling  
- Data quality checks  
- Exploratory data analysis  
- Insight generation  
- Export of high-value at-risk customers  

### Excel
- Quick sanity checks  
- Lightweight analysis  
- Stakeholder-friendly views  

### Power BI
- Executive dashboards  
- Interactive filters  
- KPI monitoring and trend analysis  

---

## 📈 Key KPIs Tracked

- Total Customers  
- Total Churned Customers  
- Churn Rate (%)  
- Average Revenue  
- Revenue at Risk  
- High-Value Customers at Risk  
- Churn Rate by:
  - Usage Category  
  - Customer Segment  
  - Tenure  
  - Geography  

---

## 📊 Power BI Dashboard Overview

### Page 1 – Executive Overview
- Overall KPIs  
- Churn Rate by Usage Category  
- Customer Distribution by Segment & Churn  
- Revenue Segment Distribution  

### Page 2 – Customer Segmentation & Behavior
- Total Customers by Segment  
- Churn Rate by Usage Category  
- Churn Rate by Tenure  

### Page 3 – Revenue & High-Value Risk
- Revenue at Risk by Revenue Segment  
- High-Value At-Risk Customers Table  
- Revenue-focused KPIs  

### Page 4 – Geographic Churn Insights
- Churn Rate by State  
- Revenue at Risk by State (Map)  
- State-level churn comparison  

---

## 🧩 Key Insights Generated

- Low-usage customers show significantly higher churn probability  
- Customers with longer tenure are more stable and less likely to churn  
- High-income customers churn less frequently but contribute the highest revenue loss when they do  
- Certain states consistently exhibit higher churn patterns  
- Targeting high-income, low-usage customers can significantly reduce revenue loss  

---

## 💡 Business Recommendations

- Introduce proactive retention strategies for low-usage customers  
- Focus churn-prevention efforts on high-income customer segments  
- Launch regional retention campaigns for high-churn states  
- Improve engagement through usage-based loyalty programs  

---

## 🚀 Why This Project Is Strong

- End-to-end analytics workflow  
- Strong business framing (not just visualizations)  
- SQL, Python, Excel, and Power BI integration  
- Enterprise-style data modeling  
- Executive-level dashboards and insights  

This project closely mirrors how analytics teams operate in real companies.

---

## 🧾 How to Run the Project

1. Clone the repository  
2. Load raw data into PostgreSQL  
3. Execute SQL scripts in sequence  
4. Run Python notebooks for EDA  
5. Open Power BI dashboard and refresh data  

---

## 👤 Author

**Ujjwal Verma**  
Data Analyst | SQL | Python | Power BI | Analytics
