# WEEK 2

## STAGE 2

---

### Task Completion

##### **Prerequisite**
- cloud (Ubuntu Server 22.04.x LTS)
- Docker (node 14, mysql, sequelize-cli, PM2)
- clone backend, frontend repository
- UFW
- register dash.cloudflare account for DNS
- certbot

##### **Steps to Complete the Task**

### *[Docker]*

- membuat user baru dengan nama team kalian
    1. add new user → `sudo adduser eep`
    2. Add to the sudo group (so you have admin access) → `sudo usermod -aG sudo eep`
    3. To use Docker without sudo → `sudo usermod -aG docker eep`
    4. login to user → `sudo su - eep`
- membuat bash script untuk melakukan installasi docker.
    1. create file `nano install-docker.sh` and copy this file → [script install docker](https://github.com/EkoEdyP/devops26-dumbways-eko-edy-p/blob/main/task/stage-2/week-2/install-docker.sh)
    2. add permission → `chmod +x install_docker.sh`
    3. run to install docker → `sudo ./install_docker.sh`
- Deploy aplikasi Web Server, Frontend, Backend, serta Database on top docker compose (STAGING)

    *FOLDER STRUCTURE*
    ```
    dumbways-app/
    │
    ├── docker-compose.yaml
    │
    ├── mysql (mysql volume)/
    │   └── (mysql configuration)
    │
    ├── wayshub-backend/
    │   ├── Dockerfile
    │   └── (source code backend)
    │
    ├── wayshub-frontend/
    │   ├── Dockerfile
    │   └── (source code backend)
    │
    ├── nginx (nginx volume)/
    │   └── (nginx configuration)
    │
    └── certbot (certbot volume)/
        └── (certbot configuration)

    ```    
    1. create file `nano docker-compose.yaml` and copy this file → [docker-compose.yaml](https://github.com/EkoEdyP/devops26-dumbways-eko-edy-p/blob/main/task/stage-2/week-2/docker-compose.yaml)
    2. make sure your database environment and migration environment on docker-compose.yaml is `valid`
    3. buat Dockerfile di `wayshub-backend`
        ```bash
        FROM node:14

        WORKDIR /app

        COPY package*.json ./
        RUN npm install
        RUN npm install -g sequelize-cli
        RUN npm install pm2@latest -g

        COPY . .

        EXPOSE 5000

        CMD ["pm2-runtime", "start", "ecosystem.config.js"]
        ```

        1. make sure backend config on `~/dumbways-app/wayshub-backendconfig/config.json`
        2. and also make sure backend config on`~/dumbways-app/wayshub-backend/ecosystem.config.js`
    4. buat Dockerfile di `wayshub-frontend`
        ```bash
        FROM node:14

        WORKDIR /app

        COPY package*.json ./
        RUN npm install
        RUN npm install pm2@latest -g

        COPY . .

        EXPOSE 3000

        CMD ["pm2-runtime", "start", "ecosystem.config.js"]
        ```
        1. make sure frontend config on `~/dumbways-app/wayshub-frontend/src/config/api.js`
        2. and also make sure frontend config on`~/dumbways-app/wayshub-frontend/ecosystem.config.js`
    5. create nginx configuration on `./nginx/`
- Deploy aplikasi Web Server, Frontend, Backend, serta Database on top docker compose (PRODUCTION)

