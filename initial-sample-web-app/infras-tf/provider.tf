provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      Owner           = "fpt_kieunv"
      Terraform       = true
      Workload        = "demo_backstage"
    }
  }
}