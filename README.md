# Demo-backstage

This is repo which include code for demo backstage

## Table of Contents

## Introduction
Backstage is very new tool for platform engineer to manage other develop tools.
And it helps to create template for developer, make life is easier.

## Folder structure
- backstageio_build:
   - There is guide to build backstage image to run container
   - app-config.yaml for build
   - docker compose to run test after build image
 - example-template:
   - template_repo: this is base files which are fetched by backstage, then backstage will pushlish it, create new repo in SCM with all contents of template_repo
   - template.yaml: This is template.yaml, will import it to backstage 
- initial-sample-web-app:
   - infras-tf: terraform code to build sample web-app
   - sample-web-app python code which is deployed to lambda
- terraform_backstageio_ecs_deployment:
   - Module: include terraform vpc module to create vpc
   - ecs_backstage_terraform: Code to deploy backstage to ecs cluster
  
## Installation
