provider "aws" {
  region = "us-west-2"
  assume_role {
    role_arn = "arn:aws:iam::994653047345:role/rizwan-sts-role"
  }
}