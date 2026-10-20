variable "aws_region" {
  type        = string
  description = "AWS region where all resources are created"
}

variable "project_id" {
  type        = string
  description = "Project ID used for tagging"
}

# --- network module ---
variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the VPC"
}

variable "public_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  description = "Public subnets: name, CIDR block and availability zone for each"
}

variable "igw_name" {
  type        = string
  description = "Name of the Internet Gateway"
}

variable "route_table_name" {
  type        = string
  description = "Name of the public route table"
}

# --- network_security module ---
variable "allowed_ip_range" {
  type        = list(string)
  description = "IP ranges (CIDR) allowed to reach SSH and the public HTTP endpoint"
}

variable "ssh_security_group_name" {
  type        = string
  description = "Name of the SSH security group"
}

variable "public_http_security_group_name" {
  type        = string
  description = "Name of the public HTTP security group"
}

variable "private_http_security_group_name" {
  type        = string
  description = "Name of the private HTTP security group"
}

# --- application module ---
variable "launch_template_name" {
  type        = string
  description = "Name of the launch template"
}

variable "asg_name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the Application Load Balancer"
}

variable "target_group_name" {
  type        = string
  description = "Name of the load balancer target group"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ami_filter" {
  type = object({
    name   = string
    values = list(string)
  })
  description = "Filter used to find the latest Amazon Linux 2023 AMI (filter name and values)"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances in the Auto Scaling Group"
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances in the Auto Scaling Group"
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances in the Auto Scaling Group"
}
