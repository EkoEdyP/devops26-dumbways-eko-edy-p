# WEEK 1

## STAGE 2

---

### Task Completion

##### **Prerequisite**
- cloud (Ubuntu Server 22.04.x LTS)
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

1. login cloud computing
    1. open terminal
    2. `chmod 600 /path_directory/private_key_name.pem`
    3. `ssh -i /path_directory/private_key_name.pem hostname@ip_public_server`
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

4. manage and secure mysql
    1. install mysql-server → `sudo apt install mysql-server`
    2. setup secure installation → `sudo mysql_secure_installation`
    3. login mysql → `sudo mysql`
    4. add password for root user → `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'the-new-password';`
    5. create new user → `CREATE USER 'eep'@'%' IDENTIFIED BY 'the-password';`
    6. create new database → `CREATE DATABASE wayshub;`
    7. Create privileges for your new user so they can access the database you created → `GRANT ALL PRIVILEGES ON *.* TO 'eep'@'%';`
    8. reload → `FLUSH PRIVILEGES;`

5. try role based

```sql
// Create new database call demo and make some dummy table call transaction 

CREATE DATABASE demo;
USE demo;

CREATE TABLE transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10,2),
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

// Create a 2 role with the name admin, and guest that will be used to see and manage the 'transaction' table.

CREATE ROLE 'admin';
CREATE ROLE 'guest';

// Give SELECT, INSERT, UPDATE, and DELETE access rights to the transaction table for the admin role you just created. and only give SELECT access to guest.

GRANT SELECT, INSERT, UPDATE, DELETE ON demo.transaction TO 'admin';
GRANT SELECT ON demo.transaction TO 'guest';

// Create a new user with the username your_name and password your_password. Add the user to the admin role.

CREATE USER 'your_name'@'localhost' IDENTIFIED BY 'your_password';
GRANT 'admin' TO 'your_name'@'localhost';
SET DEFAULT ROLE 'admin' TO 'your_name'@'localhost';

// Create a new user with the username guest and password guest. Add the user to the guest role.

CREATE USER 'guest'@'localhost' IDENTIFIED BY 'guest';
GRANT 'guest' TO 'guest'@'localhost';
SET DEFAULT ROLE 'guest' TO 'guest'@'localhost';

// Test all of your user

// test admin 
mysql -u your_name -p
USE demo;

INSERT INTO transaction (amount, description) VALUES (10000, 'Test admin');
SELECT * FROM transaction;
UPDATE transaction SET amount = 20000 WHERE id = 1;
DELETE FROM transaction WHERE id = 1;

// test guest
mysql -u guest -p
USE demo;

SELECT * FROM transaction;

INSERT INTO transaction (amount, description) VALUES (5000, 'Test guest'); // must fail (permission denied)

```    

6. Try to remote database from local computer with mysql-client
    1. Make sure MySQL on the server is accessible from outside
        1. edit `bind-address = 127.0.0.1` to `bind-address = 0.0.0.0` on `/etc/mysql/mysql.conf.d/mysqld.cnf`
        2. restart mysql → `sudo systemctl restart mysql`
    2. Create a MySQL user with remote access
        1. login → `mysql -u root -p`
        2. cretae user with remote access → `CREATE USER 'remote-db'@'%' IDENTIFIED BY 'the-password';`
        3. grant specific access → `GRANT ALL PRIVILEGES ON SPESIFIC_DATABASE.* TO 'remote-db'@'%';` or grant all access `GRANT ALL PRIVILEGES ON *.* TO 'remote-db'@'%';`
        4. reload → `FLUSH PRIVILEGES;`
    3. Open the MySQL port on the server firewall → `sudo ufw allow 3306`
    4. connect from local computer (mysql-client)
        1. install → `brew install mysql-client`
        2. connect to database server → `mysql -h IP_SERVER -u remote-db -p`    

7. Deploy Wayshub-Backend
    1. clone wayshub backend application → `git clone https://github.com/dumbwaysdev/wayshub-backend.git`
    2. use node version 14 → `nvm install 14`
    3. set configuration on `wayshub-backend/config/config.json` and then adjust it to your database.
    
    *make sure username value, password value, database value, and dialect value.*    
    ![gambar](/task/stage-2/week-1/asset/db-conf.png)

    4. Install sequelize-cli → `npm i -g sequelize-cli`
    5. Running migration → `sequelize db:migrate`

    *make sure migrate successfully*    
    ![gambar](/task/stage-2/week-1/asset/db-schema.png)

    6. Deploy apllication on Top PM2
        1. install PM2 → `npm install pm2@latest -g`
        2. Create a file named `ecosystem.config.js` and fill it with the code below
        
        ![gambar](/task/stage-2/week-1/asset/ecosystem.conf.png)

        3. deploy → `pm2 start`
        4. make sure with `pm2 list` and `pm2 logs`

        ![gambar](/task/stage-2/week-1/asset/ways-back.png)

8. Clone Wayshub-Frontend application
    1. clone wayshub frontend application → `git clone https://github.com/dumbwaysdev/wayshub-frontend` and dont forget to install dependencies → `npm install`
    2. use node version 14 → `nvm install 14`
    3. set configuration on `src/config/api.js` and then adjust it to backend url.

    *Make sure the value of the baseURL matches the gateway or domain*
    ![gambar](/task/stage-2/week-1/asset/base.url.png)
    
    4. Deploy frontend apllication on Top PM2
        1. Create a file named `ecosystem.config.js` and fill it with the code below
        
        ![gambar](/task/stage-2/week-1/asset/ecosystem.conf.2.png)

        2. deploy → `pm2 start`
        3. make sure with `pm2 list` and `pm2 logs`

        ![gambar](/task/stage-2/week-1/asset/ways-front.png)

9. setup gateway
    1. install nginx → `sudo apt install nginx`
    2. configure cloudflare DNS
        1. Log in to Cloudflare and select your domain.
        2. go to `DNS` > `Records`
        3. add record → Select the `type, name, and IPv4 address`

        *backend*    
        ![gambar](/task/stage-2/week-1/asset/dns.backend.png)

        *frontend*    
        ![gambar](/task/stage-2/week-1/asset/dns.frontend.png)

    
    3. configure nginx reverse proxy
        1. Go to the folder to create the configuration → `cd /etc/nginx/sites-available`
        2. Create a file for `wayshub-backend and wayshub-frontend` the configuration settings

        *backend and frontend nginx configuration*    
        ![gambar](/task/stage-2/week-1/asset/nginx.conf.png)

        3. Check if the configuration is OK or NOT → `sudo nginx -t`
        4. restart nginx → `sudo systemctl restart nginx`

10. setup certbot