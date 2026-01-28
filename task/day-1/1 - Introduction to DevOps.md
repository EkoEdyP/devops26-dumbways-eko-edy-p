# WEEK 1

## STAGE 1

### Description
Syarat tugas:

- Membuat repository di GitHub dengan nama:
  `devops26-dumbways-<nama>`
- Membuat folder task per harinya dengan file `README.md` (bisa dibuat per folder/directory)

---

## Task

### 1. Pengertian DevOps
Jelaskan secara konsep apa itu **DevOps** menggunakan bahasa kalian sendiri.

---

### 2. Instalasi Ubuntu Server
Install **Ubuntu Server 22.04.x LTS** menggunakan salah satu virtualization tool berikut:

- VirtualBox
- VMware
- Virtualization tool pilihan lainnya

Sertakan **step-by-step proses instalasi** secara jelas.

---

### 3. Konfigurasi IP Address
Gunakan IP Address xxx.xxx.xxx.208 untuk server VM kalian!


---

### 4. Test Koneksi Jaringan
Pastikan Ubuntu Server terhubung ke jaringan dengan menjalankan perintah berikut:

```bash
ping 8.8.8.8
ping google.com
```

---

## Answer

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

### 2. step by step Instalasi Ubuntu Server menggunakan vertual box di MacOS dengan PM Homebrew

1. install Homebrew
copy perintah di bawah ini dan paste di terminal

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

![gambar](/asset/install-homebrew.png)

2. install virtual box dengan Homebrew
copy perintah di bawah ini dan paste di terminal

```bash
brew install --cask virtualbox
```

![gambar](/asset/install-virtualbox.png)

3. download iso ubuntu server 22.04.5 LTS

[download disini](https://cdimage.ubuntu.com/releases/22.04.5/release/ubuntu-22.04.5-live-server-arm64.iso)

4. Membuat dan mengkonfigurasi Virtual Machine Baru

  - Buka **VirtualBox**
  - Klik **New**
  - Isi konfigurasi:
    - VM Name: distro ubuntu 22.04.5 LTS
    - VM Folder: /Users/eep/VirtualBox VMs
    - ISO Image: /Users/eep/Downloads/ubuntu-22.04.5-live-server-arm64.iso
    - OS: Linux
    - OS Distribution: Ubuntu (ARM 64 bit)

![gambar](/asset/isi-konfigurasi-vm.png)
  
  - isi konfigurasi hardware
    - **Memory (RAM)** Minimal: `1024 MB` Disarankan: `2048 MB` atau lebih
    - **CPU** 1–2 Core (sesuai spesifikasi Mac)
    - **Disk** Minimal: `20 GB`Disarankan: `40 GB`

![gambar](/asset/isi-konfigurasi-hardware-vm.png)

  - klik next untuk melihat summary, jika sudah sesuai klik finish.

![gambar](/asset/summary.png)

5. Menjalankan Virtual Machine yang sudah di konfigurasi sebelumnya

  - klik button machines di sebelah kiri lalu pilih vm yang sudah di buat sebelumnya dan klik start untuk menjalankannya

![gambar](asset/summary.png)

  - klik try or install ubuntu server
![gambar](/asset/install-ubuntu-server.png)

  - pilih bahasa yang mau di gunakan
![gambar](/asset/pilih-bahasa.png)

  - pilih continue without updating
![gambar](/asset/continue-without-updating.png)

  - pilih keyboard varian lalu klik done
![gambar](/asset/keyboard-varian.png)

  - pilih tipe instalasi lalu klik done
![gambar](/asset/tipe-instalasi.png)

  - set network configurasi lalu klik done
![gambar](/asset/network-conf.png)

  - set proxy addres jika di butuhkan lalu klik done
![gambar](/asset/proxy-conf.png)

  - menentukan mirror address lalu klik done
![gambar](/asset/mirror-address.png)

  - tentukan storage configuration lalu klik done
![gambar](/asset/storage-conf.png)

  - pastikan summary storage conf nya lalu klik done
![gambar](/asset/summary-storage-conf.png)

  - klik continue pada window pop up
![gambar](/asset/window-popup.png)

  - set profile configuration lalu klik done
![gambar](/asset/profile-conf.png)

  - skip upgrade ubuntu pro lalu klik continue
![gambar](/asset/ubuntu-pro.png)

  - install ssh lalu klik done
![gambar](/asset/ssh.png)

  - pilih feature server snap lalu klik done
![gambar](/asset/feat-snap.png)

  - tunggu proses intalasi sistem selesai
![gambar](/asset/install-system.png)

  - jika proses intalasi sistem selesai akan muncul pop up untuk reboot, lalu pilih reboot
![gambar](/asset/reboot.png)

  - setelah reboot selesai login dengn username dan password yang sudah di atur sebelumnya
![gambar](/asset/login.png)

  - tampilan jika login berhasil
![gambar](/asset/success-login.png)


### 3. step by step menggunakan IP Address xxx.xxx.xxx.208 untuk server VM kita!
  - Buka **VirtualBox**
  - Pilih VM → **Settings**
  - Masuk ke **Network**
  - Pilih salah satu:
    - **Bridged Adapter**
    - Name: `Wi-Fi (en0)`

![gambar](/asset/set-ip.png)



### 4. Pastikan Ubuntu Server kalian ada jaringan dengan test menggunakan command `ping 8.8.8.8` / `ping google.com`

![gambar](/asset/test-ping.png)

  










