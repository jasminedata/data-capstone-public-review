#!/bin/bash
set -xe

dnf install -y httpd

systemctl enable httpd
systemctl start httpd

echo "<h1>Frontend Healthy - $(hostname)</h1>" > /var/www/html/index.html
