#!/usr/bin/env bash
set -euo pipefail

# Wait for MySQL and InfluxDB to be available
/app/wait-for.sh db 3306 60
/app/wait-for.sh influxdb 8086 60

# Ensure DB schema (creates tables) — safe no-op if already present
python /app/create_db.py

# Start uvicorn (production mode; single worker)
exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --workers 1
