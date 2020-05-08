terraform {
  backend "remote" {
    organization = "bgerndt"

    workspaces {
      name = "factorio-tf"
    }
  }
}