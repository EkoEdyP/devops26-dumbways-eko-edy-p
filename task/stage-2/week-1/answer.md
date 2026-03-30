# WEEK 1

## STAGE 2

---

### Penyelesaian Task

##### Prerequisite
- cloud (Ubuntu Server 22.04.x LTS)
- clone backend, frontend repository
- nvm 
- mysql-server
- sequelize-cli
- nginx
- UFW
- certbot
- PM2

##### Step Penyelesaian Task

1. login cloud computing
    1. open terminal
    2. `chmod 600 /LOKASI/NAMA_PRIVATEKEY.pem`
    3. `ssh -i /path_directory/nama_private_key.pem ubuntu@ip_public_server`
2. clone [backend](https://github.com/dumbwaysdev/wayshub-backend), [frontend](https://github.com/dumbwaysdev/wayshub-frontend) repository
3. install NVM dan pastikan pakai [NodeJS 12](https://nodejs.org/en/download)

``` bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 12

# Verify the Node.js version:
node -v # Should print "v12.22.12".

# Verify npm version:
npm -v # Should print "6.14.16".

```
4. manage mysql
    1. install mysql-server → `sudo apt install mysql-server`
    2. setup secure installation → `sudo mysql_secure_installation`
    3. add password for root user → `ALTER USER 'root'@'localhost' IDENTIFIED BY 'the-new-password';`
5. 