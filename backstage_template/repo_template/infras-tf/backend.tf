terraform {
  backend "s3" {
    bucket         = "demo-backstage-techdocs"
    region         = "ap-southeast-2"
    key            = "terraform/test-backstage.tfstate"
  }
}
