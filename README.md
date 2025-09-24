# Data-Cleaning-Project
This project cleans and prepares a layoffs dataset using SQL by removing duplicates, standardizing text, handling null/blank values, and dropping unnecessary columns. The result is a consistent, high-quality dataset ready for reporting, analysis, and visualization.
[README Data Cleaning.md](https://github.com/user-attachments/files/22514396/README.Data.Cleaning.md)
# 🗃️ Data Cleaning Project (SQL)

## 📌 Project Overview
This project demonstrates data cleaning techniques using SQL on a layoffs dataset.
The goal is to transform raw, messy data into a clean and usable form for reporting and analysis.

### Key objectives of this project:
- Remove duplicate records.
- Standardize text data (e.g., fixing inconsistent company/industry names).
- Handle null and blank values.
- Convert data types (especially dates).
- Drop unnecessary columns.

By the end of this process, we have a cleaned table (`layoffs_staging2`) ready for further analysis and reporting.

---

## 🗂️ Files in this Repository
- **Data Cleaning project.sql** → The SQL script containing all steps of the data cleaning process.

---

## ⚙️ Tools & Technologies
- Microsoft SQL Server (T-SQL)
- Database: `layoffs`

---

## 🔑 Steps in Data Cleaning

### 1. Remove Duplicates
- Used CTE (Common Table Expression) with `ROW_NUMBER()` to identify duplicate rows based on company, industry, location, date, etc.
- Deleted rows where `row_num > 1`.

### 2. Standardize Data
- Trimmed extra spaces in company names.
- Corrected inconsistent industry names (e.g., `"crypto currency"` → `"crypto"`).
- Fixed country names with trailing spaces or punctuation (e.g., `"United States."` → `"United States"`).

### 3. Handle Null & Blank Values
- Removed rows with invalid or blank values (e.g., when `industry` contained dates instead of industry names).
- Ensured fields like `date` are in valid formats.

### 4. Convert Dates
- Used `TRY_CONVERT(DATE, [date], 101)` to change date strings into proper `DATE` format.

### 5. Drop Unnecessary Columns
- Removed helper columns like `row_num` after data cleaning was complete.
  

## 🎯 Key Learnings
- How to use **CTEs and window functions** for duplicate removal.
- Practical text standardization techniques with `TRIM()` and `UPDATE`.
- Best practices for handling missing or invalid data.
- Converting and validating date fields in SQL.
- Structuring a data cleaning workflow in SQL.
