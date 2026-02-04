# sql_project2
from pypandoc import convert_text

readme = """
# 🍽️ Restaurant Orders & Menu SQL Analysis

## 📌 Project Overview
This project is a **hands-on SQL data analysis portfolio project** based on a restaurant order management dataset.  
It simulates real-world **Data Analyst workflows**, including data exploration, table joins, aggregation, and business-focused insights.

The project focuses on understanding:
- Customer ordering behavior
- Revenue patterns
- Popular menu items and categories
- High-value orders

This project is designed to showcase **practical SQL skills** commonly used in analytics roles.

---

## 🎯 Objectives
- Combine order and menu data using SQL JOINs
- Analyze order volume and item counts
- Identify top-spending orders
- Answer business questions using aggregation functions
- Practice CTEs (`WITH AS`), `GROUP BY`, `HAVING`, and ranking logic

---

## 📁 Dataset Description

### 🧾 Tables Used

#### `menu_items`
Contains menu-level information.

| Column | Description |
|------|------------|
| `menu_item_id` | Unique ID for each menu item |
| `item_name` | Name of the dish |
| `category` | Cuisine category (American, Italian, Asian, etc.) |
| `price` | Price of the dish |

#### `order_details`
Contains transactional order data.

| Column | Description |
|------|------------|
| `order_details_id` | Unique row ID |
| `order_id` | Order identifier |
| `order_date` | Date of the order |
| `order_time` | Time of the order |
| `item_id` | Menu item ordered (FK to menu_items) |

---

## 🛠 Tools & Technologies
- **SQL**
- **SQLite**
- **DBeaver**
- Git & GitHub

---

## 🔍 Key Analysis Performed

### 1️⃣ Basic Exploration
- Total number of menu items
- Total number of orders
- Date range of orders
- Total items ordered

### 2️⃣ Table Joins
- Combined `order_details` and `menu_items` using `INNER JOIN`
- Created enriched datasets with item names, categories, and prices

### 3️⃣ Aggregations & Grouping
- Items per order
- Orders with the most items
- Orders with more than a threshold number of items
- Category-wise item counts

### 4️⃣ Advanced SQL Techniques
- Common Table Expressions (CTEs)
- `HAVING` vs `WHERE`
- Ranking logic using `ORDER BY` and `LIMIT`
- Top-N analysis

### 5️⃣ Business Insights
- **Top 5 orders that spent the most money**
- Categories with the highest and lowest number of ordered items
- Identification of high-value customer orders

---

## 📊 Sample Query (Top 5 Highest-Spending Orders)
```sql
WITH order_items AS (
    SELECT
        od.order_id,
        mi.price
    FROM order_details od
    JOIN menu_items mi
      ON od.item_id = mi.menu_item_id
)
SELECT
    order_id,
    SUM(price) AS money_spent
FROM order_items
GROUP BY order_id
ORDER BY money_spent DESC
LIMIT 5;
