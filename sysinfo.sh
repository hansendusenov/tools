#!/bin/bash

# ==============================
# HansenFetch v1.1
# Author : Hansen Dusenov
# ==============================

# ===== Colors =====
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

# ===== Functions =====
get_public_ip() {
    curl -s --max-time 2 https://api.ipify.org 2>/dev/null
}

get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}'
}

# ===== Collect Data =====
OS=$(source /etc/os-release 2>/dev/null && echo $PRETTY_NAME)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
HOST=$(hostname)
CPU=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | xargs)
SPEED=$(awk -F: '/cpu MHz/ {printf "%.2f GHz", $2/1000; exit}' /proc/cpuinfo)
CORES=$(nproc)
RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
DISK_USED=$(df -h --total | awk '/total/ {print $3}')
DISK_TOTAL=$(df -h --total | awk '/total/ {print $2}')
IPLOCAL=$(hostname -I | awk '{print $1}')
IPPUBLIC=$(get_public_ip)
CPU_USAGE=$(get_cpu_usage)

clear

# ===== ASCII HANSEN =====
echo -e "${CYAN}"
echo "██╗  ██╗ █████╗ ███╗   ██╗███████╗███████╗███╗   ██╗"
echo "██║  ██║██╔══██╗████╗  ██║██╔════╝██╔════╝████╗  ██║"
echo "███████║███████║██╔██╗ ██║███████╗█████╗  ██╔██╗ ██║"
echo "██╔══██║██╔══██║██║╚██╗██║╚════██║██╔══╝  ██║╚██╗██║"
echo "██║  ██║██║  ██║██║ ╚████║███████║███████╗██║ ╚████║"
echo "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═══╝"
echo -e "${RESET}"

echo -e "${GREEN}HansenFetch - System Information${RESET}"
echo -e "${YELLOW}--------------------------------------------------${RESET}"

printf "${BLUE}%-15s${RESET} : %s\n" "OS"          "$OS"
printf "${BLUE}%-15s${RESET} : %s\n" "Kernel"      "$KERNEL"
printf "${BLUE}%-15s${RESET} : %s\n" "Uptime"      "$UPTIME"
printf "${BLUE}%-15s${RESET} : %s\n" "Hostname"    "$HOST"
printf "${BLUE}%-15s${RESET} : %s\n" "CPU Model"   "$CPU"
printf "${BLUE}%-15s${RESET} : %s\n" "CPU Speed"   "$SPEED"
printf "${BLUE}%-15s${RESET} : %s\n" "CPU Cores"   "$CORES"
printf "${BLUE}%-15s${RESET} : %s\n" "CPU Usage"   "$CPU_USAGE"
printf "${BLUE}%-15s${RESET} : %s / %s\n" "RAM"         "$RAM_USED" "$RAM_TOTAL"
printf "${BLUE}%-15s${RESET} : %s / %s\n" "Disk"        "$DISK_USED" "$DISK_TOTAL"
printf "${BLUE}%-15s${RESET} : %s\n" "IP Local"    "$IPLOCAL"
printf "${BLUE}%-15s${RESET} : %s\n" "IP Public"   "$IPPUBLIC"

echo -e "${YELLOW}--------------------------------------------------${RESET}"
echo -e "${WHITE}© Hansen Dusenov $(date +%Y)${RESET}"
echo