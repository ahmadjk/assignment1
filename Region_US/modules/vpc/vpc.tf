variable "ENV" {}
variable "AWS_REGION" {}

module "main-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENV}"
  cidr = "192.168.0.0/24"

  azs             = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  public_subnets  = ["192.168.1.0/27", "192.168.2.0/27", "192.168.3.0/27", "192.168.4.0"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "${var.ENV}"
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.main-vpc.vpc_id}"
}

#output "private_subnets" {
 #description = "List of IDs of private subnets"
  #value       = ["${module.main-vpc.private_subnets}"]
#}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.main-vpc.public_subnets}"]
}
