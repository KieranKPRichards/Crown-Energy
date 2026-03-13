# Crown Energy Meter Reporting Application

A web application for processing Enermax energy meter data and generating monthly electricity cost reports based on South African tariff structures.

## Features

- **Multi-site management** – Add and manage multiple metering sites
- **Summation sites** – Combine multiple incomers (meters) by matching date/time rows and summing values
- **Tariff support** – Megaflex, Miniflex, Nightsave Urban, Tariff D, Tariff E
- **TOU classification** – Automatically classifies 30-minute readings into Peak, Standard, and Off-Peak periods
- **Bill calculation** – Computes full bill breakdown including service charges, demand charges, energy charges, reactive energy, ancillary charges, VAT
- **Multi-format export** – Export reports as CSV, Excel (.xlsx), or PDF
- **Batch report generation** – Generate reports for all sites in a single click
- **Cost trend charts** – Month-over-month sparklines on the dashboard and detailed cost/demand trend charts on each report
- **Data overview** – At-a-glance status matrix showing data completeness across all sites and months
- **Missing data alerts** – Dashboard notifications for sites with incomplete data for the current period
- **Report notes** – Add comments and annotations to reports (e.g. load shedding, meter issues)
- **Bulk upload** – Drag-and-drop multiple BR/PR files; auto-assigns to sites by meter serial number
- **Tariff editor** – Update tariff rates from the UI without editing code
- **Docker support** – Docker Compose setup with persistent storage and health checks

## Quick Start

### Option 1: Docker (recommended)

```bash
cp .env.example .env    # edit SECRET_KEY
docker compose up --build
```

Open **http://localhost:5000**

### Option 2: Local Python

#### Prerequisites

- **Python 3.9+** (download from [python.org](https://www.python.org/downloads/))
  - On Mac: `brew install python3`
  - On Windows: Download installer from python.org (check "Add to PATH" during install)

#### Installation

1. **Download/extract** this folder to your desired location

2. **Open a terminal** (Terminal on Mac, Command Prompt or PowerShell on Windows)

3. **Navigate to the app folder:**
   ```bash
   cd path/to/energy-meter-app
   ```

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
   Or on Mac/Linux:
   ```bash
   pip3 install -r requirements.txt
   ```

5. **Run the application:**
   ```bash
   python app.py
   ```
   Or on Mac/Linux:
   ```bash
   python3 app.py
   ```

6. **Open your browser** to: **http://localhost:5000**

### Optional: LibreOffice (for BR .xls file support)

If you need to process `.xls` billing files (older Enermax format), install [LibreOffice](https://www.libreoffice.org/download/) — it's used to convert `.xls` to `.xlsx` format. The app works fine without it if you only use `.csv` profile files.

## Usage

### Adding a Site

1. Click **"+ Add Site"** on the dashboard
2. Fill in the site details:
   - **Site Name** – e.g. "City Deep"
   - **Tariff** – Select from Megaflex, Miniflex, etc.
   - **NMD (kVA)** – Notified Maximum Demand
   - **Utilised Capacity (kVA)** – From Eskom (used for Megaflex capacity charges)
   - **Summation site** – Check this if the site has multiple incomers that need to be combined

### Uploading Meter Data

1. Go to your site's detail page
2. Click **"+ Add Meter Data"**
3. For each meter/incomer:
   - Enter the meter number as the label
   - Upload the **Billing file** (BR*.xls) – optional
   - Upload the **Profile file** (PR*.csv) – required for energy calculations

For summation sites, add each meter separately. The app will automatically match date/time rows and sum the values.

**Bulk upload:** Use the Bulk Upload page to drag-and-drop all BR and PR files at once. Files are automatically matched to sites by meter serial number.

### Generating Reports

**Single site:**
1. On the site detail page, select the billing month and year
2. Click **"Generate Report"**

**All sites at once:**
1. Click **"Batch Generate"** on the dashboard
2. Select the billing month and year
3. Reports are generated for every site that has data for that period

### Report Features

Each report includes:
- Energy consumption breakdown (Peak/Standard/Off-Peak)
- Maximum demand and power factor
- Full bill breakdown with all charge components
- Energy distribution visualization
- Cost trend chart comparing to previous months
- Notes section for annotations

**Export options:** CSV, Excel (.xlsx), and PDF download buttons are available on each report.

### Data File Formats

**Profile files (PR*.csv):**
```
Meter Serial: 14140031
File Exported on: 2026-02-02 18:13:38
Profile Data View Package: 00v087
Profile Period: 2025/12/29 - 2026/02/02
Meter - CT: 1800/5 VT: 6600/110

Date,Time,Wh  Tot_Imp__:Sum   30m,varhTot_Q1:Sum   30m
,,kWh  ,kvarh
2025/12/29,00:30,108.000,194.400
2025/12/29,01:00,129.600,172.800
...
```

**Billing files (BR*.xls):**
- Enermax billing data export with "Energy Billing" and "Max Demand Billing" sheets
- Contains accumulated energy readings and maximum demand recordings

## Updating Tariff Rates

Tariff rates can be updated from the **Tariff Rates** page in the app. Each tariff year (typically April to March), update the rates from the latest Eskom/municipality gazettes.

The key values to update for each tariff:
- Service and administration charges (R/day)
- Demand and capacity charges (R/kVA)
- Active energy rates per TOU period (R/kWh)
- Ancillary, legacy, electrification, and affordability charges (R/kWh)

## Data Storage

Data is stored in a SQLite database with uploaded files on disk:
- `data/energy.db` – SQLite database (sites, meters, reports)
- `data/{site_id}/` – Uploaded meter files per site

When running with Docker, the `data/` directory is persisted via a named volume.

## Troubleshooting

- **"Module not found" error** – Run `pip install -r requirements.txt` again
- **Port already in use** – Set a different port: `PORT=8080 python app.py`
- **BR .xls files not reading** – Install LibreOffice or convert files to .xlsx manually
- **Wrong TOU classification** – Check that the billing month/year matches your profile data period
