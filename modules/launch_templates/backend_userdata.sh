#!/bin/bash
set -xe

dnf install -y httpd

systemctl enable httpd
systemctl start httpd

echo '{"status":"success","backend":"'"$(hostname)"'","timestamp":"'"$(date)"'"}' > /var/www/html/api.json

echo "<h1>Backend Healthy - $(hostname)</h1>" > /var/www/html/index.html
