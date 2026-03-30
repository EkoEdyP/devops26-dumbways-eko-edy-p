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

4. manage and secure mysql
    1. install mysql-server → `sudo apt install mysql-server`
    2. setup secure installation → `sudo mysql_secure_installation`
    3. login mysql → `sudo mysql`
    4. add password for root user → `ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'the-new-password';`
    5. create new user → `CREATE USER 'eep'@'localhost' IDENTIFIED BY 'the-password';`
    6. create new database → `CREATE DATABASE wayshub;`
    7. Create privileges for your new user so they can access the database you created → `GRANT ALL PRIVILEGES ON wayshub.* TO 'eep'@'localhost';`
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

INSERT INTO transaction (amount, description) VALUES (5000, 'Test guest'); // Harus gagal (permission denied)

```    