# WEEK 1

## STAGE 1

### 1. Pengertian DevOps

Bayangkan **DevOps itu seperti dapur restoran**.

Di dalam dapur ada dua peran utama:
- **Chef** → *Developer*  
  Bertugas memasak makanan (membuat aplikasi atau fitur).
- **Pelayan** → *Operations (Ops)*  
  Bertugas mengantarkan makanan dan memastikan dapur serta peralatan siap digunakan (server, jaringan, deployment).

---

#### Tanpa DevOps
Chef memasak secepat mungkin tanpa peduli cara penyajian.  
Pelayan menerima makanan tanpa tahu detail isinya.

Akibatnya:
- Makanan datang terlambat ❌  
- Pesanan bisa salah ❌  
- Pelanggan tidak puas ❌  

---

#### Dengan DevOps
Chef dan pelayan bekerja **bersama sejak awal**:
- Chef memahami bagaimana makanan akan disajikan dengan aman dan cepat  
- Pelayan memahami isi makanan dan cara menanganinya  

Mereka menggunakan:
- Standar kerja yang jelas  
- Alat bantu otomatisasi (CI/CD, monitoring, dan deployment)

Hasilnya:
- Makanan sampai lebih cepat ✅  
- Kualitas konsisten ✅  
- Pelanggan puas ✅  

---

#### Kesimpulan
**DevOps adalah budaya kerja** yang menyatukan Developer dan Operations agar:
- Pengembangan aplikasi lebih cepat  
- Sistem lebih stabil  
- Perawatan dan deployment lebih mudah  

**DevOps = kolaborasi + otomatisasi + tanggung jawab bersama**

---

### 2. step by step Instalasi Ubuntu Server 22.04.5 LTS menggunakan Parrarels Desktop

  1. install parrarels desktop [disini](https://www.parallels.com/products/desktop/trial/)

  2. download iso ubuntu server 22.04.5 LTS [disini](https://cdimage.ubuntu.com/releases/22.04.5/release/ubuntu-22.04.5-live-server-arm64.iso)

  3. Membuat dan mengkonfigurasi Virtual Machine Baru
  - Buka **Parrarels Desktop**
  - di bagian pilih install windows, linux, or macos from an image file, lalu klik continue
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/create-new-pd.png)
  - tentukan iso nya, lalu klik continue
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/set-iso.png)
  - isi nama dan pilih lokasi penyimpanan vm, lalu klik create
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/set-name-and-loc.png)
  - klik configure untuk menentukan CPUs, Memory, Disk Space, lalu klik continue
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/set-hardware.png)
  - star VM dan pilih try or install ubuntu
  - tentukan bahasa
  - tentukan keyboard style
  - pilih tipe instalasi, lalu klik done
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/install-type.png)
  - setting manual network configurtion (sesuaikan), lalu klik done
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/net-conf.png)
  - skip proxy conf, lalu klik done
  - set default saja mirror conf nya, lalu klik done, dan jika muncul pop up klik continue
  - untuk guide storage configuration saya pilih by default saja, lalu klik done
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/storage-conf.png)
  - pastikan summary sudah sesuai dengan yang kita inginkan, lalu klik done dan jika muncul pop up klik continue
  - isi profile configuration, lalu klik done
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/profile-conf.png)
  - skip upgrade ubuntu pro, lalu klik continue
  - skip install Open SSH Server, lalu klik done
  - skip feature server snap, lalu klik done
  - tunggu proses installing system sampai selesai 
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/install-system.png)
  - jika sudah selesai proses instalasi sistem nya, klik reboot now
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/reboot.png)
  - login dengan username dan password, maka hasilnya seperti ini.
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/login.png)


---
3. test ping 
![gambar](/devops26-dumbways-eko-edy-p/task/day-1/asset/test-ping.png)











