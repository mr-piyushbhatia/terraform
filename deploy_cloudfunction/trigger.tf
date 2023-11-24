data "archive_file" "this" {
  type        = "zip"
  output_path = "/tmp/trigger.zip"
  source_dir  = "${path.module}/src"
}

resource "google_storage_bucket_object" "this" {
  name   = "trigger.${data.archive_file.this.output_sha}.zip"
  bucket = google_storage_bucket.default.id
  source = data.archive_file.this.output_path
}

# Create a Cloud Function which trigger using Eventarc on Storage Events
resource "google_cloudfunctions2_function" "this" {
  name     = "cloudfunction-test"
  location = var.region
  project  = var.project_id

  build_config {
    runtime     = "nodejs20"
    entry_point = "helloGCS"

    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.this.name
      }
    }
  }

  service_config {
    min_instance_count    = 1
    max_instance_count    = 3
    timeout_seconds       = 60
    service_account_email = google_service_account.cloudfunction_sa.email
  }

  event_trigger {
    event_type            = "google.cloud.storage.object.v1.finalized"
    service_account_email = google_service_account.cloudfunction_sa.email
    event_filters {
      attribute = "bucket"
      value     = google_storage_bucket.default.name
    }
  }


  depends_on = [
    google_project_service.cloudfunction,
    google_project_service.cloudbuild,
  ]

}
