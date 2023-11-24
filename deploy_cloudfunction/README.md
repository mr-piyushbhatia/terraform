What this Terraform Code will do?
1. Enable Storage API
2. Enable Cloud Functions API
3. Enable Cloud Build API
4. Enable Eventarc API
5. Enable Pub/Sub API
6. Create a Cloud Storage bucket
7. Create a service account for Eventarc Cloudfunction trigger
8. Grant permission to invoke Cloud Function services
9. Grant permission to receive Eventarc events 
10. Grant Cloud Storage service account permission to publish pub/sub topics
11. Create a Cloud Function which trigger using Eventarc on Storage Events

Commands to be executed
1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply