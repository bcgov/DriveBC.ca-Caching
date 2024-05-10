# Image Caching Chart

A Chart to provision an instance of an nginx proxy cache which caches content from images.drivebc.ca to reduce load on those servers. It also includes components to zip and then process logs before uploading them to s3 storage.

## Configuration

### Image Caching Options

| Parameter                        | Description                                                       | Default                  |
| -------------------------------- | ----------------------------------------------------------------- | ------------------------ |
| fullnameOverride:                | The full name override for the deployment                           | `drivebc-cache`         |
| nameOverride:                    | The name override for the deployment                               | `drivebc-cache`         |
| replicaCount:                    | The number of replicas for the deployment                          | `1`                      |
| image:                           |                                                                   |                          |
|   repository:                    | The repository containing the Docker image for the deployment     | `ghcr.io/bcgov/drivebc.ca-caching` |
|   tag:                           | The tag of the Docker image used for the deployment                | `latest`                 |
| deployment:                      |                                                                   |                          |
|   resources:                     |                                                                   |                          |
|     requests:                    | The resource requests (CPU and Memory) for the deployment         | CPU: `50m`, Memory: `50Mi`  |
|     limits:                      | The resource limits (CPU and Memory) for the deployment           | CPU: `250m`, Memory: `100Mi`|
|   env:                           |                                                                   |                          |
|     DRIVEBC_IMAGE_BASE_URL:      | The base URL for images used by the deployment                    | `https://tst-images.drivebc.ca/` |
| autoscaling:                     |                                                                   |                          |
|   enabled:                       | Specifies whether autoscaling is enabled for the deployment       | `true`                   |
|   minReplicas:                   | The minimum number of replicas when autoscaling is enabled        | `1`                      |
|   maxReplicas:                   | The maximum number of replicas when autoscaling is enabled        | `2`                      |
|   targetCPUUtilizationPercentage:| The target CPU utilization percentage for autoscaling             | `80`                     |
| networkPolicyRequired:           | Set to true if you need to allow traffic between pods and internet ingress setup | `true`         |
| route:                           |                                                                   |                          |
|   enabled:                       | Specifies whether the route is enabled                             | `true`                   |
|   host:                          | The host for the route                                             | `drivebc-cache.apps.silver.devops.gov.bc.ca` |
|   iprestricted:                  | Set to true if you want to limit IPs in the ipallowlist            | `false`                  |
|   ipallowlist:                   | The list of allowed IP addresses                                   | `142.34.53.0/24 142.22.0.0/15 142.24.0.0/13 142.32.0.0/13 208.181.128.46/32` |
| logpvc:                          |                                                                   |                          |
|   storage:                       | The storage size for logs                                          | `1Gi`                    |
| cronjobs:                        |                                                                   |                          |
|   analyzeuploadlogs:             |                                                                   |                          |
|     name:                        | The name of the cronjob                                            | `analyzeuploadlogs`       |
|     schedule:                    | The cron schedule for the job (in UTC)                             | `0 9 * * *`              |
|     deployment:                  |                                                                   |                          |
|       resources:                 |                                                                   |                          |
|         requests:                | The resource requests (CPU and Memory) for the job                 | CPU: `50m`, Memory: `1Gi`   |
|         limits:                  | The resource limits (CPU and Memory) for the job                   | CPU: `2000m`, Memory: `2Gi` |
|       env:                       |                                                                   |                          |
|         s3Secret:               | The secret for accessing the S3 bucket                             | `drivebc-cronjob-s3bucket` |
|         environment:            | The environment for the job                                        | `dev`                    |
|       volumes:                   |                                                                   |                          |
|         logs:                    | The volume mount for logs                                          | `static-log-storage`      |
|     s3secret:                    |                                                                   |                          |
|       name:                      | The name of the S3 secret                                          | `drivebc-cronjob-s3bucket` |
|       access_key_id:             | The access key ID for the S3 bucket (Do not commit to GitHub)     | `""`                     |
|       bucket:                    | The bucket name for the S3 bucket (Do not commit to GitHub)        | `""`                     |
|       endpoint:                  | The endpoint for the S3 bucket (Do not commit to GitHub)           | `""`                     |
|       secret_access_key:         | The secret access key for the S3 bucket (Do not commit to GitHub)  | `""`                     |
|     name:                        | The name of the cronjob                                            | `ziplogs`                |
|     schedule:                    | The cron schedule for the job                                      | `30 * * * *`             |
|     deployment:                  |                                                                   |                          |
|       resources:                 |                                                                   |                          |
|         requests:                | The resource requests (CPU and Memory) for the job                 | CPU: `50m`, Memory: `100Mi` |
|         limits:                  | The resource limits (CPU and Memory) for the job                   | CPU: `150m`, Memory: `200Mi`|
|       volumes:                   |                                                                   |                          |
|         logs:                    | The volume mount for logs                                          | `static-log-storage`      |




## Components
### OpenShift
- Service
- Route 
- Deployment
- HPA
- Network Policy
- Cronjob
  - Analyze Upload Logs
  - Zip Logs
