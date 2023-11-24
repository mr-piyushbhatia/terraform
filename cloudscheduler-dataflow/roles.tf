# Create a service account for Cloudscheduler Dataflow
resource "google_service_account" "cloudscheduler_dataflow_sa" {
  account_id   = "cloudscheduler-dataflow-sa"
  display_name = "CloudScheduler Dataflow Service Account"
}

# Grant permission of Dataflow Worker
resource "google_project_iam_member" "dataflow_admin" {
  project = data.google_project.project.id
  role    = "roles/dataflow.worker"
  member  = "serviceAccount:${google_service_account.cloudscheduler_dataflow_sa.email}"
}

# Grant permission of Dataflow Developer
resource "google_project_iam_member" "dataflow_developer" {
  project = data.google_project.project.id
  role    = "roles/dataflow.developer"
  member  = "serviceAccount:${google_service_account.cloudscheduler_dataflow_sa.email}"
}

# Grant permission of Cloud Dataflow Service Agent
resource "google_project_iam_member" "dataflow_serviceAgent" {
  project = data.google_project.project.id
  role    = "roles/dataflow.serviceAgent"
  member  = "serviceAccount:${google_service_account.cloudscheduler_dataflow_sa.email}"
}

# Grant permission of Compute Storage Admin
resource "google_project_iam_member" "compute_storageAdmin" {
  project = data.google_project.project.id
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.cloudscheduler_dataflow_sa.email}"
}

# Grant permission of Compute Network User
resource "google_project_iam_member" "compute_networkUser" {
  project = data.google_project.project.id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${google_service_account.cloudscheduler_dataflow_sa.email}"
}
