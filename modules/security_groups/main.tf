# Bastion Security Group
resource "aws_security_group" "bastion" {
  name        = "${var.name_prefix}-Bastion-SG"
  description = "Security group for bastion host (restricted SSH)"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access from trusted IP or VPN"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.bastion_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Bastion-SG"
    }
  )
}

# Frontend Security Group (PRIVATE)
resource "aws_security_group" "frontend" {
  name        = "${var.name_prefix}-Frontend-SG"
  description = "Security group for frontend instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from bastion host only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description = "HTTP traffic (from ALB later)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]

  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Frontend-SG"
    }
  )
}

# Backend Security Group (PRIVATE)
resource "aws_security_group" "backend" {
  name        = "${var.name_prefix}-Backend-SG"
  description = "Security group for backend instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH from bastion host only"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description = "HTTP from private subnets (frontend + internal NLB health checks)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
  }


  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Backend-SG"
    }
  )
}
# ALB Security Group (Public)
resource "aws_security_group" "alb" {
  name        = "${var.name_prefix}-ALB-SG"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-ALB-SG"
    }
  )
}
