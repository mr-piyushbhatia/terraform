What this Terraform Code will do?
1. Enable Cloud Run API
2. Enable Eventarc API
3. Enable Pub/Sub API
4. Create a Cloud Storage bucket
5. Create a service account for Eventarc trigger
6. Grant eventarc.eventReceiver permission to receive Eventarc events
7. Grant roles/run.invoker permission to invoke Cloud Run services
8. Grant roles/pubsub.publisher permission to publish pub/sub topics
9. Deploy Cloud Run service with demo container which will log received events
10. Create an Eventarc trigger, routing Cloud Storage events to Cloud Run


Commands to be executed
1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply


For Verification
1. To confirm the service has been created:
   gcloud run services list --region <project-region>
2. To confirm the trigger has been created:
   gloud eventarc triggers list --location <project-region>


Generate and view an event
1. Upload a file in Cloud Storage Bucket created by terraform
2. Check the logs in the Cloud Run Service named terra-hello-events
   Or
   By using CLI
   gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=terra-hello-events"

