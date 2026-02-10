data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "bastion" {
  name_prefix   = "${var.name_prefix}-Bastion-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  network_interfaces {
    security_groups = [var.bastion_sg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.common_tags,
      {
        Name = "${var.name_prefix}-BastionHost"
      }
    )
  }
}

#FRONTEND LAUNCH TEMPLATE
resource "aws_launch_template" "frontend" {
  name_prefix   = "${var.name_prefix}-Frontend-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  network_interfaces {
    security_groups = [var.frontend_sg_id]
  }

  # USER DATA: FRONTEND
  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Install Apache
    yum update -y
    yum install -y httpd

    # Start Apache
    systemctl start httpd
    systemctl enable httpd

    # Backend URL (resolved at runtime)
   BACKEND_URL="http://$BACKEND_URL/api.json"

    # Enable CGI in Apache
    echo "AddHandler cgi-script .sh" >> /etc/httpd/conf/httpd.conf
    echo "DirectoryIndex /cgi-bin/fetch_backend.sh" >> /etc/httpd/conf/httpd.conf
    chmod 755 /etc/httpd/conf/httpd.conf
    systemctl restart httpd

    # Create CGI script to dynamically fetch backend response
    mkdir -p /var/www/cgi-bin
    cat <<'CGIEOF' > /var/www/cgi-bin/fetch_backend.sh
    #!/bin/bash
    echo "Content-type: text/html"
    echo ""
    echo "<html><head><title>Frontend</title></head><body>"
    echo "<h1>Frontend Server - \\$(hostname)</h1>"
    echo "<h2>Backend Response:</h2>"
    echo "<pre>\\$(curl -s \\$BACKEND_URL)</pre>"
    echo "</body></html>"
    CGIEOF

    chmod +x /var/www/cgi-bin/fetch_backend.sh

    # Restart Apache
    systemctl restart httpd
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.common_tags,
      {
        Name = "${var.name_prefix}-Frontend"
      }
    )
  }
}

# BACKEND LAUNCH TEMPLATE
resource "aws_launch_template" "backend" {
  name_prefix   = "${var.name_prefix}-Backend-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  network_interfaces {
    security_groups = [var.backend_sg_id]
  }

  # USER DATA: BACKEND
  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Install Apache
    yum update -y
    yum install -y httpd

    # Start Apache
    systemctl start httpd
    systemctl enable httpd

    # Create backend API response
    cat <<APIEOF > /var/www/html/api.json
    {"status": "success", "backend": "\\$(hostname)", "timestamp": "\\$(date)"}
    APIEOF

    echo "Backend Server \\$(hostname) is healthy" >> /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.common_tags,
      {
        Name = "${var.name_prefix}-Backend"
      }
    )
  }
}
