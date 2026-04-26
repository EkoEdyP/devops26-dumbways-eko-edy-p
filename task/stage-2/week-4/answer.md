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

**1. creating a Kubernetes cluster consisting of three nodes:** `one master (VM-1) and two workers (VM-2 and VM-3).`
- **Master**
```bash
# log in as root
sudo su

# It is recommended to turn off ufw (uncomplicated firewall):
ufw disable

# Set hostname
hostnamectl set-hostname master
echo master > /etc/hostname

# Install K3s full or install K3s with disable traefik
# full
curl -sfL https://get.k3s.io | sh -
# disable traefik
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable traefik" sh -

# verify for disable traefik
- kubectl get pods -n kube-system | grep traefik
    - # The output must be empty

- kubectl get svc -n kube-system | grep traefik
    - # The output must be empty

- kubectl get helmchart -A | grep -i traefik
    - # The output must be empty

- ls /var/lib/rancher/k3s/server/manifests/
  - # Make sure there is no traefik.yaml file

- # Edit/create config for disable traefik
  - nano /etc/rancher/k3s/config.yaml
  
  #Paste the script below
  cluster-init: true
  disable:
    - traefik

# Restart
systemctl restart k3s

# log out as root
exit

# Configure kubectl Access
  # 1. To avoid the “kubectl: command not found” error in your home directory
  echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
  source ~/.bashrc

  # 2. To avoid the error “The connection to the server localhost:8080 was refused” or what is also known as a remote connection (from root to home and from the server to the local machine)
  mkdir -p ~/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
  sudo chown $USER:$USER ~/.kube/config
  echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
  source ~/.bashrc

# Verify on home
kubectl get nodes
kubectl get pods -A

# get token (MASTER)
sudo cat /var/lib/rancher/k3s/server/node-token
```

---

- **App**
```bash
# log in as root
sudo su

# set hostname
hostnamectl set-hostname app
echo app > /etc/hostname

# Join the master
curl -sfL https://get.k3s.io | K3S_URL=https://103.197.189.7:6443 \
K3S_TOKEN=YOUR_TOKEN sh -

- # Edit/create config for disable traefik
  - nano /etc/rancher/k3s/config.yaml
  
  #Paste the script below
  disable:
    - traefik

# Restart
systemctl restart k3s-agent
```
- ![image](/task/stage-2/week-4/asset/join.app.png)

---

- **Gateway**
```bash
# log in as root
sudo su

# set hostname
hostnamectl set-hostname gateway
echo gateway > /etc/hostname

# Join the master
curl -sfL https://get.k3s.io | K3S_URL=https://103.197.189.7:6443 \
K3S_TOKEN=YOUR_TOKEN sh -

- # Edit/create config for disable traefik
  - nano /etc/rancher/k3s/config.yaml
  
  #Paste the script below
  disable:
    - traefik

# Restart
systemctl restart k3s-agent
```
- ![image](/task/stage-2/week-4/asset/join.gateway.png)

---

- **Master**
```
# Verify
kubectl get nodes

#The output should be:
master
app
gateway

# add label
kubectl label node app node-role=app
kubectl label node gateway node-role=gateway
```
- ![image](/task/stage-2/week-4/asset/verify.png)
- ![image](/task/stage-2/week-4/asset/label.png)

---

**2. install ingress nginx using manifest**
- **Master**
```bash
# log in as root
sudo su

# # Create ingress-nginx manifest (K3s will auto-deploy anything inside this directory)
cat <<EOF > /var/lib/rancher/k3s/server/manifests/nginx-ingress.yaml
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
        type: NodePort
      nodeSelector:
        node-role: gateway
EOF

# Restart
systemctl restart k3s  

# Verify on terminal
kubectl -n ingress-nginx get pods -o wide
kubectl get svc -n ingress-nginx

# verify on browser
http://<IP-GATEWAY>:<NODEPORT>
```
- ![image](/task/stage-2/week-4/asset/verify.ingress.png)

---

3. Deploy wayshub-frontend dan wayshub-backend

- *Master*

- create Namespace `kubectl create namespace apps`
- create wayshub-frontend.yaml dan wayshub-backend.yaml
  - [wayshub-frontend.yaml yaml script](https://github.com/EkoEdyP/automation/blob/main/kubernetes/wayshub-frontend.yaml)
  - [wayshub-backend.yaml yaml script](https://github.com/EkoEdyP/automation/blob/main/kubernetes/wayshub-backend.yaml)

```
# Mendeploy konfigurasi frontend dan backend ke cluster Kubernetes
kubectl apply -f wayshub-frontend.yaml
kubectl apply -f wayshub-backend.yaml

# Verify
kubectl get pods -n apps -o wide
kubectl get svc -n apps
```
- ![image](/task/stage-2/week-4/asset/apply.app.png)
- ![image](/task/stage-2/week-4/asset/f.app.png)
- ![image](/task/stage-2/week-4/asset/b.app.png)

---

4. Setup persistent volume untuk database

- *Master*

- Set default local storage path
```
# Edit config k3s di master
cat >> /etc/rancher/k3s/config.yaml << EOF
default-local-storage-path: /mnt/data
EOF
```
- ![image](/task/stage-2/week-4/asset/pvc.conf.png)

```
# Verify the storage class is available
kubectl get storageClasses

# Restart k3s
systemctl restart k3s
```
- ![image](/task/stage-2/week-4/asset/storage.class.png)

- create pvc.yaml
  - [pvc.yaml yaml script](https://github.com/EkoEdyP/automation/blob/main/kubernetes/pvc.yaml)

```
# Apply konfigurasi PVC
kubectl apply -f pvc.yaml

# Verify
kubectl get pvc -n apps
kubectl describe pvc data-pvc -n apps
kubectl get pv
```

---

5.
6.
7. setup ingress

- eep.kubernetes.studentdumbways.my.id      → IP Gateway
- api.eep.kubernetes.studentdumbways.my.id  → IP Gateway
- [ingress.yaml yaml script](https://github.com/EkoEdyP/automation/blob/main/kubernetes/ingress.yaml)
```
# verify
kubectl -n apps get ingress
kubectl -n apps describe ingress app-ingress
```
