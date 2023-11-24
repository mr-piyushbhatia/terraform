# Create a service account for Eventarc trigger
resource "google_service_account" "cloudfunction_sa" {
  account_id   = "cloudfunction-sa"
  display_name = "Cloud Function Service Account"
}

# Grant permission to invoke Cloud Function services
resource "google_project_iam_member" "cloudfunctions_invoker" {
  project = data.google_project.project.id
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.cloudfunction_sa.email}"
}

# Grant permission to receive Eventarc events
resource "google_project_iam_member" "eventarc_eventReceiver" {
  project = data.google_project.project.id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.cloudfunction_sa.email}"
}

# Grant the Cloud Storage service account permission to publish pub/sub topics
data "google_storage_project_service_account" "gcs_account" {}
resource "google_project_iam_member" "pubsub_publisher" {
  project = data.google_project.project.id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}