# WEEK 4

## STAGE 2

---

### Task Completion

##### **Steps to Complete the Task**

### *[Kubernetes]*

#### Setup

- create 3 VM
    - VM-1 for Master
    - VM-2 for Worker(app worker)
    - VM-3 for Worker (gateway worker)

---

1-2. membuat kubernetes cluster, yang di dalamnya terdapat 3 buah node as a master and worker. dan nstall ingress nginx using manifest
- *Master*
```
# Set hostname
sudo hostnamectl set-hostname master
echo master | sudo tee /etc/hostname

# Install K3s
curl -sfL https://get.k3s.io | sh -

# for kubectl permission on home atau bisa juga di sebut ngeREMOTE
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
source ~/.bashrc

# Verify
kubectl get nodes
kubectl get pods -A

# Edit/create config for disable traefik
sudo nano /etc/rancher/k3s/config.yaml

isi:
cluster-init: true
disable:
  - servicelb
  - traefik

# Restart:
sudo systemctl restart k3s  

# install ingress NGINX (AUTO DEPLOY K3s) pakai metode manifest auto deploy dari K3s (bukan helm manual)
sudo tee /var/lib/rancher/k3s/server/manifests/nginx-ingress.yaml > /dev/null <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: ingress-nginx
---
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  repo: https://kubernetes.github.io/ingress-nginx
  chart: ingress-nginx
  targetNamespace: ingress-nginx
  valuesContent: |-
    controller:
      service:
        type: LoadBalancer
EOF

# Restart:
sudo systemctl restart k3s  

# Verify
kubectl -n ingress-nginx get pods
kubectl get svc -n ingress-nginx

# Ambil token (MASTER)
sudo cat /var/lib/rancher/k3s/server/node-token
```

- *App*
```
# Join ke master
sudo hostnamectl set-hostname app

curl -sfL https://get.k3s.io | K3S_URL=https://103.197.189.7:6443 \
K3S_TOKEN=TOKEN_KAMU sh -
```
- ![image](/task/stage-2/week-4/asset/join.app.png)

- *Gateway*
```
# Join ke master
sudo hostnamectl set-hostname gateway

curl -sfL https://get.k3s.io | K3S_URL=https://103.197.189.7:6443 \
K3S_TOKEN=TOKEN_KAMU sh -
```
- ![image](/task/stage-2/week-4/asset/join.gateway.png)

- *Master*
```
# Verify
kubectl get nodes

output Harus muncul:
master
app
gateway

# add label (optional)
kubectl label node gateway node-role.kubernetes.io/gateway=true
kubectl label node app node-role.kubernetes.io/app=true
```
- ![image](/task/stage-2/week-4/asset/verify.png)

---

3. Deploy wayshub-frontend dan wayshub-backend

- *Master*

- create wayshub-frontend.yaml dan wayshub-backend.yaml
[wayshub-frontend.yaml yaml script]()
[wayshub-backend.yaml yaml script]()

```
# Mendeploy konfigurasi frontend dan backend ke cluster Kubernetes
kubectl apply -f wayshub-frontend.yaml
kubectl apply -f wayshub-backend.yaml

# Verify
kubectl get pods
kubectl get svc
```

---

4.
5.
6.
7.