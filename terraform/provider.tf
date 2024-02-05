terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    random = {
      source = "hashicorp/random"
    }

    archive = {
      source = "hashicorp/archive"
    }

    null = {
      source = "hashicorp/null"
    }
  }
  backend "gcs" {}
}



provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project
  region  = var.region
  zone    = var.zone
}


data "google_client_config" "current" {}

data "google_project" "project" {
  project_id = var.project
}

output "project" {
  value = data.google_client_config.current.project
}