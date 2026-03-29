# WEEK 2

## STAGE 1

### 1. Penjelasan tentang git

git adalah salah satu `version control system` yang di ciptakan oleh linus torvalds dengan fitur unggulannya **distributed revision control** yang artinya penyimpanan git tidak hanya berada dalam satu tempat saja, tetapisemua orang yang terlibat dalam pengkodean proyek akan menyimpan database git, sehingga akan memudahkan dalam mengelola proyek baik offline maupun online.

---

### 2. step by step memBuat sebuah repository bernama `devops26-dumbways-<nama>`, lalu tambahkan 3 file yang berisi text

1. buka terminal

---

2. buat folder `devops26-dumbways-ekoedyp`

contohnya:

```bash
    mkdir devops26-dumbways-ekoedyp
```

---

3. masuk ke folder `devops26-dumbways-ekoedyp`
contohnya:

```bash
cd devops26-dumbways-ekoedyp
```

---

4. buat 3 file yang berisi text
contohnya:

```bash
# membuat file-1.txt dan menginput isi dari file-1.txt (buat file-1.txt, file-2.txt, file-3.txt)
nano file-1.txt
``` 

---

5. buka github di browser, buat repository dengan nama `devops26-dumbways-ekoedyp`

---

6. masuk ke terminal, hubungkan ke github
    + step hubungin ke github
        - buka terminal dan arahkan ke folder `devops26-dumbways-ekoedyp` lalu inisiasi `git init`
        - `git add file-1.txt, file-2.txt, file-3.txt`
        - `git commit -m "feat: add 3 files"`
        - `git remote add origin git@github.com:EkoEdyP/devops26-dumbways-ekoedyp.git`
        - `git branch -M main`
        - `git push -u origin main`


---

### 3. Manage repository tugas kalian menggunakan terminal!

1. settig config git terlebih dahulu

```bash
git config --global user.name "EkoEdyP"
git confih --global user.email "ekoedypurwantooke@gmail.com"
```

---

2. pastikan config name dan email nya sesuai

```bash
git config --global --list
```

---

3. setting SSH
    - masuk ke terminal
    - generate ssh --> ssh-keygen
    - copy public key ssh nya dan paste di github nya
        + berikut step by step nya
            - masuk ke github 
            - klik setting 
            - klik SSH and GPG keys 
            - klik new SSH Key
            - input title dan paste public key nya
            - masuk ke terminal --> ssh git@github.com -T --> yes

---

4. clone repo tugas nya menggunakan ssh

```bash
git clone git@github.com:EkoEdyP/devops26-dumbways-eko-edy-p.git
```

---

5. masuk ke folder tugas yang sudah di clone, selamat anda sekarang bisa bebas manage repository tugas di terminal


```bash
cd devops26-dumbways-eko-edy-p
```

---


### 4. Demokan cara untuk mencari perubahan text pada suatu file di GitHub!

1. masuk ke terminal dan arahkan ke folder tugas

```bash
cd dumbways/devops26-dumbways-eko-edy-p/
```

![gambar](/task/week-2/day-4/asset/cd.png)

---

2. disini saya mencoba untuk membuat file example.txt untuk mendemokan cara untuk mencari perubahan pada text

![gambar](/task/week-2/day-4/asset/example.png)

