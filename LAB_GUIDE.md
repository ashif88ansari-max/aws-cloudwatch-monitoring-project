# Hands-on Lab Guide — EC2 Monitoring with Amazon CloudWatch

**Method:** AWS Management Console, with optional Linux commands. No Terraform required.

## Part 1 — Launch an EC2 Linux instance
1. Sign in to AWS Console and select a region.
2. Open EC2 → Instances → Launch instances.
3. Name: `cloudwatch-monitoring-lab`.
4. Select an Amazon Linux image and a small instance type available to your account. Review pricing first.
5. Choose a key pair only if you need SSH. Keep the private key private.
6. For SSH, restrict inbound TCP 22 to your current public IP. Do not use `0.0.0.0/0`.
7. Launch and wait for instance status checks to pass.
8. Copy the Instance ID for your own notes; do not publish it publicly.

## Part 2 — View built-in CloudWatch metrics
1. Open CloudWatch → Metrics → All metrics.
2. Select EC2 → Per-Instance Metrics.
3. Find your instance ID.
4. Select CPUUtilization, NetworkIn and NetworkOut. Also find StatusCheckFailed if available.
5. Set a useful time range such as 1 hour.
6. Note that basic EC2 metrics are normally published at 5-minute intervals. Detailed monitoring can provide 1-minute metrics and may incur additional charges.

## Part 3 — Create a CloudWatch dashboard
1. Open CloudWatch → Dashboards → Create dashboard.
2. Dashboard name: `EC2-Monitoring-Lab`.
3. Add a Line widget for CPUUtilization.
4. Add a Line widget for NetworkIn and NetworkOut.
5. Add a Number or Line widget for StatusCheckFailed, if offered.
6. Select the correct region, namespace `AWS/EC2`, and your EC2 instance dimension.
7. Save the dashboard.
8. Arrange widgets clearly and capture a screenshot.

## Part 4 — Create SNS email notifications
1. Open Amazon SNS → Topics → Create topic.
2. Type: Standard.
3. Name: `ec2-monitoring-alerts`.
4. Create the topic.
5. Open the topic and choose Create subscription.
6. Protocol: Email. Endpoint: an email address you control.
7. Create the subscription.
8. Open your inbox and click the AWS confirmation link. The subscription must show Confirmed.
9. Keep the email private in screenshots or redact it before publishing.

## Part 5 — Create a CPU utilization alarm
1. Open CloudWatch → Alarms → All alarms → Create alarm.
2. Select metric → EC2 → Per-Instance Metrics → CPUUtilization for your instance.
3. Statistic: Average.
4. Period: 5 minutes (or the period matching your available metric resolution).
5. Threshold type: Static.
6. Condition: Greater than or equal to `70` percent.
7. Configure missing data as `Treat missing data as missing` where available.
8. Under Notifications, select the SNS topic `ec2-monitoring-alerts` for the ALARM state.
9. Alarm name: `monitoring-lab-high-cpu`.
10. Create the alarm.
11. If the alarm shows INSUFFICIENT_DATA initially, wait for metrics to arrive. This is normal for a new alarm.

## Part 6 — Create an EC2 status-check alarm
1. Create another alarm from CloudWatch metrics.
2. Select EC2 → Per-Instance Metrics → StatusCheckFailed for your instance.
3. Statistic: Maximum; use a suitable period such as 5 minutes.
4. Condition: Greater than or equal to `1`.
5. Send ALARM notifications to the same SNS topic.
6. Name: `monitoring-lab-status-check-failed`.
7. Create the alarm.

## Part 7 — Controlled CPU alarm test (optional)
Only run this briefly on your own test instance. It can increase resource usage and charges.
1. Connect to your Linux EC2 instance.
2. Upload or create `scripts/cpu-load-test.sh`, then run:
   ```bash
   chmod +x cpu-load-test.sh
   ./cpu-load-test.sh 180
   ```
3. The script attempts to use `stress-ng` if already installed; otherwise it uses a short-lived shell CPU loop. Do not install packages from untrusted sources.
4. Watch CloudWatch CPUUtilization and the CPU alarm. Basic metrics may take several minutes to appear.
5. Stop the test after the configured duration. If needed, press Ctrl+C.
6. Wait for CPU to drop and the alarm to return to OK. Alarm state transitions can lag behind actual CPU usage.

If the instance type has very low CPU capacity or the threshold is not reached, use the metric graph and adjust the test duration carefully. Do not run a prolonged load.

## Part 8 — Verify notifications and record results
- Confirm SNS subscription is Confirmed.
- Check the inbox for an alarm notification when the alarm enters ALARM.
- Confirm alarm returns to OK after the load stops.
- Fill `TEST_REPORT_TEMPLATE.md`.

## Part 9 — Cleanup
1. Stop or terminate the test EC2 instance when finished.
2. Delete the CloudWatch alarms.
3. Delete the dashboard if no longer needed.
4. Delete the SNS subscription and topic.
5. Check for leftover EBS volumes, snapshots or other billable resources.
6. Review AWS Billing and Cost Explorer.

Deleting an EC2 instance does not automatically remove every related CloudWatch alarm, dashboard or SNS topic. Clean up each item separately.
