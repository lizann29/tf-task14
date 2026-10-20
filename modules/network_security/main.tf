# Rules are defined inline (ingress/egress blocks), so the module creates only aws_security_group resources.
# Terraform-created security groups have no outbound rules by default, so each group gets an egress block:
# instances need outbound access to install httpd, the load balancer needs it to reach the instances.

resource "aws_security_group" "ssh" {
  name        = var.ssh_security_group_name
  description = "Allows SSH from allowed IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from allowed IP ranges"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.ssh_security_group_name })
}

resource "aws_security_group" "public_http" {
  name        = var.public_http_security_group_name
  description = "Allows HTTP from allowed IP ranges to the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from allowed IP ranges"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.public_http_security_group_name })
}

resource "aws_security_group" "private_http" {
  name        = var.private_http_security_group_name
  description = "Allows HTTP to instances only from the public HTTP security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from the public HTTP security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = var.private_http_security_group_name })
}
