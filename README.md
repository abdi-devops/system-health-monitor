# System Health Monitor

A simple Bash script that logs CPU, memory, disk usage and uptime.
If usage goes above set limits, it sends an email alert.
Runs automatically with cron (every 10 minutes by default).

## Why I built it?
To practise shell scripting, cron automation, and basic system monitoring.

### Features
Logs CPU, memory, disk and uptime
Configurable thresholds
Email alerts via msmtp
Works on macOS and Linux (small command differences)

### Run locally
```bash
chmod +x system_health_monitor.sh
bash system_health_monitor.sh
tail -n 5 system_health.log
```

### Cron example
```bash
*/10 * * * * /Users/<you>/Documents/devops-projects/system-health-monitor/system_health_monitor.sh >> /Users/<you>/Documents/devops-projects/system-health-monitor/cron_output.log 2>&1
```

### Email setup
Configure ~/.msmtprc with your SMTP credentials and test:
```bash
echo "test" | msmtp your@email.com
```

### Next steps
Add Slack/S3 integration
Port metrics to Grafana/Prometheus later
#DevOps #Bash #Automation #Linux #LearningInPublic