# Guide to build backstage image  
## Installation
### Prerequisites
- install nvm 
- install nmp (version 18.18.2)
- install yarn (class version): 1.22.19
- install docker
- install git

### steps
1. npx @backstage/create-app@latest
2. cd backstage
3. copy or modify app-config.yaml to /backstage
4. yarn install 
5. yarn build:backend
6. build image:  docker image build . -f packages/backend/Dockerfile --tag backstage
7. tag image
8. push to ecr
