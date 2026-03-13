FROM python:3.12-slim

# Install LibreOffice for BR .xls conversion
RUN apt-get update && \
    apt-get install -y --no-install-recommends libreoffice-calc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Data directory for SQLite DB and uploaded files
RUN mkdir -p /app/data

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "120", "app:app"]
