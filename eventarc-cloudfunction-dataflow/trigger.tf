# Create Pub/Sub topic for Eventarc trigger
resource "google_pubsub_topic" "eventarc_topic" {
  name = "eventarc-dataflow-topic"
}

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

# Subscribe Cloud Function to the Pub/Sub topic
resource "google_cloudfunctions2_function" "this" {
  name     = "process-storage-event"
  location = var.region
  project  = var.project_id

  build_config {
    runtime     = "nodejs20"
    entry_point = "processStorageEvent"

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
    service_account_email = google_service_account.eventarc_cloudfunction_sa.email
  }

  event_trigger {
    event_type            = "google.cloud.storage.object.v1.finalized"
    service_account_email = google_service_account.eventarc_cloudfunction_sa.email
    event_filters {
      attribute = "bucket"
      value     = google_storage_bucket.default.name
    }
  }


  depends_on = [
    google_project_service.cloudfunction,
    google_project_service.cloudbuild,
    google_project_iam_member.pubsub_publisher,
    google_pubsub_topic.eventarc_topic
  ]

}
