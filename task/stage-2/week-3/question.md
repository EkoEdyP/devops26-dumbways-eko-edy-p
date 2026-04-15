# WEEK 2

## STAGE 2

#### Sebelum mengerjakan tugas, mohon persiapkan :


- Akun Github dan buat repository dengan judul `devops21-dumbways-<nama kalian>`

- Gunakan file `README.md` untuk isi tugas kalian

- Buatlah langkah-langkah pengerjaan tugas beserta dokumentasinya

---

#### Tasks :

### *[ Terraform ]*

- Dengan mendaftar akun free tier AWS/GCP/Azure, buatlah Infrastructre dengan terraform menggunakan registry yang sudah ada. dengan beberapa aturan berikut :
    - Buatlah 2 buah server dengan OS ubuntu 24 dan debian 11 (Untuk spec menyesuaikan)
    - attach vpc ke dalam server tersebut
    - attach ip static ke vm yang telah kalian buat
    - pasang firewall ke dalam server kalian dengan rule {allow all ip(0.0.0.0/0)}
    - buatlah 2 block storage di dalam terraform kalian, lalu attach block storage tersebut ke dalam server yang ingin kalian buat. (pasang 1 ke server ubuntu dan 1 di server debian)
    - test ssh ke server
    - Buat terraform code kalian serapi mungkin
    - simpan script kalian ke dalam github dengan format tree sebagai berikut:
```sh

Automation/
└── Terraform/
    ├── gcp/
    │   ├── main.tf
    │   ├── providers.tf
    │   └── etc
    │
    ├── aws/
    │   ├── main.tf
    │   ├── providers.tf
    │   └── etc
    │
    └── azure/
        ├── main.tf
        ├── providers.tf
        └── etc
```
Reference :

[Amazon Web Services (AWS)](https://aws.amazon.com/free/)

[Google Cloud Platform (GCP)](https://cloud.google.com/free)

[Microsoft Azure](https://azure.microsoft.com/en-us/pricing/free-services)

---

### *[ Ansible ]*

- Buatlah ansible untuk :
    - Membuat user baru, gunakan login ssh key & password
    - Instalasi Docker
    - Deploy application frontend yang sudah kalian gunakan sebelumnya menggunakan ansible.
    - Instalasi Monitoring Server (node exporter, prometheus, grafana)
    - Setup reverse-proxy
    - Generated SSL certificate
    - simpan script kalian ke dalam github dengan format tree sebagai berikut:
```sh
Automation/
├── Terraform/
│   ├── gcp/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   └── etc
│   │
│   ├── aws/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   └── etc
│   │
│   └── azure/
│       ├── main.tf
│       ├── providers.tf
│       └── etc
│
└── Ansible/
    ├── ansible.cfg
    ├── lolrandom1.yaml
    ├── group_vars/
    │   └── all
    ├── Inventory
    ├── lolrandom2.yaml
    └── lolrandom3.yaml
```


### *[ Monitoring Server ]*

- Setup node-exporter, prometheus dan Grafana menggunakan docker / native diperbolehkan
- monitoring seluruh server yang kalian buat di materi terraform dan yang kalian miliki di biznet.
- Reverse Proxy
    -bebas ingin menggunakan nginx native / docker
- Domain
    - exporter-$name.studentdumbways.my.id (node exporter)
    - prom-$name.studentdumbways.my.id (prometheus)
    - monitoring-$name.studentdumbways.my.id (grafana)
- SSL Cloufflare on / certbot SSL biasa / wildcard SSL diperbolehkan
- Dengan Grafana, buatlah :
    - Dashboard untuk monitor resource server (CPU, RAM & Disk Usage) buatlah se freestyle kalian.
    - Buat dokumentasi tentang rumus promql yang kalian gunakan
    - Buat alerting dengan Contact Point pilihan kalian (discord, telegram, slack dkk)
        - Untuk alert :
            - Boleh menggunakan alert manager / alert rule dari grafana
            - Ketentuan alerting yang harus dibuat
                - CPU Usage over 20%
                - RAM Usage over 75%

    - Monitoring specific container
    - deploy application frontend di app-server
    - monitoring frontend container
    - untuk alerting bisa di check di server discord yaa, sudah di buatkan channel alerting

Reference :

[node-exporter](https://hub.docker.com/r/prom/node-exporter)

[Prometheus](https://hub.docker.com/r/prom/prometheus)

[Grafana Dashboard](https://hub.docker.com/r/grafana/grafana)

[Cadvisor](https://github.com/google/cadvisor)