# API Data Extraction Documentation

Folder/dokumen ini menjelaskan proses pengambilan data dari **Nager.Date Public Holiday API** yang digunakan sebagai Dataset 2 pada project **Big Data Final Project - Olist E-Commerce Analytics**.

## API Source

API yang digunakan:

```text
Nager.Date Public Holiday API
```

Endpoint yang digunakan:

```text
https://date.nager.at/api/v3/PublicHolidays/2016/BR
https://date.nager.at/api/v3/PublicHolidays/2017/BR
https://date.nager.at/api/v3/PublicHolidays/2018/BR
```

Country code yang digunakan adalah:

```text
BR
```

Kode tersebut merepresentasikan Brazil.

## Script Location

Script pengambilan data API tersedia pada notebook:

```text
api_extraction_holiday_api.ipynb
```

Selain notebook terpisah ini, script pengambilan API juga terdapat pada notebook utama project:

```text
etl_pipeline/etl_pipeline.ipynb
elt_pipeline/elt_pipeline_olist.ipynb
```

Pada notebook ETL dan ELT, script API berada pada bagian:

```text
Extract Source 2 — Nager.Date Holiday API
```

## Extraction Process

Proses pengambilan data API dilakukan dengan langkah berikut:

1. Menentukan daftar tahun yang digunakan, yaitu 2016, 2017, dan 2018.
2. Membentuk URL endpoint Nager.Date API berdasarkan tahun dan country code Brazil (`BR`).
3. Mengambil response API menggunakan `requests.get()`.
4. Melakukan validasi response dengan `response.raise_for_status()`.
5. Mengambil response JSON menggunakan `response.json()`.
6. Menggabungkan data holiday dari seluruh tahun ke dalam satu list.
7. Mengubah hasil JSON menjadi DataFrame Pandas.
8. Menyimpan hasil ekstraksi API sebagai file CSV ke folder `raw/holidays/` dan `datalake/raw_zone/`.

## Output Files

Output dari proses API extraction:

```text
raw/holidays/brazil_holidays_2016_2018.csv
raw/holidays/brazil_holidays_2016_2018_elt_raw.csv
datalake/raw_zone/brazil_holidays_2016_2018.csv
raw/holidays/holiday_api_extraction_log.csv
```

## Usage in ETL and ELT Pipeline

Data Holiday API digunakan sebagai data enrichment untuk dataset Olist.

Dataset Olist memiliki kolom tanggal transaksi:

```text
order_date
```

Dataset Holiday API memiliki kolom tanggal:

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

## Purpose

Data Holiday API digunakan untuk mendukung analisis:

- Perbandingan transaksi holiday dan non-holiday.
- Analisis revenue pada hari libur publik Brazil.
- Enrichment data warehouse dan dashboard Power BI.

## Notes

Dataset Holiday API memiliki jumlah baris yang lebih kecil dibandingkan dataset Olist karena hanya berisi daftar hari libur publik. Dataset ini tidak digunakan sebagai fact table utama, tetapi digunakan sebagai sumber data tambahan untuk enrichment.
