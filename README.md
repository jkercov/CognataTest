# Cognata

### Assumptions and information about tasks

* As mentioned in task that developer already had Dockerized application I will not include Dockerfiles and docker-compose.yaml, I will assume they are all ready made and good to work with.
* Regarding authentication for private repo, I assume we will use eather PAT or Oauth to create a service connection that will be given to azure-pipeline to have access to it.
* Assumption is that Ansible is already installed on some other VM and that we can use it from there.
* Using AKV we will inject data in pipeline and all Terraform specific data would be automaticly added to AKV
* Dockerfiles are pushed to ACR and called upon in Docker-compose with specific version (tag) that will be changed based on variable used in azure-pipelines ( predefined var for azure Build.BuildNumber )
* Deploying ansible playbook would be done inside Azure DevOps release pipelines as it has integrated tools for it such as set-up for auth to VM, ansible playbook task and much more.

### Simple infrastructure

For this project I chose VM to host web app as I could best show my work using Terraform and Ansible, because of using Docker also ACR is used. Azure KeyVault should be used to store secrets and linked to variable group in Azure DevOps library so Azure-pipelines can easily replace values of variables.
