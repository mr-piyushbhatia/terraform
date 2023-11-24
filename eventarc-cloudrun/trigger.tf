# Deploy Cloud Run service
resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-test"
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

# Create an Eventarc trigger, routing Cloud Storage finalized events to Cloud Run
resource "google_eventarc_trigger" "finalized" {
  name     = "trigger-tf-finalized"
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

# Create an Eventarc trigger, routing Cloud Storage deleted events to Cloud Run
resource "google_eventarc_trigger" "deleted" {
  name     = "trigger-tf-deleted"
  location = google_cloud_run_v2_service.default.location

  # Capture objects changed in the bucket
  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.deleted"
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

# Create an Eventarc trigger, routing Cloud Storage archived events to Cloud Run
resource "google_eventarc_trigger" "archived" {
  name     = "trigger-tf-archived"
  location = google_cloud_run_v2_service.default.location

  # Capture objects changed in the bucket
  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.archived"
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

# Create an Eventarc trigger, routing Cloud Storage metadataUpdated events to Cloud Run
resource "google_eventarc_trigger" "metadataUpdated" {
  name     = "trigger-tf-metadataupdated"
  location = google_cloud_run_v2_service.default.location

  # Capture objects changed in the bucket
  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.metadataUpdated"
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