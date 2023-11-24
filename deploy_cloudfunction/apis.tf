# Enable Storage API
resource "google_project_service" "storage" {
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Functions API
resource "google_project_service" "cloudfunction" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

# Enable Eventarc API
resource "google_project_service" "eventarc" {
  service            = "eventarc.googleapis.com"
  disable_on_destroy = false
}

# Enable Pub/Sub API
resource "google_project_service" "pubsub" {
  service            = "pubsub.googleapis.com"
  disable_on_destroy = false
}

# Cloud Storage bucket names must be globally unique
resource "random_id" "bucket_name_suffix" {
  byte_length = 4
}

# Create Cloud Storage bucket
resource "google_storage_bucket" "default" {
  name          = "cloudfunction-${random_id.bucket_name_suffix.hex}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}