#!/bin/bash
# Runs once, when the instance starts for the first time.

# 1. Update system packages
dnf update -y

# 2. Install the web server and jq
dnf install -y httpd jq

# 3. Start the web server now and on every boot
systemctl enable --now httpd

# 4. Read instance metadata with IMDSv2 (get a token first, then use it)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

# 5. Write the page
echo "This message was generated on instance ${INSTANCE_ID} with the following IP: ${PRIVATE_IP}" > /var/www/html/index.html
