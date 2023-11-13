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


Commands to be executed >

1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply
