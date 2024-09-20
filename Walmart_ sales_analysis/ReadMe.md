# Walmart Sales Data Analysis

## About
This project analyzes Walmart sales data to understand top-performing branches, products, sales trends, and customer behavior. The objective is to provide insights to optimize sales strategies. The dataset was sourced from the Kaggle Walmart Sales Forecasting Competition.

## Objectives
- Identify factors influencing sales across branches.
- Understand product performance and customer behavior.
- Optimize sales strategies based on insights.

## Dataset
- **Source:** Kaggle Walmart Sales Forecasting Competition.
- **Contents:** Sales data from 3 Walmart branches (Mandalay, Yangon, Naypyitaw) with 17 columns and 1000 rows.
  
### Key Columns
| Column                 | Description                          |
|------------------------|--------------------------------------|
| `invoice_id`            | Sales invoice identifier             |
| `branch`                | Branch where sales occurred          |
| `city`                  | Branch location                      |
| `customer_type`         | Type of customer                     |
| `gender`                | Customer gender                      |
| `product_line`          | Product category                     |
| `unit_price`            | Price per product                    |
| `quantity`              | Quantity sold                        |
| `total`                 | Total purchase cost                  |
| `payment_method`        | Payment method used                  |
| `date`                  | Purchase date                        |
| `time`                  | Purchase time                        |

## Analysis
1. **Product Analysis**: Identify top-performing product lines and areas needing improvement.
2. **Sales Analysis**: Analyze sales trends to evaluate the effectiveness of sales strategies.
3. **Customer Analysis**: Segment customers by purchase trends and profitability.

## Approach
- **Data Wrangling**: Clean and preprocess data, ensuring no NULL values.
- **Feature Engineering**: Create new features like `time_of_day`, `day_name`, and `month_name` to gain deeper insights into sales patterns.
- **Exploratory Data Analysis (EDA)**: Perform EDA to answer key business questions and meet project objectives.

## Conclusion
This project aims to provide actionable insights to optimize Walmart’s sales strategy by understanding customer behavior, sales trends, and product performance.
