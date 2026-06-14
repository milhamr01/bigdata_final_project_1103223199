# Data Warehouse Documentation

Folder ini berisi dokumentasi database dan data warehouse untuk project **Big Data Final Project - Olist E-Commerce Analytics**.

Database yang digunakan pada project ini adalah **SQLite**. Project ini menghasilkan dua data warehouse utama, yaitu data warehouse hasil pipeline **ETL** dan data warehouse hasil pipeline **ELT**.

File database SQLite `.db` tidak wajib diupload langsung ke GitHub karena ukuran file cukup besar. Database dapat dibuat ulang dengan menjalankan notebook ETL dan ELT yang tersedia pada repository.

---

## External Warehouse Files

Beberapa file berukuran besar, seperti file database SQLite, tidak diupload langsung ke GitHub karena keterbatasan ukuran file pada GitHub Web. File tersebut dapat diakses melalui Google Drive berikut:

```text
https://drive.google.com/drive/folders/1Z-XczePo4qs5pJMgYuhYvxXjofrAXW9C?usp=sharing
```

Folder Google Drive tersebut digunakan untuk menyimpan file besar yang dibutuhkan apabila reviewer ingin melihat atau mengunduh file database/data warehouse secara langsung. Namun, project tetap dapat direproduksi dengan menjalankan notebook ETL dan ELT dari awal.

---

## 1. Database Technology

Database/data warehouse yang digunakan:

```text
SQLite
```

Output database utama:

```text
bigdata_warehouse_etl.db
bigdata_warehouse_elt.db
```

Database tersebut dihasilkan dari notebook:

```text
etl_pipeline/etl_pipeline.ipynb
elt_pipeline/elt_pipeline_olist.ipynb
```

---

## 2. ETL Data Warehouse

Pipeline ETL menggunakan alur:

```text
Extract → Transform → Load
```

Pada pipeline ETL, data dari Olist CSV dan Nager.Date Holiday API diekstrak terlebih dahulu, lalu dibersihkan, digabung, diperkaya, dan ditransformasi menggunakan Python/Pandas sebelum dimuat ke SQLite data warehouse.

### ETL Star Schema

Fact table:

```text
fact_order_items
```

Dimension tables:

```text
dim_customer
dim_product
dim_seller
dim_payment
dim_date
```

### ETL Table Structure

| Table | Description |
|---|---|
| `fact_order_items` | Tabel fakta utama dengan grain 1 baris = 1 item dalam 1 order. |
| `dim_customer` | Dimensi customer berisi customer ID, unique ID, zip code, city, state, dan geolocation. |
| `dim_product` | Dimensi produk berisi product ID, kategori produk, ukuran, berat, dan volume produk. |
| `dim_seller` | Dimensi seller berisi seller ID, zip code, city, dan state. |
| `dim_payment` | Dimensi payment berisi payment type, installments, payment count, dan payment key. |
| `dim_date` | Dimensi tanggal berisi date key, tanggal, tahun, bulan, hari, weekend flag, dan holiday flag. |

### ETL Primary Key

```text
fact_order_items.order_item_key
dim_customer.customer_id
dim_product.product_id
dim_seller.seller_id
dim_payment.payment_key
dim_date.date_key
```

### ETL Foreign Key

```text
fact_order_items.customer_id → dim_customer.customer_id
fact_order_items.product_id  → dim_product.product_id
fact_order_items.seller_id   → dim_seller.seller_id
fact_order_items.payment_key → dim_payment.payment_key
fact_order_items.date_key    → dim_date.date_key
```

### ETL Output Summary

Final fact table ETL:

```text
fact_order_items
```

Jumlah final rows:

```text
112650 rows
```

Dokumentasi schema ETL tersedia pada file:

```text
schema.sql
```

Query SQL analitik ETL tersedia pada file:

```text
analytic_queries.sql
```

---

## 3. ELT Data Warehouse

Pipeline ELT menggunakan alur:

```text
Extract → Load → Transform
```

Pada pipeline ELT, data mentah dari Olist CSV dan Nager.Date Holiday API dimuat terlebih dahulu ke raw tables di SQLite warehouse. Setelah itu, transformasi dilakukan di dalam warehouse menggunakan SQL.

