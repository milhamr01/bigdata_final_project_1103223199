# Big Data Final Project - Olist E-Commerce Analytics

Repository ini merupakan project Tugas Besar UAS Big Data yang mengimplementasikan pipeline **ETL** dan **ELT** untuk analisis transaksi e-commerce menggunakan **Olist Brazilian E-Commerce Dataset** dan **Nager.Date Public Holiday API**.

Project ini menghasilkan data warehouse berbasis **SQLite** dengan pendekatan **star schema**, query SQL analitik, dashboard Power BI, dokumentasi dataset, dokumentasi API, architecture diagram, dan laporan paper dalam format IEEE.

---

## 1. Project Overview

Tujuan project ini adalah membangun pipeline Big Data yang reproducible untuk mengolah data transaksi e-commerce dan menghasilkan insight bisnis melalui dashboard analitik.

Analisis yang dilakukan meliputi:

- Total revenue
- Total orders
- Total customers
- Average review score
- Late delivery percentage
- Revenue trend
- Top product categories
- Payment type distribution
- Revenue by customer state
- Holiday vs non-holiday revenue
- Perbandingan pendekatan ETL dan ELT

Project ini menggunakan dua pendekatan pipeline:

```text
ETL: Extract → Transform → Load
ELT: Extract → Load → Transform
```

Pada ETL, transformasi data dilakukan menggunakan Python/Pandas sebelum data dimuat ke warehouse. Pada ELT, raw data dimuat terlebih dahulu ke SQLite warehouse, kemudian transformasi dilakukan menggunakan SQL di dalam warehouse.

---

## 2. Data Sources

Project ini menggunakan dua sumber data.

### Dataset 1 — Olist Brazilian E-Commerce Dataset

Dataset utama berasal dari **Olist Brazilian E-Commerce Dataset** yang tersedia di Kaggle.

Link dataset:

```text
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
```

Dataset ini berisi beberapa file CSV transaksi e-commerce Brazil, seperti:

```text
olist_customers_dataset.csv
olist_geolocation_dataset.csv
olist_order_items_dataset.csv
olist_order_payments_dataset.csv
olist_order_reviews_dataset.csv
olist_orders_dataset.csv
olist_products_dataset.csv
olist_sellers_dataset.csv
product_category_name_translation.csv
```

Pada project, dataset ini digunakan sebagai sumber utama transaksi, customer, product, seller, payment, review, geolocation, dan product category.

### Dataset 2 — Nager.Date Public Holiday API

Dataset kedua berasal dari **Nager.Date Public Holiday API**. API ini digunakan untuk mengambil data hari libur publik Brazil tahun 2016 sampai 2018.

Endpoint API:

```text
https://date.nager.at/api/v3/PublicHolidays/2016/BR
https://date.nager.at/api/v3/PublicHolidays/2017/BR
https://date.nager.at/api/v3/PublicHolidays/2018/BR
```

Data holiday digunakan sebagai enrichment untuk membuat fitur:

```text
is_public_holiday
holiday_name
```

Fitur tersebut digunakan untuk menganalisis perbandingan transaksi pada holiday dan non-holiday.

---

## 3. Repository Structure

```text
bigdata_final_project/
├── etl_pipeline/
│   ├── README.md
│   └── etl_pipeline.ipynb
├── elt_pipeline/
│   ├── README.md
│   └── elt_pipeline_olist.ipynb
├── api_extraction/
│   ├── README.md
│   └── api_extraction_holiday_api.ipynb
├── raw/
│   └── README.md
├── datalake/
│   └── README.md
├── warehouse/
│   ├── README.md
│   ├── schema.sql
│   ├── schema_elt.sql
│   ├── analytic_queries.sql
│   ├── elt_analytic_queries.sql
│   ├── elt_validation_results.csv
│   └── etl_elt_comparison_summary.csv
├── dashboard/
│   ├── README.md
│   ├── olist_dashboard.pbix
│   ├── dashboard_olist_analytics.png
│   └── dashboard_etl_elt_comparison.png
├── architecture_diagram.png
├── report.pdf
└── README.md
```

