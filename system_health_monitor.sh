#!/bin/bash

# Simple System Health Monitor for macOS/Linux

CPU_USAGE=$(top -l 1 | awk '/CPU usage/ {print $3}' | sed 's/%//')
MEM_USAGE=$(vm_stat | awk '/Pages active/ {active=$3} /Pages free/ {free=$3} END {printf("%.2f"), (active / (active + free)) * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
UPTIME=$(uptime | sed -E 's/.* up ([^,]+,[^,]+),.*/\1/')
ALERT_EMAIL="abdifatahyh@gmail.com"

MSMTP="/opt/homebrew/bin/msmtp"

send_alert () {
  local subject="$1"
  local body="$2"
  /bin/cat <<EOF | "$MSMTP" -t
To: $ALERT_EMAIL
From: $ALERT_EMAIL
Subject: $subject
Content-Type: text/plain; charset=UTF-8

$body

$(hostname) • $(date)
EOF
}

LOGFILE="./system_health.log"
THRESHOLD_CPU=80
THRESHOLD_MEM=90

echo "[$(date)] CPU: ${CPU_USAGE}% | MEM: ${MEM_USAGE}% | DISK: ${DISK_USAGE}% | Uptime: ${UPTIME}" >> $LOGFILE


if (( ${CPU_USAGE%.*} > THRESHOLD_CPU )); then
  MESSAGE="High CPU usage detected: ${CPU_USAGE}% at $(date)"
  echo "[$(date)] WARNING: $MESSAGE" >> "$LOGFILE"
  send_alert "[ALERT] High CPU on $(hostname)" "$MESSAGE"
fi


ENABLE_MEM_ALERT=false   # set true later on Linux server


if [ "$ENABLE_MEM_ALERT" = true ]; then
 if (( ${MEM_USAGE%.*} > THRESHOLD_MEM )); then
   MESSAGE="High Memory usage detected: ${MEM_USAGE}% at $(date)"
   echo "[$(date)] WARNING: $MESSAGE" >> "$LOGFILE"
   send_alert "[ALERT] High Memory on $(hostname)" "$MESSAGE"
 fi
fi
