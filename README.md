## CI/CD demo

Demo with Flask app shows how to build a common CI/CD pipeline.

<br>

## Workflow

### CI stage
1. Create patch
1. Trigger Jenkins [precommit](deploy/Jenkinsfile.precommit) [checking](dev-support/test-patch.sh)
    - Check format
    - Run unit test
    - Run Scantist
1. Code review
1. Merge to master

<br>

### CD stage
1. Merge on master will trigger Jenkins to [deploy](deploy/Jenkinsfile) the application
    1. Build [docker image](deploy/Dockerfile)
    1. Push docker image into registry
    1. Deploy onto cluster