Catatan: file dataset dan database SQLite berukuran besar dapat dibuat ulang dengan menjalankan notebook ETL dan ELT. Jika file besar tidak tersedia langsung di GitHub, file tersebut disimpan atau dapat dibuat ulang melalui pipeline.

---

## 4. ETL Pipeline

Folder:

```text
etl_pipeline/
```

Notebook utama:

```text
etl_pipeline/etl_pipeline.ipynb
```

Pipeline ETL menggunakan alur:

```text
Extract → Transform → Load
```

Tahapan ETL meliputi:

1. Extract data dari Olist CSV dan Nager.Date Holiday API.
2. Menyimpan data mentah ke raw folder dan data lake raw zone.
3. Melakukan data understanding untuk mengecek jumlah row, column, missing value, dan duplicate.
4. Melakukan standardisasi nama kolom.
5. Melakukan datetime conversion.
6. Melakukan controlled aggregation sebelum join.
7. Melakukan controlled join dengan grain `order_id + order_item_id`.
8. Melakukan enrichment dengan data Holiday API.
9. Melakukan feature engineering.
10. Melakukan missing value handling, duplicate handling, dan outlier handling.
11. Melakukan validasi kualitas data.
12. Membentuk star schema dan memuat hasil ke SQLite data warehouse.
13. Menyimpan query SQL analitik.

Output utama ETL:

```text
warehouse/bigdata_warehouse_etl.db
warehouse/schema.sql
warehouse/analytic_queries.sql
```

Final fact table ETL:

```text
fact_order_items
```

Jumlah final rows:

```text
112650 rows
```

---

## 5. ELT Pipeline

Folder:

```text
elt_pipeline/
```

Notebook utama:

```text
elt_pipeline/elt_pipeline_olist.ipynb
```

Pipeline ELT menggunakan alur:

```text
Extract → Load → Transform
```

Tahapan ELT meliputi:

1. Extract data dari Olist CSV dan Nager.Date Holiday API.
2. Load raw data langsung ke raw tables di SQLite warehouse.
3. Membuat metadata load.
4. Melakukan transformasi menggunakan SQL di dalam warehouse.
5. Membuat staging tables.
6. Membentuk final star schema ELT.
7. Melakukan validasi kualitas data.
8. Menyimpan query SQL analitik ELT.
9. Menyimpan ringkasan perbandingan ETL dan ELT.

Output utama ELT:

```text
warehouse/bigdata_warehouse_elt.db
warehouse/schema_elt.sql
warehouse/elt_analytic_queries.sql
warehouse/elt_validation_results.csv
warehouse/etl_elt_comparison_summary.csv
```

Final fact table ELT:

```text
fact_order_items_elt
```

Jumlah final rows:

```text
112650 rows
```

---

## 6. API Extraction

Karena Dataset 2 diperoleh melalui API, repository ini menyertakan dokumentasi dan notebook pengambilan data API.

Folder:

```text
api_extraction/
```

File:

```text
api_extraction/api_extraction_holiday_api.ipynb
api_extraction/README.md
```

Script API juga terdapat pada notebook ETL dan ELT pada bagian:

```text
Extract Source 2 — Nager.Date Holiday API
```

Proses API extraction menggunakan `requests.get()` untuk mengambil response JSON dari endpoint Nager.Date API, lalu mengubahnya menjadi DataFrame Pandas dan menyimpannya ke folder `raw/holidays/`.

---

## 7. Raw Data and Data Lake

Dokumentasi raw data tersedia pada:

```text
raw/README.md
```

Dokumentasi data lake tersedia pada:

```text
datalake/README.md
```

Struktur data lake yang digunakan:

```text
datalake/
├── raw_zone/
├── processed_zone/
└── curated_zone/
```

Keterangan:

- `raw_zone` digunakan untuk menyimpan data mentah hasil extract.
- `processed_zone` digunakan untuk menyimpan hasil proses menengah seperti validation results dan outlier summary.
- `curated_zone` digunakan untuk menyimpan data hasil transformasi yang siap dianalisis.

---

## 8. Data Warehouse

Folder:

