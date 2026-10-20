variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the security groups are created"
}

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
  description = "Name of the public HTTP security group (used by the load balancer)"
}

variable "private_http_security_group_name" {
  type        = string
  description = "Name of the private HTTP security group (used by the instances)"
}

variable "tags" {
  type        = map(string)
  description = "Tags added to all resources of the module"
}
