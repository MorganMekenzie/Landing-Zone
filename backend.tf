terraform {
  backend "s3" {
    bucket = "talent-academy-342623272824-tfstates"
    key    = "sprint1/week1/CanaryApp-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}