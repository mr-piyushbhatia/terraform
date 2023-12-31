What this Terraform Code will do?
1. Enable Storage API
2. Enable Cloud Run API
3. Enable Eventarc API
4. Enable Pub/Sub API
5. Create a Cloud Storage bucket
6. Create a service account for Eventarc trigger
7. Grant permission to receive Eventarc events
8. Grant permission to invoke Cloud Run services
9. Grant Cloud Storage service account permission to publish pub/sub topics
10. Deploy Cloud Run service with demo container which will log received events
11. Create a Cloud Run service with demo hello container
12. Create an Eventarc trigger, routing Cloud Storage events to Cloud Run


Commands to be executed
1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply


For Verification
1. To confirm the service has been created:
   gcloud run services list --region <project-region>
2. To confirm the trigger has been created:
   gcloud eventarc triggers list --location <project-region>


Generate and view an event
1. Upload a file in Cloud Storage Bucket created by terraform
2. Check the logs in the Cloud Run Service

