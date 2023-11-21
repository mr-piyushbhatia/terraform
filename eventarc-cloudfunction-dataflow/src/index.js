// index.js

const { google } = require('googleapis');

exports.processStorageEvent = async (event, context) => {
  const pubsubMessage = event.data;
  const eventData = JSON.parse(Buffer.from(pubsubMessage, 'base64').toString());

  // Extract relevant information from the Pub/Sub event
  const bucket = eventData.bucket;
  const file = eventData.name;

  // Trigger Dataflow job
  await triggerDataflowJob(bucket, file);

  // Log success
  console.log(`Dataflow job triggered for file ${file} in bucket ${bucket}.`);
};

async function triggerDataflowJob(bucket, file) {
  // Your Google Cloud Platform project ID
  const projectId = 'your-project-id';

  // The name of your Dataflow job
  const jobName = 'your-dataflow-job-name';

  // The Google Cloud Storage path for your Dataflow job template
  const templateGcsPath = 'gs://your-bucket/templates/your-template-file';

  // The temporary Google Cloud Storage location for your Dataflow job
  const tempGcsLocation = 'gs://your-bucket/tmp_dir';

  // Create a Dataflow client
  const dataflow = google.dataflow({ version: 'v1b3' });

  // Set up the request
  const request = {
    projectId: projectId,
    location: 'us-central1', // Replace with your desired location
    jobName: jobName,
    resource: {
      name: jobName,
      parameters: {
        inputFilePattern: `${bucket}/*.json`,
        outputTopic: 'projects/your-project-id/topics/your-pubsub-topic', // Replace with your Pub/Sub topic
      },
      location: 'us-central1', // Replace with your desired location
      environment: {
        tempLocation: tempGcsLocation,
        zone: 'us-central1', // Replace with your desired zone
      },
      gcsPath: templateGcsPath,
    },
  };

  // Create the Dataflow job
  const response = await dataflow.projects.locations.jobs.create(request);

  // Log the job ID
  console.log(`Dataflow job created with ID: ${response.data.id}`);
}
