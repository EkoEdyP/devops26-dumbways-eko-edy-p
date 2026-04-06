# WEEK 2

## STAGE 2

---

### Task Completion

##### **Prerequisite**
- cloud (Ubuntu Server 22.04.x LTS)
- Docker
- clone backend, frontend repository
- nvm 
- mysql-server
- mysql-client
- UFW
- sequelize-cli
- PM2
- register dash.cloudflare account
- nginx
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



