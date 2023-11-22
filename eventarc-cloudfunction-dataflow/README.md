What this Terraform Code will do?
1. Enable Storage API
2. Enable Cloud Functions API
3. Enable Cloud Build API
4. Enable Cloud Run API
5. Enable Eventarc API
6. Enable Pub/Sub API
7. Enable Dataflow API
8. Enable DataPipelines API
9. Enable CloudScheduler API
10. Create a Cloud Storage bucket
11. Create a service account for Eventarc-Cloudfunction trigger
12. Grant eventarc.admin permission to manage Eventarc events
13. Grant dataflow.admin permission to manage Dataflow
14. Grant cloudfunctions.invoker permission to invoke Cloud Functions 
15. Grant run.invoker permission to invoke Cloud Run 
16. Grant pubsub.publisher permission to publish pub/sub topics
17. Create Pub/Sub topic for Eventarc trigger
18. Create a NodeJs Cloud Function which will create Dataflow Job and Trigger Dataflow Pipeline using Eventarc

Commands to be executed
1. gcloud auth application-default login
2. terraform init
3. terraform plan
4. terraform apply