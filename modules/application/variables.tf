variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the target group is created"
}

variable "subnet_ids" {
  type        = list(string)
  description = "IDs of the subnets for the load balancer and the instances"
}

variable "instance_security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to the instances"
}

variable "lb_security_group_id" {
  type        = string
  description = "Security group ID attached to the load balancer"
}

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

variable "tags" {
  type        = map(string)
  description = "Tags added to all resources of the module"
}
