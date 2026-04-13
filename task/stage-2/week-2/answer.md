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

        # Builder
        FROM node:18-alpine AS builder

        WORKDIR /app

        COPY package*.json ./
        RUN npm install

        COPY . .

        # Production
        FROM node:18-alpine

        WORKDIR /app

        RUN npm install -g pm2 sequelize-cli

        COPY --from=builder /app /app

        RUN npm prune --omit=dev

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
        1. install docker
        2. create user `kelompok2` and allow docker without sudo
        3. Make a new directory `mkdir wayshub` for the app, then clone the wayshub-backend and the wayshub-frontend
        4. Make `Dockerfile` for both the wayshub-backend and the wayshub-frontend.
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575106135-12a50ad9-bafb-41af-ad3c-da719cb4d6b0.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxMDYxMzUtMTJhNTBhZDktYmFmYi00MWFmLWFkM2MtZGE3MTljYjRkNmIwLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBhM2Y1M2VmZTY5ZGQyNjRjYmMzNzFjNGEyNTM4NWZiNjkwMDYxYWZhNjNjZWZjYmU1ZTBmMDhhNWI5MTc2MGImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.XpmetoRJ9Ryq_zouN-cUNRV0mD0PU6R05mD-mxtZV4U)
        5. Set config to connect frontend to backend, and the backend to database.
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575122398-52251c28-b6eb-4f0e-a262-00b3289cd15a.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxMjIzOTgtNTIyNTFjMjgtYjZlYi00ZjBlLWEyNjItMDBiMzI4OWNkMTVhLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWVkNGFkY2VlODA4ZjZlMmIwMGRiN2ExY2VlYjFlMzBkNjFiYTk4OTE4NjI2N2FhODY5YmMwNDYxZjQwMDExNDQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.ejbwqLXoqGuz7eZlpIDYbirdTnafbVw0tl5XG1DkdPQ)
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575205034-bf6487f2-78a8-42b7-ba2d-895612a390e6.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUyMDUwMzQtYmY2NDg3ZjItNzhhOC00MmI3LWJhMmQtODk1NjEyYTM5MGU2LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTE3YTc0MGFiZjg5MDAwZmQxZDQ4MjkyOTlkZmZkMWE0ZTBhZDdiNTZhNTAwYzBlZDcyZTAwYmFhMGViYzliM2MmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.ZM5Lwt5FlIT0d7jpW0VKKEGyvf1IpwDKml8B6fNQmYI)
        6. Build the frontend and the backend.
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575122544-32cc979c-d3f4-4ac3-9a6e-7cae57713b5e.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxMjI1NDQtMzJjYzk3OWMtZDNmNC00YWMzLTlhNmUtN2NhZTU3NzEzYjVlLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBjMTRjNWIxODI1NTg3OWI0OTI1NTA0NDc0ZDk2ZjAyOGRiMjEyZDAzZWQ5YTkxZGE0YTBkZjUyMmY0ZTcyZmUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.97o9RkWTxnTmrGc06TT42iGTJwW3yapW8U12b7DmgR8)
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575123682-0243b90b-e2f8-42c4-b644-c8cadf0895ed.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxMjM2ODItMDI0M2I5MGItZTJmOC00MmM0LWI2NDQtYzhjYWRmMDg5NWVkLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWY4MDYwYjU5YjVkYzRiZGUxMzNjY2M1MjEyZTRhZmVmNTI0NjQ3MDE1NWI4OTQ0MTk1Mjc5ODhjY2M5NWM3ZTEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.AsY2fH-33tLmsTxUCOQbsKq-qX97AqbE3lCZpDKEN9Y)
        7. Make .conf file for the web server/nginx 
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575127869-79219269-44ed-4418-a848-6d1e281b9ee9.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxMjc4NjktNzkyMTkyNjktNDRlZC00NDE4LWE4NDgtNmQxZTI4MWI5ZWU5LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTYyZDBjYmM5Mzg5NWQzZmMwYTg2NWI2NzVmOTEzN2ZmYjE5MDc5NWZmYTBmM2FmYmYwNjQ1NTM4NDU4ZjE2ZWYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.kiAAdoPoMXQe6Ll9RXgw3amtQ3OsUXxYsOMwwC1HUjI)
        8. Make docker-compose.yml file, and the .env for the backend
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575479290-2a3f4785-d03e-4bf3-89af-34832503b66a.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzU0NzkyOTAtMmEzZjQ3ODUtZDAzZS00YmYzLTg5YWYtMzQ4MzI1MDNiNjZhLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWVjZWQwYmRmODliMDM4YzkzZTZiY2Y3Y2MyNmUwZGFkMTU1NmE4NGQxMzE1NWVjZjExODdmM2FmMjU3MjJhNTgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.oTN83CWpM_kVwWhF3URlrNdeWC7cNqEx8mi9tf9HX3Q)
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575197904-9f6f3922-6612-4d95-ad40-ea97b56dee83.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxOTc5MDQtOWY2ZjM5MjItNjYxMi00ZDk1LWFkNDAtZWE5N2I1NmRlZTgzLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWIwMDM3NjczZDc4NTRmNDFhZmZhNmNkZTY1ODA5NjVjNDdjNWIyZjAyZWIxM2NhNjg0NGRiOWI2MDkwMjdlZjcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.tvNAUsHrHrhM241ouYHNRLQ97vLcObkrylCQz7FgiE0)
        9. Run docker compose up
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575145704-f71f226b-3ffa-400f-9078-5a0bf7c8aa7b.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxNDU3MDQtZjcxZjIyNmItM2ZmYS00MDBmLTkwNzgtNWEwYmY3YzhhYTdiLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTExNTU4YmUyZjU4ZGI1YWQ2ZGU4MTIzYjQyZjM5YWNmNmQ3Y2IwZTYxODE1MDY4ODdjMjgyOTFmYTY0NjI0OWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.IRrsf_OjHSLvleQK5TbWEYORJMyAsxZNgT8gJ6H3EVs)
        10. The app can be accessed with a domain with all its functions.
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575176989-3713dc4e-3d85-4119-b2b4-eadbde3957df.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxNzY5ODktMzcxM2RjNGUtM2Q4NS00MTE5LWIyYjQtZWFkYmRlMzk1N2RmLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWFkNmIzMDEzMGMxMzU5ZDdiZTZkYjM5NmU1NWFmNWZlM2Y1NzlkODlmYzEwZWY1MjhmNDkxYWQ4ZmE1NGJhNDcmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.tNQ0Z1PLclxyLTX85xo0jNY29nqZNDfM_GbDHw4VG4A)
        ![gambar](https://private-user-images.githubusercontent.com/48948871/575177241-313481da-286d-4276-9e9a-b6bda92af95a.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NzU2OTYzNTksIm5iZiI6MTc3NTY5NjA1OSwicGF0aCI6Ii80ODk0ODg3MS81NzUxNzcyNDEtMzEzNDgxZGEtMjg2ZC00Mjc2LTllOWEtYjZiZGE5MmFmOTVhLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNjA0MDklMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjYwNDA5VDAwNTQxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWQwYWM5MWZiNDdhZTAzNzkyYjU2YWFlYWRiYjM1NDRmZWM5MzE4NmNjMjcwMTJmMmFiMTkyNGI3MmJhMTkyZDYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.-HTANiV0syvT5WZFZZGEGpsaygjpdLRXW_1pscvLF5Q)
    ---
### *[Jenkins]*

- Install Jenkins on top Docker with `docker-compose.yaml`
```
# buat folder wayshub
mkdir wayshub

# change to wayshub dir
cd wayshub

# create docker-compose.yaml file and copy code bellow
nano docker-compose.yaml

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    restart: always
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - ./jenkins_home:/var/jenkins_home
```
- run and manage jenkins
    1. run → `docker compose up -d`
    2. get admin password → `docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`
    3. open `http://IP_SERVER:8080` and paste admin password
    ![gambar](/task/stage-2/week-2/asset/unlock.jenkins.png)
    4. select plugins to install
    5. choose plugins u want install, and then install it
    ![gambar](/task/stage-2/week-2/asset/plugins.jenkins.png)
    ![gambar](/task/stage-2/week-2/asset/plugins.jenkins.install.png)
    6. create user
    7. determine instance configuration and klik `save and finish`
    ![gambar](/task/stage-2/week-2/asset/instance.conf.jenkins.png)
    8. klik `start using jenkins`
    ![gambar](/task/stage-2/week-2/asset/start.jenkins.png)
    9. create ssh-key on Jenkins server → `ssh-keygen -t rsa -b 4096`
    10. copy pub key → `cat ~/.ssh/id_rsa.pub`
    11. paste on App server → `~/.ssh/authorized_keys`
    9. create credential
    ![gambar](/task/stage-2/week-2/asset/credential.jenkins.png)
    10. create pipeline
    ![gambar](/task/stage-2/week-2/asset/pipeline.jenkins.png)
    ![gambar](/task/stage-2/week-2/asset/pipeline2.jenkins.png)
    11. clone source code on jenkins server
    12. create `Jenkinfile` → ![jenkinsfile](https://github.com/EkoEdyP/devops26-dumbways-eko-edy-p/blob/main/task/stage-2/week-2/Jenkinsfile)
    13. push to github
    14. add webhooks on github
    ![gambar](/task/stage-2/week-2/asset/github.webhooks.png)
    15. add webhooks on discord
    ![gambar](/task/stage-2/week-2/asset/webhooks.discord.png)
    16. run build on Jenkins
        
### *[Github Action]*

- create script for github action on [.github/workflows/FILENAME.yaml](https://github.com/EkoEdyP/wayshub-backend/blob/main/.github/workflows/cicd.yaml)
- set Secret Variable
    ![gambar](/task/stage-2/week-2/asset/sec.var.png)
- run github action
    ![gambar](/task/stage-2/week-2/asset/gh.action.png)
- make sure `Deploy SUCCESS` on discord    
    ![gambar](/task/stage-2/week-2/asset/notif.dc.png)













    


