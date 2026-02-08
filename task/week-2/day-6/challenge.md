# WEEK 2

## STAGE 1

### Description

## Challenge :

### 1.Terapkan Load Balancing untuk wayshub-frontend menggunakan 2 server dengan spek yang sama


### 2. Gunakan 2 dari 3 pilihan method ini :
        - Round Robin (Request dibagi bergiliran ke tiap backend)
        - IP Hash (client selalu ke server yang sama (sticky))
        - Least Connections (Request dikirim ke server dengan koneksi aktif paling sedikit)


---

## Complete Challenge:

---
1. **Menyiapkan 2 VM**

Untuk menerapkan load balancing, saya membuat 2 VM Ubuntu dengan spesifikasi yang sama dan menjalankan aplikasi `wayshub-frontend` pada masing-masing server.

Step by step pembuatan VM, instalasi dependency, dan menjalankan aplikasi dapat dilihat pada: [dokumentasi saya sebelumnya](https://github.com/EkoEdyP/devops26-dumbways-eko-edy-p)


`contoh VM:`
| VM        | IP Address      | Port |
|-----------|-----------------|------|
| VM      1 | 192.168.1.208   | 3000 |
| VM      2 | 192.168.1.210   | 3000 |

---

2. **Konfigurasi NGINX Load Balancing**

```nginx

upstream ekoedyp {
    server 192.168.1.208:3000;
    server 192.168.1.210:3000;
}

server {
    server_name ekoedyp.xyz;

    location / {
        proxy_pass http://ekoedyp;
    }
}

```

3. **Testing dan validation**

```bash
# Cek konfigurasi NGINX, is Ok ?
sudo nginx -t

# reload NGINX
sudo systemctl reload nginx

# Akses domain
http://ekoedyp.xyz:3000
```