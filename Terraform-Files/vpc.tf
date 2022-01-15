resource "google_compute_network" "my_vpc" {
  project                 = "gcp-final-338018"
  name                    = "main-vpc"
  auto_create_subnetworks = false
}