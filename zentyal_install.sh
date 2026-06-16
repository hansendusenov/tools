#!/bin/bash

# ==========================================
# Zentyal Server 8.1 Auto-Installer (Ubuntu 24.04 LTS)
# Repository: https://github.com/hansendusenov/tools
# ==========================================

# Berhenti otomatis jika ada perintah krusial yang gagal
set -e

echo "[1/6] Pengecekan Sistem..."
if [ "$EUID" -ne 0 ]; then
  echo "Error: Script ini harus dijalankan dengan sudo."
  exit 1
fi

# Pengecekan OS ketat untuk Ubuntu 24.04 LTS
UBUNTU_CODENAME=$(lsb_release -cs 2>/dev/null || grep VERSION_CODENAME /etc/os-release | cut -d= -f2)
if [ "$UBUNTU_CODENAME" != "noble" ]; then
  echo "PERINGATAN KRITIS: Script ini dirancang KHUSUS untuk Ubuntu 24.04 (Noble)."
  echo "Sistem Anda terdeteksi sebagai: $UBUNTU_CODENAME"
  echo "Instalasi dibatalkan otomatis untuk mencegah kerusakan sistem."
  exit 1
fi

# Mencegah pop-up interaktif saat instalasi package
export DEBIAN_FRONTEND=noninteractive

echo "[2/6] Update OS dan install dependencies..."
apt-get update
apt-get install -y wget ca-certificates apt-transport-https software-properties-common gnupg2 lsb-release

echo "[3/6] Mengimpor GPG Key Zentyal..."
# Menyelesaikan masalah NO_PUBKEY dengan menarik key langsung dari keyserver Ubuntu Port 80
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 07BE4CBFFDE85677 >/dev/null 2>&1 || true
gpg --export 07BE4CBFFDE85677 > /etc/apt/trusted.gpg.d/zentyal-recovered.gpg 2>/dev/null || true

echo "[4/6] Menambahkan Repository Sementara Zentyal 8.1..."
echo "deb http://packages.zentyal.org/zentyal 8.1 main extra" > /etc/apt/sources.list.d/zentyal-installer.list

echo "[5/6] Menginstal Zentyal Core..."
apt-get update
apt-get install -y --no-install-recommends zentyal

echo "[6/6] Membersihkan Konfigurasi Duplikat..."
# Menghapus repo sementara agar tidak memunculkan warning duplikat (karena installer zentyal otomatis membuat file .sources sendiri)
rm -f /etc/apt/sources.list.d/zentyal-installer.list
rm -f /etc/apt/sources.list.d/zentyal.list 2>/dev/null

echo "=========================================="
echo "Instalasi Zentyal Berhasil Sempurna Tanpa Error!"
echo "Dashboard siap diakses di:"
echo "https://$(hostname -I | awk '{print $1}'):8443"
echo "Login menggunakan username dan password OS Ubuntu ini."
echo "=========================================="
