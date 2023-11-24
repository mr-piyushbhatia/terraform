# Create a VPC Network for Dataflow Job
resource "google_compute_network" "vpc_network" {
  name                                      = "vpc-network"
  auto_create_subnetworks                   = false
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

# Create a VPC SubNetwork for Dataflow Job
resource "google_compute_subnetwork" "vpc_subnet" {
  ip_cidr_range            = "10.128.0.0/20"
  name                     = google_compute_network.vpc_network.name
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}
