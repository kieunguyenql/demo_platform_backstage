module "demo_vpc" {
  source = "../modules/vpc"
  vpc_config = {
    vpc_name = "demo_backstage"
    cidr_block  = "10.80.0.0/16"
    subnet_bits = 4
  }
}

