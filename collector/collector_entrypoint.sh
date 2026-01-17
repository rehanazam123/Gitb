#!/usr/bin/env bash
set -euo pipefail

# Wait for DB and Influx
/app/wait-for.sh db 3306 60
/app/wait-for.sh influxdb 8086 60

# Run the collector entry (main.py)
exec python main.py
