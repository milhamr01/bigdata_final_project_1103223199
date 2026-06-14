
-- Star Schema ETL Olist Data Warehouse
-- Grain fact table: 1 row = 1 item in 1 order

-- Primary Key Documentation:
-- dim_customer.customer_id
-- dim_product.product_id
-- dim_seller.seller_id
-- dim_payment.payment_key
-- dim_date.date_key
-- fact_order_items.order_item_key

-- Foreign Key Documentation:
-- fact_order_items.customer_id -> dim_customer.customer_id
-- fact_order_items.product_id -> dim_product.product_id
-- fact_order_items.seller_id -> dim_seller.seller_id
-- fact_order_items.payment_key -> dim_payment.payment_key
-- fact_order_items.date_key -> dim_date.date_key
