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

2. clone code [wayshub-frontend](https://github.com/dumbwaysdev/wayshub-frontend)


```bash
git clone git@github.com:dumbwaysdev/wayshub-frontend.git
```

![gambar](/task/week-2/day-5/asset/clone.png)

3. izinkan port 3000 bisa di akses

```bash
sudo ufw allow 3000
```

4. masuk ke folder `wayshub-frontend`

```bash
cd wayshub-frontend
```

5. jalankan app wayshub-frontend nya
    1. install yarn `npm install -g yarn`
    2. install dependency `yarn install`
    3. run wayshub-frontend dengan `yarn start`
    4. buka browser input `192.168.1.208:3000`

jika berhasil maka tampil seperti ini:
![gambar](/task/week-2/day-5/asset/start.png)

---

- #### Python


---

- #### Golang

