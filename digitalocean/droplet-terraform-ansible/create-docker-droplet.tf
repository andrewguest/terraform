terraform {
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.19.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

# get the SSH key with the name of 'Gaming PC'
data "digitalocean_ssh_key" "windows" {
  name = "Gaming PC"
}

data "digitalocean_ssh_key" "wsl2" {
  name = "Gaming PC - wsl"
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "docker-droplet" {
  image  = "ubuntu-20-04-x64"
  name   = "docker-droplet-1"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  # Use the id of the SSH key we got earlier when setting up the new droplet
  ssh_keys = [
      data.digitalocean_ssh_key.windows.id,
      data.digitalocean_ssh_key.wsl2.id
  ]

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key)
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.private_key} -e 'pub_key=${var.public_key}' docker-install.yml"
  }
}

output "droplet_ip_address" {
  value = digitalocean_droplet.docker-droplet.ipv4_address
}
