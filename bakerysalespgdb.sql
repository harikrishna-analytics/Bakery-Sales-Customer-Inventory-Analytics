SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

CREATE TABLE bakery_sales (
    transaction_id          VARCHAR(50),
    transaction_date        DATE,
    transaction_time        TIME,
    customer_id             VARCHAR(50),
    customer_age            INT,
    customer_gender         VARCHAR(20),
    product                 VARCHAR(100),
    category                VARCHAR(50),
    quantity                INT,
    unit_price              NUMERIC(10,2),
    discount_percentage     NUMERIC(5,2),
    discount_amount         NUMERIC(12,2),
    selling_price           NUMERIC(10,2),
    total_bill              NUMERIC(12,2),
    payment_method          VARCHAR(30),
    weather                 VARCHAR(30),
    temperature             NUMERIC(6,2),
    season                  VARCHAR(20),
    day_of_week             VARCHAR(20),
    weekend                 BOOLEAN,
    festival                VARCHAR(50),
    store_id                VARCHAR(50),
    employee_id             VARCHAR(50),
    shelf_life_days         INT,
    manufacturing_date      DATE,
    expiry_date             DATE,
    stock_available         INT,
    units_produced         INT,
    units_sold              INT,
    unsold_units            INT,
    expiry_risk             VARCHAR(30),
    promotion_applied       BOOLEAN,
    promotion_type          VARCHAR(50),
    promotion_score         NUMERIC(6,2),
    customer_rating         NUMERIC(3,2),
    customer_segment        VARCHAR(30),
    loyalty_member          BOOLEAN,
    profit                  NUMERIC(12,2),
    waste_cost              NUMERIC(12,2),
    recommended_product     VARCHAR(100),
    recommended_discount    NUMERIC(5,2)
);
select * from bakery_sales;



====================================================================================
--------------------- Seasonal Sales Analysis -------------------
=============================================================================


SELECT
    season,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY season
ORDER BY total_revenue DESC;
===================================================================================================

       ----------------Festival Sales Analysis------------------

	   ===============================================================================


	   SELECT
    festival,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY festival
ORDER BY total_revenue DESC;

===============================================================================================

----------------------------- Weather Sales Analysis -----------------------

===================================================================


SELECT
    weather,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY weather
ORDER BY total_revenue DESC;


=====================================================================================

					  ------------- Peak Sales Hours Analysis---------------

					  ==============================================================

SELECT
    EXTRACT(HOUR FROM transaction_time)::int AS sales_hour,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY EXTRACT(HOUR FROM transaction_time)
ORDER BY total_revenue DESC;

=================================================================================================================

           -----------------Monthly Sales by Store-----------------

		   ================================================================================
		   
SELECT
    DATE_TRUNC('month', transaction_date) AS sales_month,
    store_id,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY
    DATE_TRUNC('month', transaction_date),
    store_id
ORDER BY
    sales_month,
    store_id;

=====================================================================================================================
		   
                --------- Store Performance Summary  -------------------

				==================================================================================
SELECT
    store_id,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value,
    ROUND(
        (SUM(total_bill) / SUM(SUM(total_bill)) OVER () * 100)::numeric,
        2
    ) AS revenue_contribution_pct
FROM bakery_sales
GROUP BY store_id
ORDER BY total_revenue DESC;

=======================================================================================================================
			------------- Payment Method Performance ---------------------------
			===========================================================

SELECT
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value,
    ROUND(
        (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ())::numeric,
        2
    ) AS transaction_share_pct
FROM bakery_sales
GROUP BY payment_method
ORDER BY total_revenue DESC;


=======================================================================================================================================

                  ------------------------------ Discount & Promotion Performance------------

				  ============================================================================================

SELECT
    promotion_type,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value,
    ROUND(AVG(discount_percentage)::numeric, 2) AS avg_discount_pct
FROM bakery_sales
GROUP BY promotion_type
ORDER BY total_revenue DESC;

		========================================================================================================

        ----------------------------------- Discount Impact — Discounted vs Non-Discounted Sales ----------------------

		==============================================================================================


SELECT
    CASE
        WHEN discount_percentage > 0 THEN 'Discounted'
        ELSE 'No Discount'
    END AS discount_status,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value,
    ROUND(AVG(discount_percentage)::numeric, 2) AS avg_discount_pct
FROM bakery_sales
GROUP BY
    CASE
        WHEN discount_percentage > 0 THEN 'Discounted'
        ELSE 'No Discount'
    END
ORDER BY total_revenue DESC;


==========================================================================================================


                   ---------------------   Inventory Status Performance--------------

				   ==============================================================================================

SELECT
    inventory_status,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY inventory_status
ORDER BY total_revenue DESC;

=========================================================================================

        -------------------------------- Product Performance Analysis ----------------

		================================================================================================
SELECT
    product_name,
    COUNT(*) AS transaction_count,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY product_name
ORDER BY total_revenue DESC;


     =====================================================================================================
        ------------------------  Quantity vs Revenue Performance ------------------
		==============================================================================================


		SELECT
    quantity,
    COUNT(*) AS transaction_count,
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
FROM bakery_sales
GROUP BY quantity
ORDER BY quantity;

=====================================================================================================================
                --------------- Revenue Distribution by Transaction Value Band--------------

				===================================================================================================

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
    ROUND(SUM(total_bill)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_bill)::numeric, 2) AS avg_transaction_value
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

===========================================================================================================================


     -----------------------  Running Revenue by Month----------------------


	 ====================================================================================




 WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
)
SELECT
    sales_month,
    ROUND(monthly_revenue::numeric, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )::numeric,
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY sales_month;

====================================================================================

=------------------Monthly Revenue Growth — MoM % ------------------------------------

========================================================================================================


WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
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
    ROUND(monthly_revenue::numeric, 2) AS monthly_revenue,
    ROUND(previous_month_revenue::numeric, 2) AS previous_month_revenue,
    ROUND(
        ((monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100)::numeric,
        2
    ) AS mom_growth_pct
FROM monthly_with_previous
ORDER BY sales_month;

============================================================================================================

            ------------- 🔥 Advanced SQL #1 — Rank Monthly Revenue----------------------


WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
)
SELECT
    sales_month,
    ROUND(monthly_revenue::numeric, 2) AS monthly_revenue,
    RANK() OVER (
        ORDER BY monthly_revenue DESC
    ) AS revenue_rank
FROM monthly_sales
ORDER BY revenue_rank;


========================================================================================================


    ----------------------  🔥 Advanced SQL #2 — Revenue Contribution %  -------------------------
	====================================================================================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
)
SELECT
    sales_month,
    ROUND(monthly_revenue::numeric, 2) AS monthly_revenue,
    ROUND(
        (
            monthly_revenue * 100.0
            / SUM(monthly_revenue) OVER ()
        )::numeric,
        2
    ) AS revenue_contribution_pct
FROM monthly_sales
ORDER BY sales_month;

=======================================================================================


     -------------------- Advanced SQL #3 — Top-N analysis using window--------------

	 ====================================================================================

	

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS sales_month,
        SUM(total_bill) AS monthly_revenue
    FROM bakery_sales
    GROUP BY DATE_TRUNC('month', transaction_date)
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
    ROUND(monthly_revenue::numeric, 2) AS monthly_revenue,
    revenue_rank
FROM ranked_months
WHERE revenue_rank <= 3
ORDER BY revenue_rank, sales_month;


	 
===========================================================================




		
				




















