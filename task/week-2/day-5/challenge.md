# WEEK 2

## STAGE 1

### Description

## Challenge :

### 1. NodeJS + Python berjalan di background (tanpa kondisi attached di terminal)

- artinya, teman-teman tetep bisa menggunakan terminal di window yang sama namun app tetap berjalan

---

### 2. Golang bisa dibuka di browser kalian, menampilkan text "Jangan lupa sahur baby gurl rawr"

---


## Complete Challenge:

# **1**

---

### menjalankan `NodeJs app` di background terminal

1. masuk ke folder `wayshub-frontend` lalu build terlibih dahulu

```bash
yarn build
```

2. install serve versi lama

```bash
npm install -g serve@11
```

3. run di background 

```bash
nohup serve -s build -l 3000 > wayshub.log 2>&1 & echo $! > wayshub.pid
```

4. buka browser dan input `192.168.1.208:3000` untuk mengecek apakah sudah berjalan

5. dan untuk mematikan nya ikuti command di bawah

```bash
kill $(cat wayshub.pid)
```

---

### menjalankan `python app` di background terminal


1. untuk menjalankan python app di background langsung saja ikuti command di bawah

```bash
nohup python3 app.py > python-app.log 2>&1 & echo $! > python-app.pid
```

2. dan untuk mematikan nya 

```bash
kill $(cat python-app.pid)
```

---

# **2**

---

### menjalankan `GoLang app` di background

1. bikin file `main.go` dan isi dengan code di bawah

```go
package main

import (
        "fmt"
        "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "Jangan lupa sahur baby gurl rawr")
}

func main() {
        http.HandleFunc("/", handler)

        fmt.Println("Server running on port 6969...")
        http.ListenAndServe(":6969", nil)
}
```

2. init module dengan command di bawah

```bash
go-mod init <nama-folder>
```


3. build terlebih dahulu

```bash
go build -o go-app
```

4. run di background

```bash
nohup ./go-app > go-app.log 2>&1 & echo $! > go-app.pid
```

5. buka browser dan input `192.168.1.208:6969`

jika berhasil maka akan tampil seperti ini:
![gambar](/task/week-2/day-5/asset/challenge-rawr.png)

6. jika ingin mematikan ikuto commandi di bawah ini

```bash
kill $(cat go-app.pid)
```
