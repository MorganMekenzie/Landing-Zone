terraform {
  backend "s3" {
    bucket = "ta-challenge-wp-team-4"
    key    = "sprint1/week1/CanaryApp-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}