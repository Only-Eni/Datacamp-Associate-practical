-- ====================================================================
-- Task 1: Identify missing values in the year_added column
-- ====================================================================
SELECT COUNT(*) AS missing_year
FROM products
WHERE year_added IS NULL;

-- ====================================================================
-- Task 2: Clean categorical/text data, handle non-standard missing 
-- values, and replace numeric missing values with overall medians
-- ====================================================================
WITH medians AS (
    SELECT 
        CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY 
            CASE WHEN weight IS NULL OR LOWER(TRIM(weight)) IN ('-', '', 'missing', 'na', 'n/a') THEN NULL 
            ELSE CAST(TRIM(REPLACE(LOWER(weight), 'grams', '')) AS NUMERIC) END
        ) AS NUMERIC) AS median_weight,
        
        CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY 
            CASE WHEN price IS NULL OR LOWER(TRIM(CAST(price AS TEXT))) IN ('-', '', 'missing', 'na', 'n/a') THEN NULL 
            ELSE CAST(price AS NUMERIC) END
        ) AS NUMERIC) AS median_price
    FROM products
)
SELECT 
    product_id,
    
    CASE 
        WHEN product_type IS NULL OR LOWER(TRIM(product_type)) IN ('-', '', 'missing', 'na', 'n/a') THEN 'Unknown' 
        ELSE TRIM(INITCAP(product_type)) 
    END AS product_type,
    
    CASE 
        WHEN brand IS NULL OR LOWER(TRIM(brand)) IN ('-', '', 'missing', 'na', 'n/a') THEN 'Unknown' 
        ELSE TRIM(brand) 
    END AS brand,
    
    ROUND(COALESCE(
        CASE 
            WHEN weight IS NULL OR LOWER(TRIM(weight)) IN ('-', '', 'missing', 'na', 'n/a') THEN NULL 
            ELSE CAST(TRIM(REPLACE(LOWER(weight), 'grams', '')) AS NUMERIC) 
        END, 
        m.median_weight
    ), 2) AS weight,
    
    ROUND(COALESCE(
        CASE 
            WHEN price IS NULL OR LOWER(TRIM(CAST(price AS TEXT))) IN ('-', '', 'missing', 'na', 'n/a') THEN NULL 
            ELSE CAST(price AS NUMERIC) 
        END, 
        m.median_price
    ), 2) AS price,
    
    COALESCE(average_units_sold, 0) AS average_units_sold,
    
    COALESCE(year_added, 2022) AS year_added,
    
    CASE 
        WHEN stock_location IS NULL OR LOWER(TRIM(stock_location)) IN ('-', '', 'missing', 'na', 'n/a') THEN 'Unknown' 
        ELSE TRIM(UPPER(stock_location)) 
    END AS stock_location

FROM products
CROSS JOIN medians m;

-- ====================================================================
-- Task 3: Aggregate numeric and categorical variables by groups
-- ====================================================================
SELECT 
    product_type,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY product_type;

-- ====================================================================
-- Task 4: Extract data based on specific conditions
-- ====================================================================
SELECT 
    product_id, 
    price, 
    average_units_sold
FROM products
WHERE LOWER(TRIM(product_type)) IN ('meat', 'dairy')
  AND average_units_sold > 10;
