-- q1_monthly_revenue
SELECT
    d.order_year,
    d.order_month,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue
FROM fact_order_items f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.order_year, d.order_month
ORDER BY d.order_year, d.order_month;

-- q2_top_product_categories
SELECT
    p.product_category_name_english,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- q3_payment_type_distribution
SELECT
    dp.payment_type,
    COUNT(*) AS total_items,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.payment_value), 2) AS total_payment_value
FROM fact_order_items f
JOIN dim_payment dp ON f.payment_key = dp.payment_key
GROUP BY dp.payment_type
ORDER BY total_payment_value DESC;

-- q4_customer_state_revenue
SELECT
    c.customer_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue
FROM fact_order_items f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- q5_seller_state_revenue
SELECT
    s.seller_state,
    COUNT(DISTINCT f.seller_id) AS total_sellers,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue
FROM fact_order_items f
JOIN dim_seller s ON f.seller_id = s.seller_id
GROUP BY s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- q6_delivery_late_vs_review
SELECT
    f.is_late_delivery,
    COUNT(*) AS total_items,
    ROUND(AVG(f.delivery_delay_days), 2) AS avg_delivery_delay_days,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items f
GROUP BY f.is_late_delivery;

-- q7_holiday_vs_non_holiday
SELECT
    d.is_public_holiday,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_public_holiday;

-- q8_weekend_vs_weekday
SELECT
    d.is_weekend,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.is_weekend;

