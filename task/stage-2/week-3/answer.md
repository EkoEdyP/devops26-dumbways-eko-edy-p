# WEEK 3

## STAGE 2

---

### Task Completion


##### **Steps to Complete the Task**

### *[ Terraform ]*
- install terraform
```sh
# Add the HashiCorp repository to your Homebrew list
brew tap hashicorp/tap
# Download and install the official version of Terraform from HashiCorp
brew install hashicorp/tap/terraform
# make sure success install
terraform version
```
- create `API Token on idcloudhost`
![gambar](/task/stage-2/week-3/asset/api.token.png)
![gambar](/task/stage-2/week-3/asset/api.token.2.png)
- get billing id
![gambar](/task/stage-2/week-3/asset/billing.id.png)
- install plugin for syntax highlighting and autocompletion (if u use VS CODE)
![gambar](/task/stage-2/week-3/asset/plugin.terraform.png)
- manage terraform
    - u can create folder structure and implement your conf on file
        - [automation script](https://github.com/EkoEdyP/automation)
        ![gambar](/task/stage-2/week-3/asset/tree.png)
- init terraform `terraform init`
![gambar](/task/stage-2/week-3/asset/init.terraform.png)
- checking plan terraform `terraform plan`
![gambar](/task/stage-2/week-3/asset/plan.terraform.png)
- apply terraform `terraform apply` and input `yes` for apply
![gambar](/task/stage-2/week-3/asset/apply.terraform.png)

---
### *[ Ansible ]*
- install ansible
```sh
# Update Homebrew: Ensure your packages are up to date
brew update
# Install Ansible
brew install ansible
# Verify
ansible --version
```

- Membuat user baru, gunakan login ssh key & password
![gambar](/task/stage-2/week-3/asset/01.png)
- Instalasi Docker
![gambar](/task/stage-2/week-3/asset/02.png)
- Deploy application frontend yang sudah kalian gunakan sebelumnya menggunakan ansible.
![gambar](/task/stage-2/week-3/asset/03.png)
- Instalasi Monitoring Server (node exporter, prometheus, grafana)
![gambar](/task/stage-2/week-3/asset/04.png)
- Setup reverse-proxy
![gambar](/task/stage-2/week-3/asset/05.png)
- Generated SSL certificate
![gambar](/task/stage-2/week-3/asset/06.png)
- simpan script kalian ke dalam github [link script ansible](https://github.com/EkoEdyP/automation)

---
### *[Monitoring Server]*
- Setup node-exporter, prometheus dan Grafana menggunakan docker via ansible
    - [script playbooks monitoring](https://github.com/EkoEdyP/automation/blob/main/ansible/playbooks/04-monitoring.yml)
    - [script roles monitoring](https://github.com/EkoEdyP/automation/tree/main/ansible/roles/monitoring)
    - *Prometheus*
    - ![Prometheus](/task/stage-2/week-3/asset/prome.png)
    - *Grafana*
    - ![Grafana](/task/stage-2/week-3/asset/grafa.png)
    - *Node Exporter*
    - ![Node Exporter](/task/stage-2/week-3/asset/nodeexpo.png)

- monitoring seluruh server yang kalian buat di materi terraform dan yang kalian miliki di biznet.
![gambar](/task/stage-2/week-3/asset/monitoring-dash.png)


- Reverse Proxy menggunakan nginx docker via ansible
    - [script playbooks nginx](https://github.com/EkoEdyP/automation/blob/main/ansible/playbooks/05-reverse-proxy.yml)
    - [script roles nginx](https://github.com/EkoEdyP/automation/tree/main/ansible/roles/nginx)

- Domain
    - exporter-$name.studentdumbways.my.id (node exporter)
    - prom-$name.studentdumbways.my.id (prometheus)
    - monitoring-$name.studentdumbways.my.id (grafana)

- Dashboard untuk monitor resource server (CPU, RAM & Disk Usage)
![gambar](/task/stage-2/week-3/asset/monitoring.ram.disk.cpu.png)

- dokumentasi tentang rumus promql yang kalian gunakan
- *CPU Usage (%)*
    - Query
    ```
    100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
    ```
    - Penjelasan
        - Query ini digunakan untuk menghitung persentase penggunaan CPU pada setiap instance.

    - Cara Kerja
        - `node_cpu_seconds_total{mode="idle"}`
            - Mengambil total waktu CPU dalam kondisi idle (tidak digunakan).
        - `rate(...[5m])`
            - Menghitung rata-rata perubahan per detik selama 5 menit terakhir.
        - `avg by(instance)`
            - Mengambil rata-rata dari semua core CPU dalam satu instance.
        - `* 100`
            - Mengubah nilai menjadi persen (%).
        - `100 - ...`
            - Karena yang dihitung adalah idle, maka dikurangi dari 100 untuk mendapatkan penggunaan CPU aktif.
    - Hasil
        - Nilai output berupa:
            - 0% → CPU idle (tidak digunakan)
            - 100% → CPU penuh digunakan
---

- *Memory Usage (%)*
    - Query
    ```
    (node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100
    ```
    - Penjelasan
        - Query ini digunakan untuk menghitung persentase penggunaan memory (RAM).

    - Cara Kerja
        - `node_memory_MemTotal_bytes`
            - Total memory yang tersedia pada sistem.
        - `node_memory_MemAvailable_bytes`
            - Memory yang masih tersedia untuk digunakan.
        - `MemTotal - MemAvailable`
            - Menghasilkan jumlah memory yang sedang digunakan.
        - `/ node_memory_MemTotal_bytes`
            - Menghitung rasio penggunaan terhadap total memory.
        - `* 100`
            - Mengubah nilai menjadi persen (%).

    - Hasil
        - Nilai output berupa:
            - Mendekati 0% → Memory hampir tidak digunakan
            - Mendekati 100% → Memory hampir penuh

---

- *Disk Usage (%)*
    - Query
    ```
    (node_filesystem_size_bytes{mountpoint="/",fstype!="tmpfs"} - node_filesystem_free_bytes{mountpoint="/",fstype!="tmpfs"}) / node_filesystem_size_bytes{mountpoint="/",fstype!="tmpfs"} * 100
    ```
    - Penjelasan
        - Query ini digunakan untuk menghitung persentase penggunaan disk pada root filesystem (`/`).

    - Cara Kerja
        - `node_filesystem_size_bytes`
            - Total kapasitas filesystem.
        - `node_filesystem_free_bytes`
            - Kapasitas yang masih kosong.
        - `size - free`
            - Menghasilkan kapasitas yang sudah digunakan.
        - `mountpoint="/"` dan `fstype!="tmpfs"`
            - Memfilter hanya disk root dan mengabaikan filesystem sementara (RAM).
        - `/ node_filesystem_size_bytes`
            - Menghitung rasio penggunaan terhadap total disk.
        - `* 100`
            - Mengubah nilai menjadi persen (%).

    - Hasil
        - Nilai output berupa:
            - 0% → Disk kosong
            - 100% → Disk penuh


---
- alerting dengan Contact Point discord dgn ketentuan alert: `CPU Usage over 20%` dan `RAM Usage over 75%`
    1. create discord webhooks
    2. create contact point on grafana `Alerting → Contact points → Add contact point`
    3. buat alert rule `CPU > 20%`
        1. Alerting → Alert rules → New alert rule
        2. ![gambar](/task/stage-2/week-3/asset/a1.png)
        3. ![gambar](/task/stage-2/week-3/asset/a2.png)
        4. ![gambar](/task/stage-2/week-3/asset/oac.png)
    4. buat alert rule `RAM > 75%`
        1. Alerting → Alert rules → New alert rule
        2. ![gambar](/task/stage-2/week-3/asset/a3.png)
        3. ![gambar](/task/stage-2/week-3/asset/a4.png)
        4. ![gambar](/task/stage-2/week-3/asset/oar.png)

---

- Monitoring specific container
    - install CaAdvisor on VM
    - open grafana for create new dashboard spesific container
    ![gambar](/task/stage-2/week-3/asset/front.monitoring.png)

