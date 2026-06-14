# Dashboard

Folder ini berisi file dan screenshot dashboard Power BI untuk project **Big Data Final Project - Olist E-Commerce Analytics**.

## Dashboard Files

File dashboard utama:

```text
olist_dashboard.pbix
```

Screenshot dashboard:

```text
dashboard_olist_analytics.png
dashboard_etl_elt_comparison.png
```

## Dashboard Description

Dashboard dibuat menggunakan **Power BI Desktop** dan terdiri dari dua halaman utama, yaitu **E-Commerce Sales & Delivery Analytics Dashboard** dan **ETL vs ELT Comparison**.

### 1. E-Commerce Sales & Delivery Analytics Dashboard

Halaman utama dashboard menampilkan analisis transaksi e-commerce Olist berdasarkan data warehouse yang telah dibangun dari pipeline ETL dan ELT. Halaman ini menyajikan KPI dan visual analitik seperti:

- **Total Revenue**
- **Total Orders**
- **Total Customers**
- **Average Review Score**
- **Revenue Trend by Date**
- **Top Product Categories by Revenue**
- **Revenue by Customer State**
- **Holiday vs Non-Holiday Revenue**

Dashboard ini digunakan untuk melihat performa transaksi, tren revenue, kategori produk dengan pendapatan terbesar, wilayah customer dengan kontribusi revenue terbesar, serta perbandingan transaksi pada hari libur dan non-holiday.

### 2. ETL vs ELT Comparison

Halaman kedua dashboard menampilkan perbandingan pendekatan ETL dan ELT yang digunakan dalam project. Perbandingan mencakup:

- **Urutan proses**
- **Lokasi transformasi**
- **Output warehouse**
- **Teknologi transformasi**

Secara umum, pipeline ETL melakukan transformasi data menggunakan Python/Pandas sebelum data dimuat ke data warehouse. Sementara itu, pipeline ELT memuat raw data terlebih dahulu ke SQLite warehouse, kemudian melakukan transformasi menggunakan SQL di dalam warehouse.

## Data Source Used in Dashboard

Dashboard menggunakan data hasil pipeline ETL dan ELT yang berasal dari dua sumber data:

1. **Olist Brazilian E-Commerce Dataset**  
   Dataset utama transaksi e-commerce yang berisi data customers, orders, order items, payments, reviews, products, sellers, geolocation, dan product category translation.

2. **Nager.Date Holiday API**  
   Dataset tambahan yang digunakan untuk mengambil informasi hari libur publik Brazil tahun 2016 sampai 2018. Data ini digunakan sebagai enrichment untuk membuat fitur `is_public_holiday`.

## How to Open Dashboard

Untuk membuka dashboard:

1. Install **Power BI Desktop**.
2. Buka file berikut:

```text
olist_dashboard.pbix
```

3. Jika Power BI meminta koneksi ulang ke data source, sesuaikan koneksi SQLite/ODBC sesuai lokasi file database pada perangkat lokal.

## Notes

Dashboard ini merupakan bagian dari deliverable Tugas Besar UAS Big Data. Screenshot dashboard disertakan agar hasil visualisasi tetap dapat diverifikasi tanpa harus membuka file Power BI secara langsung.