```text
warehouse/
```

Database/data warehouse menggunakan **SQLite**.

Dokumentasi warehouse tersedia pada:

```text
warehouse/README.md
```

File schema:

```text
warehouse/schema.sql
warehouse/schema_elt.sql
```

File query SQL analitik:

```text
warehouse/analytic_queries.sql
warehouse/elt_analytic_queries.sql
```

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

### ELT Star Schema

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

Grain fact table:

```text
1 row = 1 item dalam 1 order
```

---

## 9. Dashboard

Folder:

```text
dashboard/
```

File dashboard:

```text
dashboard/olist_dashboard.pbix
```

Screenshot dashboard:

```text
dashboard/dashboard_olist_analytics.png
dashboard/dashboard_etl_elt_comparison.png
```

Dashboard dibuat menggunakan **Power BI Desktop** dan terdiri dari dua halaman:

1. **E-Commerce Sales & Delivery Analytics Dashboard**
   - Total Revenue
   - Total Orders
   - Total Customers
   - Average Review Score
   - Revenue Trend
   - Top Product Categories
   - Revenue by Customer State
   - Holiday vs Non-Holiday Revenue

2. **ETL vs ELT Comparison**
   - Perbandingan urutan proses ETL dan ELT
   - Lokasi transformasi
   - Output warehouse
   - Teknologi transformasi

---

## 10. Architecture Diagram

Diagram arsitektur sistem tersedia pada file:

```text
architecture_diagram.png
```

Diagram tersebut menjelaskan alur pengolahan data dari sumber data, pipeline ETL, pipeline ELT, data lake, data warehouse, hingga dashboard Power BI.

---

## 11. Report

Laporan paper tersedia pada file:

```text
report.pdf
```

Laporan ditulis menggunakan format IEEE dan memuat penjelasan project, dataset, arsitektur sistem, pipeline ETL, pipeline ELT, desain data warehouse, dashboard, perbandingan ETL dan ELT, serta kesimpulan.

---

## 12. How to Run

### Running ETL Pipeline

1. Buka notebook:

```text
etl_pipeline/etl_pipeline.ipynb
```

2. Jalankan notebook menggunakan Google Colab.
3. Mount Google Drive.
4. Pastikan dataset Olist tersedia pada path:

```text
raw/olist/
```

5. Jalankan seluruh cell dari awal sampai akhir.
6. Pastikan output ETL muncul, termasuk validasi, star schema, dan query SQL analitik.

### Running ELT Pipeline

1. Buka notebook:

```text
elt_pipeline/elt_pipeline_olist.ipynb
```

2. Jalankan notebook menggunakan Google Colab.
3. Mount Google Drive.
4. Pastikan dataset Olist tersedia pada path:

```text
raw/olist/
```

5. Jalankan seluruh cell dari awal sampai akhir.
6. Pastikan raw tables, staging tables, final star schema, validation results, dan query SQL analitik berhasil dibuat.

### Running API Extraction

1. Buka notebook:

```text
api_extraction/api_extraction_holiday_api.ipynb
```

2. Jalankan seluruh cell untuk mengambil data Nager.Date Holiday API.
3. Hasil API akan disimpan ke folder:

```text
raw/holidays/
```

### Opening Dashboard

1. Install dan buka **Power BI Desktop**.
2. Buka file:

```text
dashboard/olist_dashboard.pbix
```

3. Jika Power BI meminta koneksi ulang, sesuaikan koneksi SQLite/ODBC dengan lokasi file database pada perangkat lokal.

---

## 13. Reproducibility Notes

Project dapat dijalankan ulang dengan urutan berikut:

```text
1. Siapkan dataset Olist pada raw/olist/
2. Jalankan API extraction atau langsung jalankan notebook ETL/ELT
3. Jalankan ETL notebook
4. Jalankan ELT notebook
5. Buka dashboard Power BI
```

File credential, API key, dan environment file tidak disertakan. API yang digunakan bersifat public endpoint dan tidak membutuhkan API key.

File dataset besar dan database SQLite dapat dibuat ulang dengan menjalankan notebook yang tersedia pada repository.
