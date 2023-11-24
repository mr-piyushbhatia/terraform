# Create a PubSub Topic for Dataflow OutputTopic
resource "google_pubsub_topic" "default" {
  name = "cloudscheduler-dataflow-topic"
}

# Create Cloud Scheduler to Schedule Dataflow Batch Jobs 
resource "google_cloud_scheduler_job" "scheduler" {
  name     = "cloudscheduler-dataflow"
  schedule = "0 0 * * *"

  # This needs to be us-central1 even if the app engine is in us-central.
  region = "us-central1"

  http_target {
    http_method = "POST"
    uri         = "https://dataflow.googleapis.com/v1b3/projects/${var.project_id}/locations/${var.region}/templates:launch?gcsPath=gs://dataflow-templates-${var.region}/latest/GCS_Text_to_Cloud_PubSub"
    oauth_token {
      service_account_email = google_service_account.cloudscheduler_dataflow_sa.email
    }

    # need to encode the string
    body = base64encode(<<-EOT
            {
                "jobName": "cloudscheduler-dataflow-job",
                "parameters": {
                    "inputFilePattern": "gs://${google_storage_bucket.default.name}/*.csv",
                    "outputTopic": "projects/${var.project_id}/topics/${google_pubsub_topic.default.name}"
                },
                "environment": {
                    "maxWorkers": "10",
                    "tempLocation": "gs://${google_storage_bucket.default.name}/temp",
                    "workerZone": "us-central1-f",
                    "network" : "${google_compute_network.vpc_network.name}",
                    "subnetwork": "https://www.googleapis.com/compute/v1/projects/${var.project_id}/regions/${var.region}/subnetworks/${google_compute_subnetwork.vpc_subnet.name}",
                    "ipConfiguration": "WORKER_IP_PRIVATE",
                    "serviceAccountEmail" : "${google_service_account.cloudscheduler_dataflow_sa.email}"
                }
            }
        EOT
    )
  }
}

