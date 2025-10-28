# System Health Monitor

A simple Bash script that logs CPU, memory, disk usage and uptime.
If usage goes above set limits, it sends an email alert.
Runs automatically with cron (every 10 minutes by default).

---

## Why I built it
To practise shell scripting, cron automation, and basic system monitoring.

---

### Features
- Logs CPU, memory, disk and uptime
- Configurable thresholds
- Email alerts via msmtp
- Works on macOS and Linux (small command differences)

---

### Run locally
```bash
chmod +x system_health_monitor.sh     # makes the script executable
bash system_health_monitor.sh         # runs it manually
tail -n 5 system_health.log           # shows the last 5 lines of the log file
```
Example output:
```bash
[Sun 26 Oct 2025 09:22:14 GMT] CPU: 2.33% | MEM: 97.95% | DISK: 4% | Uptime: 34 days, 22:23
```
---

### Cron example
Runs the script automatically every 10 minutes to log system health in the background.
```bash
*/10 * * * * /Users/<you>/Documents/devops-projects/system-health-monitor/system_health_monitor.sh >> /Users/<you>/Documents/devops-projects/system-health-monitor/cron_output.log 2>&1
```
---

### Email setup
Configure ~/.msmtprc with your SMTP credentials and test:
```bash
echo "test" | msmtp your@email.com
```
---

### Next steps
- Add Slack/S3 integration
- Port metrics to Grafana/Prometheus later
#DevOps #Bash #Automation #Linux #LearningInPublic