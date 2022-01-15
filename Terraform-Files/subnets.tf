 
resource "google_compute_subnetwork" "managed-subnet" {
  name          = "managedsubnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-east1"
  network       = google_compute_network.my_vpc.id
}

resource "google_compute_subnetwork" "restricted-subnet" {
  name          = "restrictedsubnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "asia-east1"
  network       = google_compute_network.my_vpc.id
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.managed-subnet.region
  network = google_compute_network.my_vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.managed-subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_service_account" "private-vm-sa" {
  account_id   = "private-vm-sa"
  display_name = "mv-service-account"
}

resource "google_project_iam_binding" "vm-project" {
  project = "gcp-final-338018"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.private-vm-sa.email}"
  ]
}

resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-micro"
  zone         = "asia-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.managed-subnet.id
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.private-vm-sa.email
    scopes = ["cloud-platform"]
  }
}