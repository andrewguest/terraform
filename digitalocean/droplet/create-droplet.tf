terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.19.0"
    }
  }
}

// settings specifically for setting up the 'digitalocean' provider
provider "digitalocean" {
  // pass a DigitalOcean API key for the 'token'
  // read the value from the 'variables.tfvars' file to prevent putting sensitive information here
  token = var.digitalocean_token
}

// the resource to create and it's specs
resource "digitalocean_droplet" "terraform_droplet" {
  image = "ubuntu-18-04-x64"
  name = "terraform-droplet-1"
  region = "nyc1"
  size = "s-1vcpu-1gb"
}

