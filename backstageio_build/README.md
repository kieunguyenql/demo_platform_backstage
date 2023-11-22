## How to build backstageio docker

### Prerequirement
curl or wget installed
Node.js Active LTS Release installed using one of these methods:
Using nvm (recommended)
Install and change Node version with nvm (currently use version 18.18.2)
 ubuntu@ip-10-80-61-236:~$ node -v
 v18.18.2
yarn Installation
You will need to use Yarn classic to create a new project, but it can then be migrated to Yarn 3
 npm install --global yarn@1.22.19
docker installation
git installation
If the system is not directly accessible over your network the following ports need to be opened: 3000, 7007. This is quite uncommon, unless when you're installing in a container, VM or remote system.

####### Steps
1. npx @backstage/create-app@latest
2. cd backstage  #  can run "yarn dev" to check 
3. <copy file app-config.yaml to . directory>
4. yarn install
5. yarn build:backend # build with app-config.yaml
6. docker image build . -f packages/backend/Dockerfile --tag demo-backstage:1.0.0
7. make tag 
8. push to registry

###### Test dockerimage by docker-compose
- Note: check all variable in app-config.yaml to pass it in docker-compose file
- docker-compose file 

version: '3'
services:
  backstage:
    image: demo-backstage:1.0.0
    ports:
      - "7007:7007"
      - "3000:3000"
    depends_on:
      - postgres
    environment:
      BACKEND_URL: "http://xxxx:7007"
      APP_DOMAIN: "http://xxxx:3000"
      PGSSLMODE: allow                         #allow connect to postgresql without ssl 
      POSTGRES_HOST: postgres 
      POSTGRES_PORT: 5432 
      POSTGRES_USER: backstage
      POSTGRES_PASSWORD: xxxx
      GITHUB_TOKEN: xxxxxxxxxxxx               #github token to intergrate with backstage, backstage use this to create repo, ....
      AUTH_GITHUB_CLIENT_ID: xxxxxxxxxxxxxx     # authen to see CICD
      AUTH_GITHUB_CLIENT_SECRET: xxxxxxxxxxxxxx #

  postgres:
    image: postgres
    environment:
      POSTGRES_DB: postgres
      POSTGRES_PORT: 5432
      POSTGRES_USER: backstage
      POSTGRES_PASSWORD: xxxxxxxx
    ports:
      - "5432:5432"
