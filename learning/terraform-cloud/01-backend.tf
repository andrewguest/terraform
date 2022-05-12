terraform {
  backend "remote" {
    organization = "example-org-c08766"

    workspaces {
      name = "getting-started"
    }
  }
}