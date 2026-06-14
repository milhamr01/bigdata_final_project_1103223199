# Raw Data Documentation

Folder ini digunakan untuk mendokumentasikan sumber data mentah yang digunakan pada project **Big Data Final Project - Olist E-Commerce Analytics**.

Project ini menggunakan dua sumber data utama:

1. **Olist Brazilian E-Commerce Dataset** sebagai dataset utama transaksi e-commerce.
2. **Nager.Date Public Holiday API** sebagai dataset tambahan untuk enrichment data hari libur publik Brazil.

File dataset berukuran besar tidak diupload langsung ke GitHub agar repository tetap ringan. Dataset dapat diunduh dari sumber aslinya atau dibuat ulang melalui notebook pipeline ETL dan ELT.

---

## 1. Dataset 1 — Olist Brazilian E-Commerce Dataset

Dataset utama yang digunakan adalah **Olist Brazilian E-Commerce Dataset** dari Kaggle.

Link dataset:

```text
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
```

Dataset ini berisi data transaksi e-commerce Brazil, yang terdiri dari beberapa file CSV seperti:

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

Pada implementasi project, file CSV Olist disimpan pada path:

```text
raw/olist/
```

Dataset Olist digunakan sebagai sumber utama untuk membangun data transaksi, customer, product, seller, payment, review, geolocation, serta kategori produk.

---

## 2. Dataset 2 — Nager.Date Public Holiday API

Dataset kedua berasal dari **Nager.Date Public Holiday API**. API ini digunakan untuk mengambil data hari libur publik Brazil tahun 2016 sampai 2018.

Endpoint API yang digunakan:

```text
https://date.nager.at/api/v3/PublicHolidays/2016/BR
https://date.nager.at/api/v3/PublicHolidays/2017/BR
https://date.nager.at/api/v3/PublicHolidays/2018/BR
```

Country code yang digunakan:

```text
BR
```

Hasil ekstraksi API disimpan pada path:

```text
raw/holidays/
```

Output file hasil ekstraksi API:

```text
brazil_holidays_2016_2018.csv
brazil_holidays_2016_2018_elt_raw.csv
```

Data holiday digunakan sebagai enrichment untuk menambahkan informasi hari libur ke data transaksi Olist.

---

## 3. Data Integration

Data Olist dan data Holiday API digabungkan berdasarkan tanggal transaksi.

Kolom tanggal dari dataset Olist:

```text
order_date
```

Kolom tanggal dari Holiday API:

```text
date
```

Proses integrasi dilakukan dengan mencocokkan:

```text
Olist order_date = Holiday API date
```

Hasil integrasi digunakan untuk membuat fitur:

```text
is_public_holiday
holiday_name
```

Jika tanggal transaksi ditemukan pada data holiday, maka nilai `is_public_holiday` adalah `1`. Jika tanggal transaksi tidak ditemukan pada data holiday, maka nilai `is_public_holiday` adalah `0`.

---

## 4. Purpose of Raw Data

Folder raw digunakan sebagai tempat penyimpanan data mentah sebelum dilakukan transformasi lebih lanjut.

Dalam pipeline ETL, raw data diekstrak terlebih dahulu, lalu ditransformasi menggunakan Python/Pandas sebelum dimuat ke data warehouse.

Dalam pipeline ELT, raw data dimuat terlebih dahulu ke raw tables di SQLite warehouse, kemudian transformasi dilakukan menggunakan SQL di dalam warehouse.

---

## 5. Notes

Dataset Olist tidak diupload penuh ke GitHub karena ukuran file cukup besar. Dataset dapat diperoleh melalui link Kaggle yang tersedia pada dokumentasi ini.

Data Holiday API dapat dibuat ulang dengan menjalankan notebook ETL, notebook ELT, atau notebook API extraction yang tersedia pada repository.

Notebook terkait:

```text
etl_pipeline/etl_pipeline.ipynb
elt_pipeline/elt_pipeline_olist.ipynb
api_extraction/api_extraction_holiday_api.ipynb
```
