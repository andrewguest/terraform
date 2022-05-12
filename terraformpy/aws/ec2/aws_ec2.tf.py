from terraformpy import Provider, Resource


"""
Terraform equivalent:

provider "aws" {
    profile = "default"
    region = "us-west-2"
}

"""
Provider("aws", profile="default", region="us-west-2")


"""
Terraform equivalent:

resource "aws_instance" "example" {
    ami = "ami-830c94e3"
    instance_type = "t2.micro"
}
"""
Resource(
    "aws_instance",
    "example",
    ami="ami-830c94e3",
    instance_type="t2.micro",
    tags={"Name": "FromTerraformpy"},
)
