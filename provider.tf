terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.2.0"
        }
    }

    backend "s3" {
    bucket = "expense-docker-ec2"
    key = "docker_ec2_info"
    dynamodb_table = "state-locking"
    region = "us-east-1"

    }
  
}


provider "aws" {
    region = "us-east-1"

}
