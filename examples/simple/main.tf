terraform {
  required_providers {
    kypo = {
      source  = "vydrazde/kypo"
      version = ">= 0.1.0"
    }
  }
}

provider "kypo" {
  endpoint  = "https://your.kypo.ex"
  client_id = "xxx"
}

module "sandbox" {
  source      = "vydrazde/sandbox/kypo"
  project_url = "https://gitlab.ics.muni.cz/muni-kypo-trainings/games/junior-hacker.git"
  rev         = "master"
}
