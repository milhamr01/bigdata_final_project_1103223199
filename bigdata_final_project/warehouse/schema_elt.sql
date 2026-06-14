
-- Star Schema ELT Olist Data Warehouse
-- Raw data loaded first, then transformed inside SQLite warehouse.

-- Primary Key Documentation:
-- dim_customer_elt.customer_id
-- dim_product_elt.product_id
-- dim_seller_elt.seller_id
-- dim_payment_elt.payment_key
-- dim_date_elt.date_key
-- fact_order_items_elt.order_item_key

-- Foreign Key Documentation:
-- fact_order_items_elt.customer_id -> dim_customer_elt.customer_id
-- fact_order_items_elt.product_id -> dim_product_elt.product_id
-- fact_order_items_elt.seller_id -> dim_seller_elt.seller_id
-- fact_order_items_elt.payment_key -> dim_payment_elt.payment_key
-- fact_order_items_elt.date_key -> dim_date_elt.date_key
