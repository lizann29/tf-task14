aws_region = "eu-west-1"
project_id = "cmtr-cn4j86ym"

# --- network module ---
vpc_name = "cmtr-cn4j86ym-vpc"
vpc_cidr = "10.10.0.0/16"

public_subnets = {
  a = {
    name              = "cmtr-cn4j86ym-subnet-public-a"
    cidr_block        = "10.10.1.0/24"
    availability_zone = "eu-west-1a"
  }
  b = {
    name              = "cmtr-cn4j86ym-subnet-public-b"
    cidr_block        = "10.10.3.0/24"
    availability_zone = "eu-west-1b"
  }
  c = {
    name              = "cmtr-cn4j86ym-subnet-public-c"
    cidr_block        = "10.10.5.0/24"
    availability_zone = "eu-west-1c"
  }
}

igw_name         = "cmtr-cn4j86ym-igw"
route_table_name = "cmtr-cn4j86ym-rt"

# --- network_security module ---
allowed_ip_range = ["18.153.146.156/32", "178.134.176.68/32"]

ssh_security_group_name          = "cmtr-cn4j86ym-ssh-sg"
public_http_security_group_name  = "cmtr-cn4j86ym-public-http-sg"
private_http_security_group_name = "cmtr-cn4j86ym-private-http-sg"

# --- application module ---
launch_template_name = "cmtr-cn4j86ym-template"
asg_name             = "cmtr-cn4j86ym-asg"
load_balancer_name   = "cmtr-cn4j86ym-lb"
target_group_name    = "cmtr-cn4j86ym-tg"

instance_type = "t3.micro"

ami_filter = {
  name   = "name"
  values = ["al2023-ami-2023.*-x86_64"]
}

desired_capacity = 2
min_size         = 2
max_size         = 2
