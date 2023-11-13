# Enable Cloud Run API
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
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

# Create a Cloud Storage bucket
resource "google_storage_bucket" "default" {
  name          = "trigger-${random_id.bucket_name_suffix.hex}"
  location      = google_cloud_run_v2_service.default.location
  force_destroy = true

  uniform_bucket_level_access = true
}
