# Troubleshooting

## No EC2 metrics appear
- Confirm you are viewing the same AWS region as the instance.
- Select EC2 → Per-Instance Metrics and the correct instance dimension.
- Wait for the metric publication interval; basic monitoring is typically 5-minute resolution.
- Confirm the instance has been running long enough to publish data.

## Alarm remains INSUFFICIENT_DATA
- Wait for enough datapoints to arrive.
- Confirm the selected metric and instance ID are correct.
- Review the alarm's period, evaluation periods and missing-data treatment.

## SNS email not received
- Check spam/junk folders.
- Confirm the subscription status is Confirmed.
- Ensure the alarm action points to the correct SNS topic.
- Check that the alarm actually transitioned into the configured state; notifications are generally sent on state changes.

## CPU alarm does not trigger
- Confirm the test is running on the monitored instance.
- Check the CPU metric graph and threshold.
- Wait for the alarm evaluation window.
- A short load may not exceed a 5-minute average threshold. Do not run a long load just to force an alarm.

## Dashboard shows no data
- Check the dashboard region and selected instance dimension.
- Verify the widget uses namespace AWS/EC2 and correct metric name.
- Ensure the selected time range includes when the instance was running.
