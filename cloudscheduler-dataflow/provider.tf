provider "google" {
  project = var.project_id
  region = var.region
}

# Used to retrieve project information later
data "google_project" "project" {}