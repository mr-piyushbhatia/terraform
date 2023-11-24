What this Terraform Code will do?
1. Enable Storage API
2. Enable Cloud Functions API
3. Enable Cloud Build API
4. Enable Eventarc API
5. Enable Pub/Sub API
6. Create a Cloud Storage bucket
7. Create a service account for Eventarc-Cloudfunction trigger
8. Grant eventarc.admin permission to manage Eventarc events
9. Grant cloudfunctions.invoker permission to invoke Cloud Functions 
10. Grant pubsub.publisher permission to publish pub/sub topics
11. Create a Cloud Function which trigger using Eventarc on Storage Events

Commands to be executed
1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply