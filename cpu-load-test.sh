#!/usr/bin/env bash
# Controlled CPU test for a personal lab EC2 instance only.
# Usage: ./cpu-load-test.sh [duration_seconds]
set -euo pipefail
DURATION="${1:-120}"
if ! [[ "$DURATION" =~ ^[0-9]+$ ]] || (( DURATION < 10 || DURATION > 300 )); then
  echo "Choose a duration between 10 and 300 seconds."
  exit 1
fi
echo "Starting controlled CPU test for ${DURATION} seconds. Stop with Ctrl+C if needed."
if command -v stress-ng >/dev/null 2>&1; then
  stress-ng --cpu 1 --timeout "${DURATION}s" --metrics-brief
else
  echo "stress-ng not found; using a single shell CPU worker for a short test."
  timeout "$DURATION" bash -c 'while :; do :; done' || status=$?
  status="${status:-0}"
  if [[ "$status" -ne 0 && "$status" -ne 124 ]]; then exit "$status"; fi
fi
echo "CPU test finished. Check CloudWatch after metrics and alarm evaluation update."
