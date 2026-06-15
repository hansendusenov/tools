#!/bin/bash

# ==========================================
# Zentyal Server FORCE Auto-Installer untuk Ubuntu 26.04
# Repository: https://github.com/hansendusenov/tools
# ==========================================

set -e

echo "[1/5] Pengecekan Akses Root..."
if [ "$EUID" -ne 0 ]; then
  echo "Error: Script ini harus dijalankan dengan sudo."
  exit 1
fi

echo "[2/5] Menyiapkan environment & bypass proteksi OS..."
export DEBIAN_FRONTEND=noninteractive

echo "[3/5] Injeksi Repository Sementara Ubuntu 24.04 (Noble)..."
# Menambahkan repo lama agar apt bisa mengambil dependency usang yang dibutuhkan Zentyal
echo "deb http://archive.ubuntu.com/ubuntu noble main restricted universe multiverse" > /etc/apt/sources.list.d/noble-temp.list

echo "[4/5] Menambahkan Repository & GPG Key Zentyal 8.1..."
# Menggunakan URL packages.zentyal.org yang valid untuk rilis 8.1
wget -qO - https://keys.zentyal.org/zentyal-8.1-packages-org.asc | cat > /etc/apt/trusted.gpg.d/zentyal_8.1.asc
echo "deb http://packages.zentyal.org/zentyal 8.1 main extra" > /etc/apt/sources.list.d/zentyal.list

echo "[5/5] Update APT & Memaksa Instalasi Zentyal..."
apt-get update

# Install Zentyal dan izinkan apt menarik/menurunkan versi package dari repo Noble
apt-get install -y --allow-downgrades --no-install-recommends zentyal

echo "Membersihkan repository sementara agar server tidak rusak saat update kedepannya..."
rm -f /etc/apt/sources.list.d/noble-temp.list
apt-get update

echo "=========================================="
echo "Instalasi Paksa Zentyal Selesai!"
echo "Silakan cek apakah Dashboard bisa diakses di:"
echo "https://$(hostname -I | awk '{print $1}'):8443"
echo "=========================================="
