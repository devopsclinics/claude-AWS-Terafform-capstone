
# Call VPC modules
module "capstone" {
    source = "./modules/vpc"
    name = var.name
    region = var.region
    vpc_cidr = var.vpc_cidr
    az1 = var.az1
    az2 = var.az2
    public_subnet_cidr_az1 = var.public_subnet_cidr_az1
    public_subnet_cidr_az2 = var.public_subnet_cidr_az2
    private_subnet_cidr_az1_1 = var.private_subnet_cidr_az1_1
    private_subnet_cidr_az1_2 = var.private_subnet_cidr_az1_2
    private_subnet_cidr_az2_1 = var.private_subnet_cidr_az2_1
    private_subnet_cidr_az2_2 = var.private_subnet_cidr_az2_2
    private_db_subnet_cidr_az1 = var.private_db_subnet_cidr_az1
    private_db_subnet_cidr_az2 = var.private_db_subnet_cidr_az2


  
}
# Call module
