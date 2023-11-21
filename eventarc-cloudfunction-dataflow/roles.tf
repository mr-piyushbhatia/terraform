# Create a service account for Eventarc trigger
resource "google_service_account" "eventarc_cloudfunction_sa" {
  account_id   = "eventarc-cloudfunction-sa"
  display_name = "Evenarc Trigger Cloud Function Service Account"
}

# Grant permission to receive Eventarc events
resource "google_project_iam_member" "eventarc_admin" {
  project = data.google_project.project.id
  role    = "roles/eventarc.admin"
  member  = "serviceAccount:${google_service_account.eventarc_cloudfunction_sa.email}"
}

# Grant permission to invoke Dataflow
resource "google_project_iam_member" "dataflow_admin" {
  project = data.google_project.project.id
  role    = "roles/dataflow.admin"
  member  = "serviceAccount:${google_service_account.eventarc_cloudfunction_sa.email}"
}

# Grant permission to invoke Cloud Function services
resource "google_project_iam_member" "pubsubpublisher" {
  project = data.google_project.project.id
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.eventarc_cloudfunction_sa.email}"
}

# Grant the Cloud Storage service account permission to publish pub/sub topics
data "google_storage_project_service_account" "gcs_account" {}
resource "google_project_iam_member" "pubsub_publisher" {
  project = data.google_project.project.id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}