### ELT Raw Tables

```text
raw_customers
raw_geolocation
raw_order_items
raw_payments
raw_reviews
raw_orders
raw_products
raw_sellers
raw_category_translation
raw_holidays
```

### ELT Staging Tables

```text
stg_payments_agg
stg_reviews_agg
stg_geolocation_agg
stg_products_en
stg_fact_order_items_enriched
```

### ELT Final Star Schema

Fact table:

```text
fact_order_items_elt
```

Dimension tables:

```text
dim_customer_elt
dim_product_elt
dim_seller_elt
dim_payment_elt
dim_date_elt
```

### ELT Table Structure

| Table | Description |
|---|---|
| `fact_order_items_elt` | Tabel fakta utama hasil ELT dengan grain 1 baris = 1 item dalam 1 order. |
| `dim_customer_elt` | Dimensi customer hasil ELT. |
| `dim_product_elt` | Dimensi produk hasil ELT. |
| `dim_seller_elt` | Dimensi seller hasil ELT. |
| `dim_payment_elt` | Dimensi payment hasil ELT. |
| `dim_date_elt` | Dimensi tanggal hasil ELT. |

### ELT Primary Key

```text
fact_order_items_elt.order_item_key
dim_customer_elt.customer_id
dim_product_elt.product_id
dim_seller_elt.seller_id
dim_payment_elt.payment_key
dim_date_elt.date_key
```

### ELT Foreign Key

```text
fact_order_items_elt.customer_id → dim_customer_elt.customer_id
fact_order_items_elt.product_id  → dim_product_elt.product_id
fact_order_items_elt.seller_id   → dim_seller_elt.seller_id
fact_order_items_elt.payment_key → dim_payment_elt.payment_key
fact_order_items_elt.date_key    → dim_date_elt.date_key
```

### ELT Output Summary

Final fact table ELT:

```text
fact_order_items_elt
```

Jumlah final rows:

```text
112650 rows
```

Dokumentasi schema ELT tersedia pada file:

```text
schema_elt.sql
```

Query SQL analitik ELT tersedia pada file:

```text
elt_analytic_queries.sql
```

---

## 4. Star Schema Relationship

Secara umum, star schema yang digunakan pada ETL memiliki struktur berikut:

```text
                 dim_customer
                      |
                      |
dim_product --- fact_order_items --- dim_seller
                      |
                      |
                dim_payment
                      |
                      |
                  dim_date
```

Untuk ELT, struktur star schema memiliki pola yang sama, tetapi menggunakan suffix `_elt`:

```text
                 dim_customer_elt
                       |
                       |
dim_product_elt --- fact_order_items_elt --- dim_seller_elt
                       |
                       |
                 dim_payment_elt
                       |
                       |
                   dim_date_elt
```

---

## 5. Analytical SQL Queries

Query SQL analitik digunakan untuk memverifikasi hasil data warehouse dan mendukung pembuatan dashboard.

### ETL Analytical Queries

File:

```text
analytic_queries.sql
```

Query ETL mencakup:

```text
monthly revenue
top product categories
payment type distribution
customer state revenue
seller state revenue
late delivery vs review
holiday vs non-holiday
weekend vs weekday
```

### ELT Analytical Queries

File:

```text
elt_analytic_queries.sql
```

Query ELT mencakup:

```text
monthly revenue
category revenue
payment type distribution
customer state revenue
late delivery review
holiday vs non-holiday
```

---

## 6. Validation and Comparison Files

File pendukung:

```text
elt_validation_results.csv
etl_elt_comparison_summary.csv
```

`elt_validation_results.csv` berisi hasil validasi kualitas data ELT, seperti uniqueness check, null check, range check, referential integrity, row count minimum 100k, dan column count minimum 12.

`etl_elt_comparison_summary.csv` berisi ringkasan perbedaan pendekatan ETL dan ELT.

---

## 7. Notes

File database SQLite `.db` dapat dibuat ulang dengan menjalankan notebook ETL dan ELT. Repository ini menyertakan dokumentasi schema, struktur tabel, query SQL analitik, hasil validasi, dan ringkasan perbandingan ETL vs ELT untuk mendukung verifikasi data warehouse.
