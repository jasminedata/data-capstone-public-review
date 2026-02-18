# FRONTEND APPLICATION LOAD BALANCER (ALB)
resource "aws_lb" "frontend_alb" {
  name               = "${var.name_prefix}-Frontend-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Frontend-ALB"
    }
  )
}

# FRONTEND TARGET GROUP (HTTP)
resource "aws_lb_target_group" "frontend_tg" {
  name     = "${var.name_prefix}-Frontend-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id  = var.vpc_id

 health_check {
  path                = "/"
  protocol            = "HTTP"
  matcher             = "200"
  interval            = 30
  healthy_threshold   = 2
  unhealthy_threshold = 2
}


  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Frontend-TG"
    }
  )
}

# FRONTEND ALB LISTENER
resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# BACKEND NETWORK LOAD BALANCER (NLB)
resource "aws_lb" "backend_nlb" {
  name               = "${var.name_prefix}-Backend-NLB"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Backend-NLB"
    }
  )
}

# BACKEND TARGET GROUP (TCP)
resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.name_prefix}-Backend-TG"
  port     = 80
  protocol = "TCP"
  vpc_id  = var.vpc_id

  health_check {
    protocol            = "TCP"
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-Backend-TG"
    }
  )
}

# BACKEND NLB LISTENER
resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}
