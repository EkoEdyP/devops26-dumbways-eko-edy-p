# WEEK 2

## STAGE 1

---

### 1. sturktur web server menggunakan reverse proxy

![gambar](/task/week-2/day-6/asset/reverse-proxy.drawio.png)

---

### 2. step by step membuat reverse proxy pada `wayshub-frontend`dan set domain menjadi `ekoedyp.xyz`

**1**. set domain di `MacOS`

hasilnya:
![gambar](/task/week-2/day-6/asset/host.png)


**2**. install `nginx`

```bash
# install
sudo apt install nginx

# memastikan running
sudo systemctl status nginx
```

**3**. set `configuration` untuk `reverse proxy`

```bash
# masuk ke folder untuk membuat configuration
cd /etc/nginx/sites-available

# buat file untuk set configuration
sudo nano wayshub-frontend.conf

# isi file nya
server {
    server_name ekoedyp.xyz;

    location / {
        proxy_pass http://192.168.1.208:3000;
    }
}

# cek configuration nya Ok atau TIDAK
sudo nginx -t

# restart nginx
sudo systemctl restart nginx
```

![gambar](/task/week-2/day-6/asset/set-conf.png)

*4*. buka browser lalu input `ekoedyp.xyz:3000`

jika berhasil maka akan tampil seperti ini:
![gambar](/task/week-2/day-6/asset/ekoedyp.xyz.png)

