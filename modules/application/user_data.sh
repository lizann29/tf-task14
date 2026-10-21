#!/bin/bash
# Runs once, when the instance starts for the first time.

# 1. Install and start the web server
dnf install -y httpd jq
systemctl enable --now httpd

# 2. Read instance metadata with IMDSv2 (get a token first, then use it)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
COMPUTE_INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)

# 3. Unique machine UUID of this instance
COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')

# 4. Write the page
echo "This message was generated on instance ${COMPUTE_INSTANCE_ID} with the following UUID ${COMPUTE_MACHINE_UUID}" > /var/www/html/index.html
