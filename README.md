# Crown Energy Meter Reporting Application

A desktop application for processing Enermax energy meter data and generating monthly electricity cost reports based on South African tariff structures.

## Features

- **Multi-site management** – Add and manage multiple metering sites
- **Summation sites** – Combine multiple incomers (meters) by matching date/time rows and summing values
- **Tariff support** – Megaflex, Miniflex, Nightsave Urban, Tariff D, Tariff E
- **TOU classification** – Automatically classifies 30-minute readings into Peak, Standard, and Off-Peak periods
- **Bill calculation** – Computes full bill breakdown including service charges, demand charges, energy charges, reactive energy, ancillary charges, VAT
- **Report export** – Export reports as CSV; print-friendly report view
- **Cross-platform** – Runs on Mac, Windows, and Linux

## Quick Start

### Prerequisites

- **Python 3.9+** (download from [python.org](https://www.python.org/downloads/))
  - On Mac: `brew install python3`
  - On Windows: Download installer from python.org (check "Add to PATH" during install)

### Installation

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

### Generating a Report

1. On the site detail page, select the billing month and year
2. Click **"Generate Report"**
3. View the full report with:
   - Energy consumption breakdown (Peak/Standard/Off-Peak)
   - Maximum demand and power factor
   - Full bill breakdown with all charge components
   - Energy distribution visualization

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

Tariff rates are defined in `app.py` in the `TARIFFS` dictionary near the top of the file. Each tariff year (typically April to March), update the rates from the latest Eskom/municipality gazettes.

The key values to update for each tariff:
- Service and administration charges (R/day)
- Demand and capacity charges (R/kVA)
- Active energy rates per TOU period (R/kWh)
- Ancillary, legacy, electrification, and affordability charges (R/kWh)

## Data Storage

All data is stored locally in the `data/` folder within the application directory:
- `data/sites.json` – Site configuration
- `data/{site_id}/` – Uploaded meter files per site

## Troubleshooting

- **"Module not found" error** – Run `pip install -r requirements.txt` again
- **Port already in use** – Set a different port: `PORT=8080 python app.py`
- **BR .xls files not reading** – Install LibreOffice or convert files to .xlsx manually
- **Wrong TOU classification** – Check that the billing month/year matches your profile data period
