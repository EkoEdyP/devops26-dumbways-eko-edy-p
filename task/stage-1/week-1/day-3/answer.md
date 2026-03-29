# WEEK 1

## STAGE 1

### 1. step by step Akses server menggunakan kitty terminal

    1. buka VM ubuntu server dan login
    2. download Open SSH server di VM
```bash
sudo apt install openssh-server
```
    3. pastikan Status SSH di VM active(Running)
```bash
sudo systemctl status ssh
```
    4. chek IP VM dengan command 
```bash
ip a
```

![gambar](/task/week-1/day-3/asset/ip-a.png)

    5. buka kitty terminal
    6. akses VM dengan command di bawah (untuk ip nya menyesuaikan):

```bash
ssh eep@192.168.1.208
```
    7. masukkan password VM kalian, jika berhasil tampilannya akan seperti gambar di bawah    
![gambar](/task/week-1/day-3/asset/akses-vm.png)

---

### 2. Konfigurasi ssh agar bisa di akses hanya menggunakan publickey (password bisa dimatikan)

    1. generate SSH Key di Device kita
```bash
ssh-keygen
```

![gambar](/task/week-1/day-3/asset/ssh-keygen.png)

    2. masuk ke VM
    3. arahkan direktori ke `.ssh`
    4. masukkan ssh public key ke file `authorized_key`

```bash
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBu72xeCy3y+Wd7ODQM6RK3jpRy5tp2WaPfmLZkIIZ7C eep@eep.local" >> ~/.ssh/authorized_keys
```
![gambar](/task/week-1/day-3/asset/authorized_keys.png)
    5. test masuk VM menggunakan ssh public key dengan command di bawah (sesuaikan tempat penyimpanan ssh key nya)
```bash
ssh -i /Users/eep/Developments/playground/vm-ubuntu eep@192.168.1.208
```

![gambar](/task/week-1/day-3/asset/login-pubkey.png)

    6. sekarang atur config ssh agar bisa di akses hanya menggunakan publickey (password bisa dimatikan)
    7. masuk ke folder `/etc/ssh` edit file sshd_config seperti di bawah ini:

```bash
PubkeyAuthentication yes
PasswordAuthentication no
```

![gambar](/task/week-1/day-3/asset/edit-sshd-conf.png)

    8. restart SSH dengan command `sudo systemctl restart ssh`
    9. test login tanpa ssh public key, jika berhasil maka tampil seperti di bawah ini:

![gambar](/task/week-1/day-3/asset/login-without-pubkey.png)

    10. done, sekarang kita hanya bisa login ke VM menggunakan SSH Public Key

---

### 3. step by step penggunaan text manipulation! (grep, sed, cat, echo)

#### cat

**contoh penggunaan:**

``` bash
cat > file-1.txt
```
Fungsi:

    - Membuat file baru bernama file-1.txt, jika belum ada
    - Isi file diinput manual lewat terminal
    - Tekan CTRL + C untuk menyimpan dan keluar

---

``` bash
cat file-1.txt file-2.txt > file-3.txt
```
Fungsi:

    - Menggabungkan isi file-1.txt dan file-2.txt
    - Hasil gabungan disimpan ke file-3.txt
    - Jika file-3.txt belum ada → dibuat otomatis
    - Jika sudah ada → ditimpa

---

#### sed

**contoh penggunaan:**

```bash
sed -i 's/Hello/Hey/g' file-1.txt
```

Fungsi:

    - Mengganti semua teks `Hello` menjadi `Hey` di dalam file-1.txt
    - Opsi -i berarti `in place` (edit file in place)
    - Flag g (global) memastikan semua kemunculan dalam satu baris ikut diganti

---

#### grep

**contoh penggunaan:**

```bash
grep hey file-1.txt
```
Fungsi:

    - Mencari teks `hey` di dalam file `file-1.txt`
    - Menampilkan baris yang mengandung kata tersebut

---

```bash
grep -c hey file-1.txt
```

Fungsi:

    - Menghitung jumlah baris yang mengandung teks hey di file-1.txt
    - Output berupa angka

---

```bash
grep hey *
```

Fungsi:

    - Mencari teks `hey` di semua file dalam direktori saat ini
    - menampilkan isi baris yang mengandung `hey`

---   

```bash
grep -c hey *
```

Fungsi:

    - Menghitung jumlah baris yang mengandung teks hey pada setiap file

---  

#### echo

**contoh penggunaan:**

```bash
echo "Hello World" > file-1.txt
```

Fungsi:

    - membuat lalu Menulis teks Hello World ke file `file-1.txt`
    - Jika file sudah ada, isinya ditimpa

---

```bash
echo "Hey dumbways" >> file-1.txt
```

Fungsi:

    - Menambahkan teks ke akhir file file-1.txt
    - Isi lama tidak dihapus

---

### 4. Nyalakan ufw dengan memberikan akses untuk port 22, 80, 443, 3000, 5000 dan 6969!

    1. login VM
    2. aktifkan ufw dengan command
```bash
sudo ufw enable
```
    3. izinkan OpenSSh
```bash
sudo ufw allow OpenSSH
```
    4. by default OpenSSH menggunakan port 22, check menggunakan command ini
```bash
sudo ufw app info OpenSSH
```
    5. beri ufw akses ke port 80, 443, 3000, 5000, 6969
```bash
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3000
sudo ufw allow 5000
sudo ufw allow 6969
```
    6. pastikan port 22, 80, 443, 3000, 5000, 6969 bisa di akses.
![gambar](/task/week-1/day-3/asset/port.png)
