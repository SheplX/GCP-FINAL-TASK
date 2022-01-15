
resource "google_container_cluster" "cluster-shepl" {
  name       = "shepl-cluster"
  location   = "asia-east1"
  network    = google_compute_network.my_vpc.id
  subnetwork = google_compute_subnetwork.restricted-subnet.id
  
  private_cluster_config {
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_nodes    = true
    enable_private_endpoint = true
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.1.0/24"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/21"
    services_ipv4_cidr_block = "/21"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_service_account" "cluster-sa" {
  account_id   = "service-account-id"
  display_name = "c-service-account"
}

resource "google_project_iam_binding" "cluster-project" {
  project = "gcp-final-338018"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.cluster-sa.email}"
  ]
}

resource "google_container_node_pool" "cluster-nodes" {
  name       = "solo-node"
  location   = "asia-east1"
  cluster    = google_container_cluster.cluster-shepl.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-micro"
    service_account = google_service_account.cluster-sa.email
    oauth_scopes = []
  }
}