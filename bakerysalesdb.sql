use bakerysalesdb;

====================================================================================
--------------------- Seasonal Sales Analysis -------------------
=============================================================================


select * from [dbo].[bakery_sales]

SELECT
    season,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY season
ORDER BY total_revenue DESC;



=========================================================================================================================

              -----------------  Festival Sales Analysis ---------------------------

              ===============================================================================

              SELECT
    festival,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY festival
ORDER BY total_revenue DESC;


====================================================================================================================================


        ------------------ Weather Sales Analysis --------------------------------------

        -===================================================================================


        SELECT
    weather,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY weather
ORDER BY total_revenue DESC;


=================================================================================================================================

              ------ Peak Hours Sales Analysis -----------------------

              ==================================================================================================

              SELECT
    Datename(HOUR , transaction_time)  AS sales_hour,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY datename(HOUR , transaction_time)
ORDER BY total_revenue DESC;

=====================================================================================================================================================

                 -------------------- Monthly Sales Analysis -----------------------------------------

                 =====================================================================================================


                 SELECT
    DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
    store_id,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY
    DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1),
    store_id
ORDER BY
    sales_month,
    store_id;



    ============================================================================================================================================
                       
                       -----------------  Store Performance Summary ------------------------------

                       ======================================================================================

                       SELECT
    store_id,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value,
    ROUND(
        SUM(total_bill) / SUM(SUM(total_bill)) OVER () * 100,
        2
    ) AS revenue_contribution_pct
FROM bakery_sales
GROUP BY store_id
ORDER BY total_revenue DESC;


==========================================================================================================================================================


                                 ------------------------------- Payment Method Performance -----------------------------------


================================================================================================================================================================

SELECT
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS transaction_share_pct
FROM bakery_sales
GROUP BY payment_method
ORDER BY total_revenue DESC;


-============================================================================================================================================


                     
                  ------------------------------ Discount & Promotion Performance------------

                  ===========================================================================================


                  SELECT
    promotion_type,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value,
    ROUND(AVG(discount_percentage), 2) AS avg_discount_pct
FROM bakery_sales
GROUP BY promotion_type
ORDER BY total_revenue DESC;

========================================================================================================================================================================================

                     
                                   --- Discount Impact — Discounted vs Non-Discounted Sales------------------------------------------
                  -============================================================================================================


                  SELECT
    CASE
        WHEN discount_percentage > 0 THEN 'Discounted'
        ELSE 'No Discount'
    END AS discount_status,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value,
    ROUND(AVG(discount_percentage), 2) AS avg_discount_pct
FROM bakery_sales
GROUP BY
    CASE
        WHEN discount_percentage > 0 THEN 'Discounted'
        ELSE 'No Discount'
    END
ORDER BY total_revenue DESC;

=========================================================================================================================================================================

                         ------------------------------    ---------------------   Inventory Status Performance--------------

                         =====================================================================================================================================


                         SELECT
    inventory_status,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY inventory_status
ORDER BY total_revenue DESC;


SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bakery_sales'
ORDER BY ORDINAL_POSITION;


EXEC sp_help 'bakery_sales';


SELECT
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bakery_sales'
ORDER BY ORDINAL_POSITION;



=============================================================================================================


SELECT
    product_name,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY product_name
ORDER BY total_revenue DESC;


=========================================================================================================================

           ------------------------------------ Quantity vs Revenue Performance-------------------------

           ======================================================================================================================

           SELECT
    quantity,
    COUNT(*) AS transaction_count,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY quantity
ORDER BY quantity;


========================================================================================================

             ----------------- Revenue Distribution By  Transaction  Value  Band ----------------------------


             ====================================================================================================

             SELECT
    CASE
        WHEN total_bill < 100 THEN '<100'
        WHEN total_bill < 250 THEN '100-249'
        WHEN total_bill < 500 THEN '250-499'
        WHEN total_bill < 1000 THEN '500-999'
        ELSE '1000+'
    END AS transaction_value_band,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill), 2) AS total_revenue,
    ROUND(AVG(total_bill), 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY
    CASE
        WHEN total_bill < 100 THEN '<100'
        WHEN total_bill < 250 THEN '100-249'
        WHEN total_bill < 500 THEN '250-499'
        WHEN total_bill < 1000 THEN '500-999'
        ELSE '1000+'
    END
ORDER BY MIN(total_bill);


======================================================================================================================================================

 ------------------------------------- Running Revenue By Month ----------------------------------------------------------------

 ==================================================================================================================================================


 WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY sales_month;


====================================================================================================================================================
                           

                           -------------------------- Monthly Revenue Growth % -----------------------------------

                           ========================================================================================================================


                           WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
),
monthly_with_previous AS (
    SELECT
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (ORDER BY sales_month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS mom_growth_pct
FROM monthly_with_previous
ORDER BY sales_month;



======================================================================================================================================================

           ------------------------------- 🔥 Advanced SQL #1 — Rank Monthly Revenue ---------------------


 WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    RANK() OVER (
        ORDER BY monthly_revenue DESC
    ) AS revenue_rank
FROM monthly_sales
ORDER BY revenue_rank;


======================================================================================================================================================


     -----------------------------------  🔥 Advanced SQL #2 — Revenue Contribution %------------------------------------------


     ===============================================================================================================================================


     WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        monthly_revenue * 100.0
        / SUM(monthly_revenue) OVER (),
        2
    ) AS revenue_contribution_pct
FROM monthly_sales
ORDER BY sales_month;


===========================================================================================================================



-------------🔥 Advanced SQL #3 — Top 3 Revenue Months-----------------
======================================================================

WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY
        DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
),
ranked_months AS (
    SELECT
        sales_month,
        monthly_revenue,
        DENSE_RANK() OVER (
            ORDER BY monthly_revenue DESC
        ) AS revenue_rank
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    revenue_rank
FROM ranked_months
WHERE revenue_rank <= 3
ORDER BY revenue_rank, sales_month;



=========================================================================























































