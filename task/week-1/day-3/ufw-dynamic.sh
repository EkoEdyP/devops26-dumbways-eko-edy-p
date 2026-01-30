#!/bin/bash

ACTION=$1
shift
PORTS=("$@")

if [ -z "$ACTION" ]; then
  echo "Usage:"
  echo "  ./ufw_dynamic.sh enable 22 80 443"
  echo "  ./ufw_dynamic.sh disable 22 80 443"
  exit 1
fi

if [ ${#PORTS[@]} -eq 0 ]; then
  echo "Error: Masukkan minimal 1 port!"
  exit 1
fi

enable_ufw() {
  echo "=== ENABLE UFW ==="
  sudo ufw enable

  for port in "${PORTS[@]}"
  do
    echo "Allow port $port"
    sudo ufw allow "$port"
  done

  sudo ufw status
}

disable_ufw() {
  echo "=== DISABLE UFW ==="

  for port in "${PORTS[@]}"
  do
    echo "Delete allow port $port"
    sudo ufw delete allow "$port"
  done

  sudo ufw disable
  sudo ufw status
}

case $ACTION in
  enable)
    enable_ufw
    ;;
  disable)
    disable_ufw
    ;;
  *)
    echo "Action tidak valid! Gunakan enable / disable"
    ;;
esac
