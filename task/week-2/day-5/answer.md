# WEEK 2

## STAGE 1

---

### Step by Step deploy app

- #### NodeJS

1. install dan pastikan pakai [NodeJS 12](https://nodejs.org/en/download)

``` bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 12

# Verify the Node.js version:
node -v # Should print "v12.22.12".

# Verify npm version:
npm -v # Should print "6.14.16".

```

---

2. clone code [wayshub-frontend](https://github.com/dumbwaysdev/wayshub-frontend)


```bash
git clone git@github.com:dumbwaysdev/wayshub-frontend.git
```

![gambar](/task/week-2/day-5/asset/clone.png)

---

3. izinkan port 3000 bisa di akses

```bash
sudo ufw allow 3000
```

---

4. masuk ke folder `wayshub-frontend`

```bash
cd wayshub-frontend
```

---

5. jalankan app wayshub-frontend nya
    1. install yarn `npm install -g yarn`
    2. install dependency `yarn install`
    3. run wayshub-frontend dengan `yarn start`
    4. buka browser input `192.168.1.208:3000`

jika berhasil maka tampil seperti ini:
![gambar](/task/week-2/day-5/asset/start.png)

---

- #### Python

1. pastikan `python3` sudah ter-install

```bash
python3 --version
```
---

2. install `pip`

```bash
# install pip
sudo apt install -y python3-pip

# pastikan pip terinstall
pip3 --version
```

---

3. buat folder `python-app` dan masuk ke folder `python-app`

```bash
mkdir python-app

cd python-app

```

4. install `flask`

```bash
pip3 install flask
```

![gambar](/task/week-2/day-5/asset/flask.png)

---

5. bikin simple code untuk menampilkan `nama` dan berjalan di port `5000`

    1. buat file `app.py` dan input code nya

```python
# create file
nano app.py

# simple code
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Halo, nama saya Eko Edy P 👋</h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

```

![gambar](/task/week-2/day-5/asset/simple-code-py.png)
    2. izinkan port `5000` bisa di akses, lalu jalankan `simple code` nya 

```bash
# allow port 5000
sudo ufw allow 5000    

# run app
python3 app.py
```

![gambar](/task/week-2/day-5/asset/start-py.png)
    3. buka `browser` dan input `192.168.1.208:5000`

jika berhasil maka tampilan nya seperti ini:
![gambar](/task/week-2/day-5/asset/say-my-name.png)



---

- #### Golang

