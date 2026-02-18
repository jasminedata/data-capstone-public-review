# IAM Role for EC2 Instances
resource "aws_iam_role" "ec2_role" {
  name = "${var.name_prefix}-EC2-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-EC2-Role"
    }
  )
}

data "aws_iam_policy_document" "cloudwatch_tag_read" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:ListTagsForResource",
      "logs:ListTagsForResource",
      "tag:GetResources",
      "tag:GetTagKeys",
      "tag:GetTagValues"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_tag_read" {
  name        = "${var.name_prefix}-CloudWatchTagRead"
  description = "Allows CloudWatch and Logs tag metadata reads in console"
  policy      = data.aws_iam_policy_document.cloudwatch_tag_read.json

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-CloudWatchTagRead"
    }
  )
}

# Attach SSM Policy
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Attach CloudWatch Agent Policy
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_user_policy_attachment" "console_user_cloudwatch_readonly" {
  count = var.console_iam_user_name != null ? 1 : 0

  user       = var.console_iam_user_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "console_user_cloudwatch_tag_read" {
  count = var.console_iam_user_name != null ? 1 : 0

  user       = var.console_iam_user_name
  policy_arn = aws_iam_policy.cloudwatch_tag_read.arn
}

resource "aws_iam_role_policy_attachment" "console_role_cloudwatch_readonly" {
  count = var.console_iam_role_name != null ? 1 : 0

  role       = var.console_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "console_role_cloudwatch_tag_read" {
  count = var.console_iam_role_name != null ? 1 : 0

  role       = var.console_iam_role_name
  policy_arn = aws_iam_policy.cloudwatch_tag_read.arn
}

# EC2 Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name_prefix}-EC2-InstanceProfile"
  role = aws_iam_role.ec2_role.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-EC2-InstanceProfile"
    }
  )
}
