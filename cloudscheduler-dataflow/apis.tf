
# Enable Storage API
resource "google_project_service" "storage" {
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

# Enable Dataflow API
resource "google_project_service" "dataflow" {
  service            = "dataflow.googleapis.com"
  disable_on_destroy = false
}

# Enable Dataflow Pipelines API
resource "google_project_service" "datapipelines" {
  service            = "datapipelines.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Scheduler API
resource "google_project_service" "cloudscheduler" {
  service            = "cloudscheduler.googleapis.com"
  disable_on_destroy = false
}

# Enable Service Networking API
resource "google_project_service" "servicenetworking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

# Cloud Storage bucket names must be globally unique
resource "random_id" "bucket_name_suffix" {
  byte_length = 4
}

# Create Cloud Storage bucket
resource "google_storage_bucket" "default" {
  name          = "cloudscheduler-dataflow-${random_id.bucket_name_suffix.hex}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}