# Deploy Cloud Run service
resource "google_cloud_run_v2_service" "default" {
  name     = "terra-hello-events"
  location = var.region

  template {
    containers {
      # This demo container will log received events
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
    service_account = google_service_account.eventarc_service_account.email
  }

  depends_on = [google_project_service.run]
}

# Create an Eventarc trigger, routing Cloud Storage events to Cloud Run
resource "google_eventarc_trigger" "default" {
  name     = "trigger-storage-cloudrun-tf"
  location = google_cloud_run_v2_service.default.location

  # Capture objects changed in the bucket
  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }
  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.default.name
  }

  # Send events to Cloud Run
  destination {
    cloud_run_service {
      service = google_cloud_run_v2_service.default.name
      region  = google_cloud_run_v2_service.default.location
    }
  }

  service_account = google_service_account.eventarc_service_account.email
  depends_on = [
    google_project_service.eventarc,
    google_project_iam_member.pubsubpublisher
  ]
}