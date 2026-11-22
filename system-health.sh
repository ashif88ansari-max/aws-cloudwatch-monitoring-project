#!/usr/bin/env bash
set -euo pipefail
echo "===== SYSTEM HEALTH ====="
date -u
echo "--- Hostname ---"
hostname
echo "--- Uptime ---"
uptime
echo "--- Memory ---"
free -h || true
echo "--- Disk ---"
df -h /
echo "--- Top CPU processes ---"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
