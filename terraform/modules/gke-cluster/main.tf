locals {

  #entire day only on mondays maintenance
  maintenance_start_time_dev = "2023-01-01T00:00:00Z"
  maintenance_end_time_dev   = "2023-01-02T00:00:00Z"
  maintenance_recurrence_dev = "FREQ=WEEKLY;BYDAY=MO"
  release_channel_dev        = "REGULAR"
  
  maintenance_start_time = "2023-01-01T06:00:00Z"
  maintenance_end_time   = "2023-01-01T12:00:00Z"
  maintenance_recurrence = "FREQ=WEEKLY;BYDAY=WE,TH"
  release_channel        = "STABLE"

  node_pools = [
    {
      name         = "default-pool"
      autoscaling  = true
      auto_repair  = true
      auto_upgrade = true

      min_count          = 3
      max_count          = 4
      initial_node_count = 3

      machine_type      = "e2-highcpu-8"
      image_type        = "COS_CONTAINERD"
      disk_type         = "pd-standard"
      disk_size         = "25"
      boot_disk_kms_key = var.compute_cmek_id

    }
  ]
  node_pools_labels = {
  }

  node_pools_taints = {
  }
  node_pools_tags = {
    all = ["api-gateway-to-gcp"]
  }
}
data "google_client_config" "default" {}

data "google_project" "project" {
  project_id = var.project
}


module "cluster" {
  name       = var.name
  project_id = var.project
  source                        = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"

  regional                      = false
  region                        = var.region
  network_project_id            = var.host_project
  network                       = var.network
  subnetwork                    = var.subnetwork
  ip_range_pods                 = var.project == "bdaa-ctda-kg-dev-sc-rkf7q" ? "ctda-kg-pod-range" : "pod-range-01"
  ip_range_services             = var.project == "bdaa-ctda-kg-dev-sc-rkf7q" ? "ctda-kg-svc-range" : "svc-range-01"
  zones                         = var.zones
  horizontal_pod_autoscaling    = true
  http_load_balancing           = true
  network_policy                = false
  deploy_using_private_endpoint = true
  enable_private_endpoint       = true
  enable_private_nodes          = true
  enable_binary_authorization   = true
  master_ipv4_cidr_block        = var.master_ipv4_cidr_block
  cluster_resource_labels       = { "mesh_id" : "proj-${data.google_project.project.number}" }
  remove_default_node_pool      = true
  logging_service               = "logging.googleapis.com/kubernetes"
  default_max_pods_per_node     = 110

  release_channel        = local.release_channel
  maintenance_start_time = local.maintenance_start_time
  maintenance_end_time   = local.maintenance_end_time
  maintenance_recurrence = local.maintenance_recurrence

  database_encryption = [
    {
      key_name : var.kubernetes_cmek_id,
      state : "ENCRYPTED"
    }
  ]


  node_pools = local.node_pools

  node_pools_labels = local.node_pools_labels
  node_pools_taints = local.node_pools_taints
  node_pools_tags   = local.node_pools_tags

  master_authorized_networks = [{
    cidr_block   = var.master_authorized_networks_block
    display_name = "PRIMARY"
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

}
