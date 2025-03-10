terraform {
  required_providers {
    crczp = {
      source  = "cyberrangecz/crczp"
      version = ">= 0.1.0"
    }
  }
}

provider "crczp" {
  endpoint = "https://your.crczp.ex"
}

module "sandbox" {
  source      = "cyberrangecz/sandbox/crczp"
  project_url = "https://github.com/cyberrangecz/library-junior-hacker.git"
  rev         = "master"
}
