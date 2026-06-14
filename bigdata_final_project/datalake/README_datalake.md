# Data Lake Documentation

Folder ini digunakan untuk mendokumentasikan struktur data lake pada project **Big Data Final Project - Olist E-Commerce Analytics**.

Data lake digunakan terutama pada pipeline ETL untuk menyimpan data dalam beberapa zona pemrosesan. File data berukuran besar tidak diupload langsung ke GitHub agar repository tetap ringan. Seluruh isi data lake dapat dibuat ulang dengan menjalankan notebook ETL.

---

## External Data Lake Files

Beberapa file data lake berukuran besar tidak diupload langsung ke GitHub. File tersebut dapat diakses melalui Google Drive berikut:

```text
https://drive.google.com/drive/folders/1-A247OSFt344aGFVYBMQudPiY9NKq9Gf?usp=sharing
```

Folder Google Drive tersebut digunakan untuk menyimpan file data lake apabila reviewer ingin melihat atau mengunduh output data lake secara langsung. Namun, seluruh output data lake tetap dapat dibuat ulang dengan menjalankan notebook ETL dari awal sampai akhir.

---

## Data Lake Structure

Struktur data lake yang digunakan pada project:

```text
datalake/
├── raw_zone/
├── processed_zone/
└── curated_zone/
```

---

## 1. raw_zone

`raw_zone` digunakan untuk menyimpan salinan data mentah hasil ekstraksi dari sumber data.

Sumber data yang masuk ke `raw_zone` meliputi:

```text
Olist Brazilian E-Commerce CSV
Nager.Date Holiday API
```

Contoh file yang dapat terbentuk di zona ini:

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
brazil_holidays_2016_2018.csv
```

Zona ini digunakan untuk menjaga salinan data mentah agar proses pipeline dapat ditelusuri ulang dan direproduksi.

---

## 2. processed_zone

`processed_zone` digunakan untuk menyimpan hasil proses menengah dari pipeline ETL.

Contoh output pada zona ini:

```text
data_quality_validation_results.csv
outlier_summary.csv
```

Zona ini berisi hasil validasi kualitas data dan ringkasan proses transformasi, seperti pengecekan missing value, duplicate, outlier, dan validasi aturan kualitas data.

---

## 3. curated_zone

`curated_zone` digunakan untuk menyimpan data hasil transformasi yang sudah siap digunakan untuk analisis atau dimuat ke data warehouse.

Contoh output pada zona ini:

```text
fact_order_items_curated.csv
```

File curated berisi hasil integrasi dataset Olist dengan data Holiday API serta hasil feature engineering seperti:

```text
delivery_days
delivery_delay_days
is_late_delivery
total_item_value
freight_ratio
product_volume_cm3
is_public_holiday
```

Data pada zona ini menjadi data yang sudah lebih siap untuk digunakan dalam proses load ke data warehouse atau analisis lanjutan.

---

## Notes

File data lake berukuran besar tidak diupload langsung ke GitHub. File tersebut dapat diakses melalui link Google Drive pada bagian **External Data Lake Files** atau dapat dibuat ulang dengan menjalankan notebook ETL berikut:

```text
etl_pipeline/etl_pipeline.ipynb
```

Notebook ETL akan melakukan extract, transform, validasi, dan menyimpan output ke folder data lake sesuai struktur `raw_zone`, `processed_zone`, dan `curated_zone`.
