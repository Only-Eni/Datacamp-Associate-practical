# Grocery Store Sales Data Analysis (SQL)

## Project Overview
This project involves cleaning and analyzing a dataset of grocery store sales for a chain called FoodYum. The objective was to ensure data integrity by handling missing or non-standard values across various data types, and to extract insights regarding product pricing and sales volume to ensure a broad range of customer affordability.

## Data Dictionary
The dataset `products` contains the following columns:
* `product_id`: Unique identifier (Nominal).
* `product_type`: Category of the product (Nominal).
* `brand`: Brand of the product (Nominal).
* `weight`: Weight of the product in grams (Continuous).
* `price`: Price in US dollars (Continuous).
* `average_units_sold`: Average units sold per month (Discrete).
* `year_added`: Year first added to stock (Nominal).
* `stock_location`: Originating warehouse location (Nominal).

## Tasks Executed
1.  **Missing Value Identification:** Quantified missing data in critical historical columns (`year_added`).
2.  **Robust Data Cleaning:** Standardized text data by stripping suffixes (e.g., "grams"), fixing inconsistent casing, and replacing hidden missing values (like dashes or text markers) with calculated medians, default values, or 'Unknown' flags.
3.  **Data Aggregation:** Calculated the minimum and maximum price ranges across different product categories.
4.  **Conditional Extraction:** Filtered specific high-performing product categories based on sales thresholds for targeted team review.

## Tech Stack
* **PostgreSQL** (CTEs, Window Functions `PERCENTILE_CONT`, String Manipulation `TRIM`, `REPLACE`, `INITCAP`, Conditional Logic `CASE WHEN`, `COALESCE`, `NULLIF`).
