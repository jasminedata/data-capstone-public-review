resource "aws_autoscaling_group" "this" {
  name_prefix         = "${var.name_prefix}-asg-"
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 180

  target_group_arns = var.target_group_arns

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  dynamic "tag" {
    for_each = var.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# SCALE OUT: CPU >= 40% for 1 minute
resource "aws_autoscaling_policy" "scale_out" {
  count = var.enable_scaling_policies ? 1 : 0

  name                   = "${var.name_prefix}-scale-out"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count = var.enable_scaling_policies ? 1 : 0

  alarm_name          = "${var.name_prefix}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 40

  alarm_actions = [aws_autoscaling_policy.scale_out[0].arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}

# SCALE IN: CPU <= 10% for 1 minute
resource "aws_autoscaling_policy" "scale_in" {
  count = var.enable_scaling_policies ? 1 : 0

  name                   = "${var.name_prefix}-scale-in"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count = var.enable_scaling_policies ? 1 : 0

  alarm_name          = "${var.name_prefix}-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 10

  alarm_actions = [aws_autoscaling_policy.scale_in[0].arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}
