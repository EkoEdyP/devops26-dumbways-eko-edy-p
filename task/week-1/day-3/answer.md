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

