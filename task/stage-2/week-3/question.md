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

- 