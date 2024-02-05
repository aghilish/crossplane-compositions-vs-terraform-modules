module "gke_primary" {
  source                 = "./modules/gke-cluster"
  project                = var.project
  region                 = var.primary_region
  zones                  = var.primary_zones
  kubernetes_cmek_id     = var.kubernetes_cmek_id_primary
  compute_cmek_id        = var.compute_cmek_id_primary
  name                   = "primary"
  host_project           = var.host_project
  network                = var.svpc_network
  subnetwork             = var.svpc_subnet_primary
  master_ipv4_cidr_block = "172.16.1.0/28"

  master_authorized_networks_block  = var.svpc_iprange_primary
  master_authorized_networks_block2 = var.svpc_iprange_secondary
}