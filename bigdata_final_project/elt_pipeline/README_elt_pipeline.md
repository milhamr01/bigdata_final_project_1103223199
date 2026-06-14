# ELT Pipeline Documentation

Folder ini berisi notebook pipeline ELT untuk project **Big Data Final Project - Olist E-Commerce Analytics**.

## Notebook

File utama:

```text
elt_pipeline_olist.ipynb
```

Notebook ini mengimplementasikan pipeline ELT dengan alur:

```text
Extract → Load → Transform
```

## Data Sources

Pipeline ELT menggunakan sumber data yang sama dengan pipeline ETL:

1. **Olist Brazilian E-Commerce Dataset**
   - Dataset utama transaksi e-commerce.
   - Berisi data customers, orders, order items, payments, reviews, products, sellers, geolocation, dan product category translation.

2. **Nager.Date Holiday API**
   - Dataset tambahan dari API.
   - Digunakan untuk mengambil data hari libur publik Brazil tahun 2016–2018.
   - Data holiday digunakan sebagai enrichment untuk fitur `is_public_holiday`.

## ELT Process

Tahapan utama pada pipeline ELT:

1. Extract raw data dari Olist CSV.
2. Extract raw data dari Nager.Date Holiday API.
3. Load data mentah langsung ke raw tables di SQLite warehouse.
4. Membuat metadata load untuk mendokumentasikan proses loading data.
5. Melakukan transformasi di dalam SQLite warehouse menggunakan SQL.
6. Membuat staging tables seperti `stg_payments_agg`, `stg_reviews_agg`, `stg_geolocation_agg`, `stg_products_en`, dan `stg_fact_order_items_enriched`.
7. Membuat final star schema ELT.
8. Memperbaiki `dim_date_elt` agar `date_key` unik.
9. Melakukan validasi kualitas data.
10. Menjalankan query SQL analitik.
11. Menyimpan log dan metadata proses ELT.

## Output

Output utama dari pipeline ELT:

```text
warehouse/bigdata_warehouse_elt.db
warehouse/schema_elt.sql
warehouse/elt_analytic_queries.sql
warehouse/elt_validation_results.csv
warehouse/etl_elt_comparison_summary.csv
elt_pipeline/logs/elt_process_log.csv
elt_pipeline/logs/elt_load_metadata.csv
```

## Raw Tables

Pipeline ELT memuat data mentah ke raw tables berikut:

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

## Staging Tables

Transformasi SQL di warehouse menghasilkan staging tables:

```text
stg_payments_agg
stg_reviews_agg
stg_geolocation_agg
stg_products_en
stg_fact_order_items_enriched
```

## Final Star Schema

Pipeline ELT menghasilkan final star schema dengan tabel:

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

Final fact table ELT memiliki:

```text
112650 rows
```

`dim_date_elt` sudah diperbaiki agar `date_key` unik dengan hasil:

```text
total_rows = 616
unique_date_key = 616
```

## Validation

Validasi kualitas data ELT mencakup:

- uniqueness check pada `order_item_key`
- null check pada primary key
- range check untuk price dan freight
- referential integrity
- minimum row count 100000
- minimum column count 12

Hasil validasi menunjukkan seluruh rule bernilai `True`, sehingga hasil pipeline ELT valid untuk digunakan sebagai data warehouse analitik.

## Analytical Queries

Query SQL analitik ELT disimpan pada file:

```text
warehouse/elt_analytic_queries.sql
```

Query analitik mencakup:

- monthly revenue
- category revenue
- payment type distribution
- customer state revenue
- late delivery review
- holiday vs non-holiday

## ETL vs ELT Comparison

Notebook ELT juga menghasilkan file:

```text
warehouse/etl_elt_comparison_summary.csv
```

File tersebut berisi ringkasan perbedaan pendekatan ETL dan ELT, seperti urutan proses, lokasi transformasi, output warehouse, dan teknologi transformasi.

## How to Run

1. Buka file `elt_pipeline_olist.ipynb` menggunakan Google Colab.
2. Mount Google Drive.
3. Pastikan dataset Olist tersedia pada path `raw/olist/`.
4. Jalankan seluruh cell dari awal sampai akhir.
5. Pastikan raw tables, staging tables, final star schema, validation results, dan query SQL analitik berhasil dibuat.
