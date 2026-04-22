# WEEK 4

## STAGE 2

#### Sebelum mengerjakan tugas, mohon persiapkan :


- Akun Github dan buat repository dengan judul `devops21-dumbways-<nama kalian>`

- Gunakan file `README.md` untuk isi tugas kalian

- Buatlah langkah-langkah pengerjaan tugas beserta dokumentasinya

- Gunakan vm Appserver kalian diskusikan saja ingin menggunakan vm siapa di dalam team

#### Repository && Reference:

- [Ingress-Nginx](https://docs.nginx.com/nginx-ingress-controller/)

- [k3s docs](https://docs.k3s.io/)

- [Alvin Docs](https://github.com/RizqyAlvindra/kubernetes/tree/master/k3s)

- [Kubernetes Docs](https://kubernetes.io/docs/home/)
---

#### Tasks :

### *[ Kubernetes ]*

1. Buatlah sebuah kubernetes cluster, yang di dalamnya terdapat 3 buah node as a master and worker.

2. Install ingress nginx using helm or manifest

3. Deploy aplikasi yang kalian gunakan di docker swarm, ke dalam kubernetes cluster yang terlah kalian buat di point nomer 1.

4. Setup persistent volume untuk database kalian

5. Deploy database mysql with statefullset and use secrets

6. Install cert-manager ke kubernetes cluster kalian, lalu buat lah wildcard ssl certificate.

7. Ingress
    - fe : name.kubernetes.studentdumbways.my.id
    - be : api.name.kubernetes.studentdumbways.my.id