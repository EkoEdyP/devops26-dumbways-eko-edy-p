# WEEK 1

## STAGE 2

#### Sebelum mengerjakan tugas, mohon persiapkan :

- Akun Github dan buat repository dengan judul `devops21-dumbways-<nama kalian>`

- Gunakan file `README.md` untuk isi tugas kalian

- Buatlah langkah-langkah pengerjaan tugas beserta dokumentasinya

#### Requirment:

- Appserver for deploying Database

- Gateway for deploying Frontend Application, Backend Application, And Web Server

- Create new user for all of your server

- The server only can login with SSH-KEY without using password at all

- Deploy database MySQL

  - Setup secure_installation

  - Add password for root user

  - Create new user for MySQL

  - Create new database

  - Create privileges for your new user so they can access the database you created

  - Dont forget to change the MySQL bind address on /etc/mysql/mysql.conf.d/mysqld.cnf

- Role Based

  - Create new database call demo and make some dummy table call transaction

  - Create a 2 role with the name admin, and guest that will be used to see and manage the 'transaction' table.

  - Give SELECT, INSERT, UPDATE, and DELETE access rights to the transaction table for the admin role you just created. and only give SELECT access to guest.

  - Create a new user with the username your_name and password your_password. Add the user to the admin role.

  - Create a new user with the username guest and password guest. Add the user to the guest role.

  - Test all of your user

- Remote User

  - Try to remote your database from your local computer with mysql-client

- Deploy Wayshub-Backend

  - Clone wayshub backend application

  - Use Node Version 14

  - Dont forget to change configuration on wayshub-backend/config/config.json and then adjust it to your database.

  - Install sequelize-cli

  - Running migration

  - Deploy apllication on Top PM2

- Clone Wayshub-Frontend application

  - Use Node Version 14

  - Dont forget to change configuration on src/config/api.js and then adjust it to backend url.

  - Deploy frontend apllication on Top PM2