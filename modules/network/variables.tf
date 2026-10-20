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

variable "tags" {
  type        = map(string)
  description = "Tags added to all resources of the module"
}
