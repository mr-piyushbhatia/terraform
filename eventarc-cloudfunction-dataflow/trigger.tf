# Create Pub/Sub topic for Eventarc trigger
resource "google_pubsub_topic" "eventarc_topic" {
  name = "eventarc-trigger-topic"
}

# Create Eventarc trigger for Dataflow job
resource "google_eventarc_trigger" "trigger_dataflow" {
  name     = "trigger-dataflow-on-storage-update"
  location = var.region

  matching_criteria {
    attribute = "type"
    value     = "google.storage.object.v1.finalized"
  }
  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.default.name
  }

  destination {
    cloud_function = "process-storage-event"
  }

  transport {
    pubsub {
      topic = google_pubsub_topic.eventarc_topic.name
    }
  }

  service_account = google_service_account.eventarc_service_account.email

  depends_on = [
    google_project_service.storage,
    google_project_service.dataflow,
    google_project_service.eventarc,
    google_pubsub_topic.eventarc_topic,
    google_project_iam_member.pubsub_publisher,
    
  ]
}

# Subscribe Cloud Function to the Pub/Sub topic
resource "google_cloudfunctions2_function" "this" {
  name     = "process-storage-event"
  location = var.region
  project  = var.project_id

  build_config {
    runtime     = "nodejs16"
    entry_point = "processStorageEvent"

    source {
      storage_source {
        bucket = google_storage_bucket.this.id
        object = google_storage_bucket_object.this.name
      }
    }
  }

  event_trigger {
    event_type = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.eventarc_topic.name
  }

  service_config {
    min_instance_count = 1
    max_instance_count = 3
    timeout_seconds    = 60
  }
}

data "archive_file" "this" {
  type        = "zip"
  output_path = "/tmp/trigger.zip"
  source_dir  = "${path.module}/src"
}

resource "google_storage_bucket_object" "this" {
  name   = "trigger.${data.archive_file.this.output_sha}.zip"
  bucket = google_storage_bucket.this.id
  source = data.archive_file.this.output_path
}
