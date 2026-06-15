#!/bin/bash

# ==========================================
# Zentyal Server Auto-Installer
# Repository: https://github.com/hansendusenov/tools
# ==========================================

# Menghentikan script secara otomatis jika ada command yang gagal/error
set -e

echo "[1/6] Melakukan pra-pengecekan sistem..."

# Pengecekan akses root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Script ini harus dijalankan dengan sudo."
  echo "Gunakan: curl -sL https://raw.githubusercontent.com/hansendusenov/tools/main/zentyal_install.sh | sudo bash"
  exit 1
fi

# Pengecekan kompatibilitas OS (Mencegah instalasi di Ubuntu 26.04 yang belum didukung)
UBUNTU_CODENAME=$(lsb_release -cs 2>/dev/null || cat /etc/os-release | grep VERSION_CODENAME | cut -d= -f2)
if [ "$UBUNTU_CODENAME" == "resolute" ]; then
  echo "PERINGATAN KRITIS: Anda menggunakan Ubuntu 26.04 (Resolute)."
  echo "Zentyal saat ini belum merilis package yang kompatibel untuk versi ini."
  echo "Proses instalasi dibatalkan untuk mencegah dependency hell/kerusakan sistem Anda."
  exit 1
fi

echo "[2/6] Menyiapkan environment non-interactive..."
export DEBIAN_FRONTEND=noninteractive

echo "[3/6] Update OS dan install dependencies dasar..."
apt-get update && apt-get upgrade -y
apt-get install -y wget ca-certificates apt-transport-https software-properties-common gnupg2 lsb-release

echo "[4/6] Menambahkan Repository dan GPG Key Zentyal 8.0..."
# Menggunakan URL repositori 8.0 yang valid
wget -qO - http://keys.zentyal.org/zentyal-8.0-archive.asc | cat > /etc/apt/trusted.gpg.d/zentyal_8.0.asc
echo "deb http://archive.zentyal.org/zentyal 8.0 main" > /etc/apt/sources.list.d/zentyal.list

echo "[5/6] Update list repository terbaru..."
apt-get update

echo "[6/6] Menginstal Zentyal Core..."
apt-get install -y --no-install-recommends zentyal

echo "=========================================="
echo "Instalasi Zentyal Berhasil Diselesaikan!"
echo "Silakan buka browser dan akses Dashboard di:"
echo "https://$(hostname -I | awk '{print $1}'):8443"
echo "Login menggunakan username dan password OS Ubuntu ini."
echo "=========================================="
