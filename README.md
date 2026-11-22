# AWS CloudWatch Monitoring Project (Console-Based)

A beginner-friendly AWS portfolio lab that monitors an Amazon EC2 Linux instance using Amazon CloudWatch metrics, a dashboard, alarms, and optional SNS email notifications. The lab is completed through the AWS Management Console; **Terraform is not required**.

> **Honest portfolio rule:** This repository is a ready-to-use lab kit. It is not proof of a completed deployment. Add genuine screenshots and test results from your own AWS account after performing the lab.

## Project objectives
- Launch a small EC2 Linux test instance.
- Review built-in CloudWatch EC2 metrics such as CPUUtilization, NetworkIn, NetworkOut and StatusCheckFailed.
- Create a CloudWatch dashboard.
- Configure CPU and instance status-check alarms.
- Send alarm notifications using an SNS email subscription.
- Trigger a controlled test and verify alarm state changes.

![Architecture](architecture/aws-cloudwatch-monitoring.png)

## AWS services and skills
Amazon EC2, Amazon CloudWatch Metrics, CloudWatch Alarms, CloudWatch Dashboards, Amazon SNS, IAM, Linux and basic shell commands.

## Repository structure
```text
aws-cloudwatch-monitoring-project/
├── README.md
├── architecture/
│   └── aws-cloudwatch-monitoring.png
├── docs/
│   ├── LAB_GUIDE.md
│   ├── SCREENSHOT_CHECKLIST.md
│   ├── TEST_REPORT_TEMPLATE.md
│   ├── TROUBLESHOOTING.md
│   └── INTERVIEW_QA.md
├── sample-data/
│   └── monitoring-notes.txt
├── scripts/
│   ├── cpu-load-test.sh
│   └── system-health.sh
└── .gitignore
```

## Prerequisites
- AWS account with access to EC2, CloudWatch and SNS.
- AWS Management Console access.
- One AWS region selected for the entire lab.
- Email address that you can verify for SNS notifications.

## Quick start
1. Read `docs/LAB_GUIDE.md`.
2. Launch a small Amazon Linux EC2 instance.
3. Confirm EC2 basic metrics appear in CloudWatch.
4. Create a CloudWatch dashboard with CPU, network and status-check widgets.
5. Create an SNS topic and confirm its email subscription.
6. Create a CPU alarm and an instance status-check alarm.
7. Run the optional controlled CPU test and observe alarm behavior.
8. Fill in the test report and add genuine screenshots.
9. Delete lab resources and alarms when finished.

## Success criteria
- EC2 metrics visible in CloudWatch.
- Dashboard displays the selected instance metrics.
- SNS subscription status is Confirmed.
- CPU alarm enters ALARM during a controlled load test (timing depends on metric period and threshold), then returns to OK after load stops.
- Status-check alarm is configured and visible.

## Cost and safety
- EC2 runtime, EBS storage, CloudWatch alarms, dashboards, custom metrics, and SNS usage may incur charges depending on region, account and current pricing.
- This lab uses basic EC2 metrics; detailed monitoring and custom metrics may have additional charges.
- Do not run CPU load for long periods. Use the script briefly and stop it after the test.
- Do not publish email addresses, AWS account IDs, public IPs, credentials, private keys or unredacted screenshots.
- Configure billing alerts and review AWS Pricing before starting.

## Resume bullet (only after actual completion)
**Configured Amazon CloudWatch monitoring for an EC2 Linux instance by building a metrics dashboard, setting CPU and instance status-check alarms, integrating SNS email notifications, and validating alarm behavior through a controlled load test.**

## License
MIT
