# GameBlast
Repository for a game, GoodBlast, focused on the devops processes

## Deployment

Deployment of the app is done via the deploy.sh script. You need to be in the deployment
folder to run it. It takes an argument, the environment, and applies the neccessary 
kustomize configurations.

The image name and tag is taken from the `source/.full_image_name` which is created in the
build process.

### Knative

Knative configs is a WIP and not ready yet.

### Kustomize

The deployment is done using the kustomize. Folder structure is very simple.
Most of the kubernetes yaml's comes from the base/, only the environment specific configs 
are in the dev/ and prod/ folders, along with the ingress and configmap yamls.

## Infra

Cloud resources are managed through Terraform. Different environments like dev and prod
are handled through terraform variables. You need to give (dev|prod).tfvars file to the
terraform apply command. But there is a helper deploy.sh script. The script takes the 
environment as argument and runs the terraform apply command accordingly. If you want to
destroy the resources, you can give `-d` as argument, which then the script will destroy
the resources. 

## Kind

This directory is used for development on a local kubernetes cluster.
You can find helper scripts for metrics, jenkins, metallb etc. along with a working kind configuration.
You should understand the contents of the scripts and take it with a grain of salt as they are potentially destructive!!

## Pipeline

The Jenkinsfile resides here which handles the CI/CD side of the lint, test, build, push and deploy

## Source

The source code for the application resides here, along with some scripts for the CI.

- build.sh: Runs docker build and docker push, also saving the image name + tag into a file for further use. The image name is parametrized through environment variables.
- lint.sh: Runs `golangci-lint run` for linting.
- test.sh: Runs `go test` for tests.
