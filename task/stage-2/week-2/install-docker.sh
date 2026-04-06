#!/bin/bash

# ==============================
# Docker Installer (Official Way)
# ==============================

set -e

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

error_exit() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

# ==============================
# VALIDATION
# ==============================

echo -e "${YELLOW}[*] Checking root access...${NC}"
if [ "$EUID" -ne 0 ]; then
    error_exit "Jalankan script dengan sudo/root"
fi
success "Root OK"

echo -e "${YELLOW}[*] Checking OS...${NC}"
if ! grep -qi "ubuntu" /etc/os-release; then
    error_exit "Script ini hanya untuk Ubuntu"
fi
success "Ubuntu detected"

echo -e "${YELLOW}[*] Checking internet...${NC}"
if ! ping -c 1 google.com &> /dev/null; then
    error_exit "Tidak ada koneksi internet"
fi
success "Internet OK"

# ==============================
# REMOVE CONFLICTING PACKAGES
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Removing conflicting packages...${NC}"

apt remove -y $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1) \
|| echo -e "${YELLOW}[WARNING] Tidak ada package konflik atau sudah bersih${NC}"

success "Conflicting packages handled"

# ==============================
# Add Docker's official GPG key:
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Adding Docker's official GPG key...${NC}"

apt update -y
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

success "GPG key added"

# ==============================
# ADD REPOSITORY
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Adding Docker repository...${NC}"

tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt update

success "Repository added"

# ==============================
# INSTALL DOCKER
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Installing Docker Engine...${NC}"

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
|| error_exit "Gagal install Docker"

success "Docker installed"

# ==============================
# START SERVICE
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Starting Docker...${NC}"

systemctl start docker
systemctl enable docker

success "Docker running"

# ==============================
# VERIFY
# ==============================

echo "===================================="
echo " "
echo -e "${YELLOW}[*] Verifying Docker...${NC}"

docker --version || error_exit "Docker gagal terinstall"
success "Docker ready 🚀"

echo " "
echo "===================================="
echo " INSTALLATION COMPLETE 🎉"
echo "===================================="