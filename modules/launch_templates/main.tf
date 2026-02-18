data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
# BASTION
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
    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-BastionHost"
    })
  }
}
# FRONTEND
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

  user_data = base64encode(
  templatefile("${path.module}/frontend_userdata.sh.tftpl", {
    backend_nlb_dns_name = var.backend_nlb_dns_name
  })
)
  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-Frontend"
    })
  }
}
# BACKEND
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

  user_data = base64encode(
    file("${path.module}/backend_userdata.sh")
  )

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = "${var.name_prefix}-Backend"
    })
  }
}
