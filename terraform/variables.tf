// provider vars
variable "project" {
  description = "GCP project"
}
variable "project_number" {
  description = "The project number to host the cluster in"
}

variable "host_project" {
  description = "The host project's GCP name."
}

variable "region" {
  description = "The GCP region used for deployments ('europe-west3' for all stages)."
  type        = string
}
variable "zone" {
  description = "The GCP zone within the region used for deployments ('europe-west3-c' for all stages). Gets obsolete when resources are deployed on region level."
  type        = string
}

variable "primary_region" {
  description = "The primary region to be used"
}
variable "primary_zones" {
  description = "The primary zones to be used"
}
variable "secondary_region" {
  description = "The secondary region to be used"
}
variable "secondary_zones" {
  description = "The secondary zones to be used"
}