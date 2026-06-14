# ETL Pipeline Documentation

Folder ini berisi notebook pipeline ETL untuk project **Big Data Final Project - Olist E-Commerce Analytics**.

## Notebook

File utama:

```text
etl_pipeline.ipynb
```

Notebook ini mengimplementasikan pipeline ETL dengan alur:

```text
Extract → Transform → Load
```

## Data Sources

Pipeline ETL menggunakan dua sumber data:

1. **Olist Brazilian E-Commerce Dataset**
   - Dataset utama transaksi e-commerce.
   - Berisi data customers, orders, order items, payments, reviews, products, sellers, geolocation, dan product category translation.

2. **Nager.Date Holiday API**
   - Dataset tambahan dari API.
   - Digunakan untuk mengambil data hari libur publik Brazil tahun 2016–2018.
   - Data ini digunakan sebagai enrichment untuk membuat fitur `is_public_holiday`.

## ETL Process

Tahapan utama pada pipeline ETL:

1. Extract data dari Olist CSV dan Nager.Date Holiday API.
2. Menyimpan data mentah ke raw folder dan data lake raw zone.
3. Melakukan data understanding untuk mengecek jumlah row, column, missing value, dan duplicate.
4. Melakukan standardisasi nama kolom.
5. Mengubah kolom tanggal menjadi format datetime.
6. Melakukan controlled aggregation pada payments, reviews, products, dan geolocation sebelum join.
7. Melakukan controlled join untuk membentuk fact table dengan grain `order_id + order_item_id`.
8. Melakukan enrichment dengan data Holiday API.
9. Melakukan feature engineering seperti `delivery_days`, `delivery_delay_days`, `is_late_delivery`, `total_item_value`, `freight_ratio`, `product_volume_cm3`, dan `is_public_holiday`.
10. Melakukan handling missing value, duplicate, dan outlier.
11. Melakukan normalisasi numerik dan encoding kategorikal.
12. Melakukan validasi kualitas data.
13. Menyimpan data curated ke data lake.
14. Membentuk star schema dan memuat data ke SQLite data warehouse.
15. Menjalankan query SQL analitik.

## Output

Output utama dari pipeline ETL:

```text
warehouse/bigdata_warehouse_etl.db
warehouse/schema.sql
warehouse/analytic_queries.sql
datalake/curated_zone/fact_order_items_curated.csv
datalake/processed_zone/data_quality_validation_results.csv
```

## Data Warehouse

Pipeline ETL menghasilkan star schema dengan tabel:

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

Final fact table ETL memiliki:

```text
112650 rows
29 columns
```

## Validation

Validasi kualitas data pada pipeline ETL mencakup:

- uniqueness check pada `order_item_key`
- null check pada primary/foreign key
- range check untuk price dan freight
- datatype consistency
- referential integrity
- review score range 1 sampai 5
- minimum row count 100000
- minimum column count 12

Hasil validasi menunjukkan bahwa final dataset ETL memenuhi syarat minimal 100000 rows dan minimal 12 columns.

## Analytical Queries

Query SQL analitik ETL disimpan pada file:

```text
warehouse/analytic_queries.sql
```

Query analitik mencakup:

- monthly revenue
- top product categories
- payment type distribution
- customer state revenue
- seller state revenue
- late delivery vs review
- holiday vs non-holiday
- weekend vs weekday

## How to Run

1. Buka file `etl_pipeline.ipynb` menggunakan Google Colab.
2. Mount Google Drive.
3. Pastikan dataset Olist tersedia pada path `raw/olist/`.
4. Jalankan seluruh cell dari awal sampai akhir.
5. Pastikan output notebook muncul, termasuk hasil validasi, star schema, dan query SQL analitik.
