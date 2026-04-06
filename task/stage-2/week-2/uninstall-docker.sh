#!/bin/bash

# ==============================
# Docker Uninstaller (Official Way)
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

echo -e "${YELLOW}[*] Checking root...${NC}"
[ "$EUID" -ne 0 ] && error_exit "Jalankan dengan sudo/root"
success "Root OK"

echo -e "${YELLOW}[*] Checking OS...${NC}"
grep -qi "ubuntu" /etc/os-release || error_exit "Hanya untuk Ubuntu"
success "Ubuntu OK"

# ==============================
# CONFIRMATION (biar aman)
# ==============================

echo " "
echo -e "${RED}WARNING: Ini akan menghapus Docker SEPENUHNYA!${NC}"
read -p "Lanjut uninstall? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Dibatalkan."
    exit 0
fi

# ==============================
# UNINSTALL PACKAGES ==> Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:
# ==============================

echo " "
echo -e "${YELLOW}[*] Removing Docker packages...${NC}"

apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras \
|| error_exit "Gagal uninstall package"

success "Packages removed"

# ==============================
# REMOVE DATA ==> Images, containers, volumes, or custom configuration files on your host aren't automatically removed. To delete all images, containers, and volumes:
# ==============================

echo " "
echo -e "${YELLOW}[*] Removing Docker data...${NC}"

rm -rf /var/lib/docker || error_exit "Gagal hapus /var/lib/docker"
rm -rf /var/lib/containerd || error_exit "Gagal hapus /var/lib/containerd"

success "Data removed"

# ==============================
# REMOVE REPOSITORY & KEY ==> Remove source list and keyrings
# ==============================

echo " "
echo -e "${YELLOW}[*] Removing repository & key...${NC}"

rm -f /etc/apt/sources.list.d/docker.sources
rm -f /etc/apt/keyrings/docker.asc

success "Repository & key removed"

# ==============================
# CLEANUP
# ==============================

echo " "
echo -e "${YELLOW}[*] Cleaning unused packages...${NC}"

apt autoremove -y
apt autoclean -y

success "System cleaned"

# ==============================
# DONE
# ==============================

echo "===================================="
echo " DOCKER UNINSTALLED 💥"
echo "===================================="