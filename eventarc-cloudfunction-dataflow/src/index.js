const { JobsV1Beta3Client } = require('@google-cloud/dataflow').v1beta3;

exports.processStorageEvent = function (eventData, callback) {

    const bucket = eventData.bucket;


    // Instantiates a client
    const dataflowClient = new JobsV1Beta3Client();

    async function callCreateJob() {
        // Construct request
        projectId = "terra-hcl-404112"
        const request = {
            projectId: projectId,
            resource: {
                parameters: {
                    inputFilePattern: `gs://${bucket}/*.csv`,
                    outputTopic: `projects/${projectId}/topics/eventarc-dataflow-topic`,
                },
                jobName: 'dataflow-job',
                gcsPath: 'gs://dataflow-templates-us-central1/latest/GCS_Text_to_Cloud_PubSub'
            }
        }
        // Run request
        const response = await dataflowClient.createJob(request);
        console.log(response);
    }

    callCreateJob();
}