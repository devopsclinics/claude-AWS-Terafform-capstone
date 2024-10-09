module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-east-1a", "eu-east-1b"]
*/Web Tier private_subneta and private_subnetb */
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  #App Tier private_subnetc and private_subnetd
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
*/DB Tier private_subnete and private_subnetf
  private_subnets = ["10.0.5.0/24", "10.0.6.0/24"]
*/AZ1 pub_subneta and Az2 pub_subnetb
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
