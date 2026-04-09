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
- Deploy aplikasi Web Server, Frontend, Backend, serta Database on top docker compose (*STAGING*)

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
- Deploy aplikasi Web Server, Frontend, Backend, serta Database on top docker compose (*PRODUCTION*)

    1. create SERVER for `deploy database`
    ![gambar](/task/stage-2/week-2/asset/vm-cicd.png)
        1. install docker
        2. create user `kelompok2` and allow docker without sudo
        3. create folder `mkdir wayshub`
        4. create file on wayhshub `sudo nano docker-compose.yaml`
        ```
        services:
        database:
            image: mysql
            container_name: db_production
            restart: always
            environment:
            MYSQL_ROOT_PASSWORD: root
            MYSQL_USER: k2
            MYSQL_PASSWORD: k2
            MYSQL_DATABASE: wayshub
            ports:
            - "3306:3306"
            volumes:
            - ./mysql:/var/lib/mysql
        ```
        5. allow ufw on port `3306 and 22`
        6. run `docker compose up -d`        
    2. create SERVER for `deploy wayshub-backend, wayshub-frontend and nginx`
    ![gambar](/task/stage-2/week-2/asset/vm-appserver.png)
        1. Create a new docker user and login with the new user.
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575090141-79f30130-023d-4700-950b-057aa5f244c3.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUwOTAxNDEtNzlmMzAxMzAtMDIzZC00NzAwLTk1MGItMDU3YWE1ZjI0NGMzLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTJlMDI1YTk1OTBkYmFkOGMzN2I0ODAwOTMwYzkyYTkxMmZjMGUxOTcyY2I5MmYxNjA4OGI3ZjliNGVhYzExMzcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.9WHPv63cZH-q1AuFODKMSXjIM0Lesu6HWTtJ_inUMJ0)


    


