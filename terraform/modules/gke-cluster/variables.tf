variable "project" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to be used"
}
variable "zones" {
  description = "The zones to be used"
}

variable "name" {
  description = "The name to be used"
}

variable "host_project" {
  description = "The host project's GCP name."
}

variable "network" {
  description = "The network to be used"
}

variable "subnetwork" {
  description = "The subnetwork to be used"
}

variable "master_ipv4_cidr_block" {
  description = "The master cidr to be used"
}

variable "master_authorized_networks_block" {
  description = "The master authorised network to be used"
}

variable "master_authorized_networks_block2" {
  description = "The master authorised network to be used"
}

variable "kubernetes_cmek_id" {
  description = "The fully qualified name of the encryption key used for securing the kuberenetes database."
}

variable "compute_cmek_id" {
  description = "The fully qualified name of the encryption key used for securing the node pools."
}