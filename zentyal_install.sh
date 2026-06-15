#!/bin/bash

# ==========================================
# Zentyal Server Auto-Installer
# Repository: https://github.com/hansendusenov/tools
# ==========================================

# 1. Pastikan script dijalankan sebagai root agar tidak minta password di tengah proses
if [ "$EUID" -ne 0 ]; then
  echo "Error: Script ini harus dijalankan sebagai root."
  echo "Gunakan perintah: sudo ./zentyal_install.sh"
  exit 1
fi

echo "[1/5] Menyiapkan environment non-interactive..."
# Mencegah munculnya pop-up konfigurasi dari paket seperti Postfix atau MySQL
export DEBIAN_FRONTEND=noninteractive

echo "[2/5] Update OS dan install dependencies dasar..."
apt-get update && apt-get upgrade -y
apt-get install -y wget ca-certificates apt-transport-https software-properties-common gnupg2

echo "[3/5] Menambahkan Repository dan GPG Key Zentyal 8.1..."
# Menggunakan GPG key terbaru ke trusted.gpg.d
wget -qO - http://keys.zentyal.org/zentyal-8.1-archive.asc | cat > /etc/apt/trusted.gpg.d/zentyal_8.1.asc
# Menambahkan source list Zentyal
echo "deb http://archive.zentyal.org/zentyal 8.1 main" > /etc/apt/sources.list.d/zentyal.list

echo "[4/5] Update list repository terbaru..."
apt-get update

echo "[5/5] Menginstal Zentyal Core..."
# Menginstal base Zentyal tanpa paket GUI desktop yang tidak perlu
apt-get install -y --no-install-recommends zentyal

echo "=========================================="
echo "Instalasi Zentyal Berhasil Diselesaikan!"
echo "Silakan buka browser dan akses Dashboard di:"
echo "https://$(hostname -I | awk '{print $1}'):8443"
echo "Login menggunakan username dan password OS Ubuntu ini."
echo "=========================================="
