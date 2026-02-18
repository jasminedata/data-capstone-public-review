#!/bin/bash
set -xe

yum install -y httpd

systemctl enable httpd
systemctl start httpd

BACKEND_URL="http://${backend_nlb_dns_name}/api.json"

# Enable CGI so backend is fetched at request time (not only at boot).
cat <<'EOF' > /etc/httpd/conf.d/cgi.conf
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
<Directory "/var/www/cgi-bin">
    AllowOverride None
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
    Require all granted
    AddHandler cgi-script .sh
</Directory>
EOF

mkdir -p /var/www/cgi-bin
cat <<EOF > /var/www/cgi-bin/fetch_backend.sh
#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Frontend App</title></head><body>"
echo "<h1>Frontend Server - \$(hostname)</h1>"
echo "<h2>Backend Response:</h2>"
echo "<pre>"
if RESPONSE=\$(curl -fsS --max-time 5 "$BACKEND_URL" 2>&1); then
  echo "\$RESPONSE"
else
  echo "Backend request failed"
  echo "\$RESPONSE"
fi
echo "</pre>"
echo "</body></html>"
EOF
chmod +x /var/www/cgi-bin/fetch_backend.sh

# Keep / and /app.html for easy access, redirect to dynamic CGI page.
cat <<'EOF' > /var/www/html/index.html
<html><head><meta http-equiv="refresh" content="0; url=/cgi-bin/fetch_backend.sh"></head><body></body></html>
EOF
cat <<'EOF' > /var/www/html/app.html
<html><head><meta http-equiv="refresh" content="0; url=/cgi-bin/fetch_backend.sh"></head><body></body></html>
EOF

systemctl restart httpd
