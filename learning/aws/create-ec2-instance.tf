// The terraform {} block contains Terraform settings, including the required providers Terraform will use to provision the infrastructure.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

// The provider block configures the specified provider, in this case AWS. A provider is a plugin that Terraform uses to create and manage resources.
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

/*
Resource blocks have two strings before the block:
	- The resource type (aws_instance)
	- The resource name (app_server)
Together, the resource type and name for a unique ID for the resource (in this case: aws_instance.app_server)

Resource blocks contain arguments which are used to configure the resource.
*/
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    "Name" = "ExampleAppServerInstance"
  }
}
