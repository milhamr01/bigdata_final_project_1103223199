-- q1_monthly_revenue_elt\nSELECT
    d.order_year,
    d.order_month,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue
FROM fact_order_items_elt f
JOIN dim_date_elt d ON f.date_key = d.date_key
GROUP BY d.order_year, d.order_month
ORDER BY d.order_year, d.order_month;\n\n-- q2_category_revenue_elt\nSELECT
    p.product_category_name_english,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items_elt f
JOIN dim_product_elt p ON f.product_id = p.product_id
GROUP BY p.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;\n\n-- q3_payment_type_elt\nSELECT
    p.payment_type,
    COUNT(*) AS total_items,
    COUNT(DISTINCT f.order_id) AS total_orders,
    ROUND(SUM(f.payment_value), 2) AS total_payment_value
FROM fact_order_items_elt f
JOIN dim_payment_elt p ON f.payment_key = p.payment_key
GROUP BY p.payment_type
ORDER BY total_payment_value DESC;\n\n-- q4_customer_state_revenue_elt\nSELECT
    c.customer_state,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue
FROM fact_order_items_elt f
JOIN dim_customer_elt c ON f.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;\n\n-- q5_late_delivery_review_elt\nSELECT
    is_late_delivery,
    COUNT(*) AS total_items,
    ROUND(AVG(delivery_delay_days), 2) AS avg_delivery_delay_days,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM fact_order_items_elt
GROUP BY is_late_delivery;\n\n-- q6_holiday_nonholiday_elt\nSELECT
    d.is_public_holiday,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(f.total_item_value), 2) AS total_revenue,
    ROUND(AVG(f.review_score), 2) AS avg_review_score
FROM fact_order_items_elt f
JOIN dim_date_elt d ON f.date_key = d.date_key
GROUP BY d.is_public_holiday;\n\n