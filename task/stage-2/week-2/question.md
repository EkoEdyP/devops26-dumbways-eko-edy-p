# WEEK 2

## STAGE 2

#### Sebelum mengerjakan tugas, mohon persiapkan :


- Akun Github dan buat repository dengan judul `devops21-dumbways-<nama kalian>`

- Gunakan file `README.md` untuk isi tugas kalian

- Buatlah langkah-langkah pengerjaan tugas beserta dokumentasinya

- Gunakan vm Appserver kalian diskusikan saja ingin menggunakan vm siapa di dalam team

#### Repository && Reference:

[Wayshub Backend](https://github.com/dumbwaysdev/wayshub-backend.git)

[Wayshub Frontend](https://github.com/dumbwaysdev/wayshub-frontend.git)

[Certbot](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal)

[PM2 Runtime With Docker](https://pm2.keymetrics.io/docs/usage/docker-pm2-nodejs)

---

#### Tasks :

### *[ Docker ]*

- Buatlah suatu user baru dengan nama team kalian

- Buatlah bash script se freestyle mungkin untuk melakukan installasi docker.

- Deploy aplikasi Web Server, Frontend, Backend, serta Database on top docker compose

- Ketentuan buatlah 2 environment yaitu (staging dan production)

    - *Ketentuan di Staging*
        - Buat suatu docker compose yang berisi beberapa service kalian
            - Web Server
            - Frontend
            - Backend
            - Database

        - Untuk penamaan image, sesuaikan dengan environment masing masing, ex: team1/dumbflx/frontend:staging

        - Di dalam docker-compose file buat suatu custom network dengan nama team kalian, lalu pasang ke setiap service yang kalian miliki.

        - Deploy database terlebih dahulu menggunakan mysql dan jangan lupa untuk pasang volume di bagian database.

    - *Ketentuan di Production*
        - Deploy database di server terpisah
        - Server Backend terpisah dengan 2 container di dalamnya
        - Server Frontend terpisah dengan 2 container di dalamnya
        - Web Server juga terpisah untuk reverse proxy kalian nantinya.
        - Untuk penamaan image, sesuaikan dengan environment masing masing, ex: team1/dumbflx/frontend:production
        - Untuk building image frontend dan backend sebisa mungkin buat dockerized dengan image sekecil mungkin(gunakan multistage build). dan jangan lupa untuk sesuaikan configuration dari backend ke database maupun frontend ke backend sebelum di build menjadi docker images.
        - Untuk Web Server buatlah configurasi reverse-proxy menggunakan nginx on top docker.
        - SSL CLOUDFLARE OFF!!!
        - Gunakan docker volume untuk membuat reverse proxy
        - SSL gunakan wildcard

- Untuk DNS bisa sesuaikan seperti contoh di bawah ini
    *Staging*
        - Frontend: team1.staging.studentdumbways.my.id
        - Backend: api.team1.staging.studentdumbways.my.id

    *Production*
        - Frontend: team1.studentdumbways.my.id
        - Backend: api.team1.studentdumbways.my.id

- Push image ke docker registry kalian masing".
- Aplikasi dapat berjalan dengan sesuai seperti melakukan login/register.

[ Jenkins ]

Installasi Jenkins on top Docker or native

Setup SSH-KEY di local server jenkins kalian, agar dapat login ke dalam server menggunakan SSH-KEY

Reverse Proxy Jenkins

gunakan domain ex. jenkins.team1.studentdumbways.my.id

reverse proxy sesuaikan dengan ketentuan yang ada di dalam Jenkins documentation

Buatlah beberapa Job untuk aplikasi kalian yang telah kalian deploy di task sebelumnya (staging && production)

Untuk script CICD atur flow pengupdate an aplikasi se freestyle kalian dan harus mencangkup

Pull dari repository

Dockerize/Build aplikasi kita

Test application

Push ke Docker Hub

Deploy aplikasi on top Docker

Auto trigger setiap ada perubahan di SCM

Buat job notification ke discord

[ Gitlab ]

Implementasikan penggunaan Gitlab Runner pada aplikasi Frontend Kalian

Buatlah beberapa Job untuk aplikasi kalian yang telah kalian deploy di task sebelumnya (staging && production)

Untuk script CICD atur flow pengupdate an aplikasi se freestyle kalian dan harus mencangkup

Pull dari repository

Dockerize/Build aplikasi kita

Test application

Push ke Docker Hub

Deploy aplikasi on top Docker

Auto trigger setiap ada perubahan di SCM

Buat job notification ke discord