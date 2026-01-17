#!/usr/bin/env bash
# wait-for.sh host port timeout
HOST="$1"
PORT="$2"
TIMEOUT="${3:-60}"
if [ -z "$HOST" ] || [ -z "$PORT" ]; then
  echo "Usage: wait-for.sh host port [timeout]" >&2
  exit 1
fi
echo "Waiting for $HOST:$PORT (timeout ${TIMEOUT}s)..."
start_ts=$(date +%s)
while :
do
  if (echo > /dev/tcp/"$HOST"/"$PORT") >/dev/null 2>&1; then
    echo "$HOST:$PORT is available"
    exit 0
  fi
  now_ts=$(date +%s)
  elapsed=$((now_ts - start_ts))
  if [ "$elapsed" -ge "$TIMEOUT" ]; then
    echo "Timeout waiting for $HOST:$PORT" >&2
    exit 1
  fi
  sleep 1
done
