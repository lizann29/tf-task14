output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.network.public_subnet_ids
}

output "security_group_ids" {
  description = "IDs of the SSH, public HTTP and private HTTP security groups"
  value = {
    ssh          = module.network_security.ssh_security_group_id
    public_http  = module.network_security.public_http_security_group_id
    private_http = module.network_security.private_http_security_group_id
  }
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer (open it in a browser)"
  value       = module.application.load_balancer_dns_name
}
