🚀 Hansen Tools

A collection of lightweight shell-based tools for Linux system
inspection and administration.

Author: Hansen Dusenov

------------------------------------------------------------------------

📦 Available Tools

1️⃣ HansenFetch (sysinfo.sh)

A lightweight system information tool (inspired by neofetch) that
displays essential server details with colored output and custom
branding.

------------------------------------------------------------------------

✨ Features

-   OS Information
-   Kernel Version
-   Uptime
-   Hostname
-   CPU Model
-   CPU Speed (GHz)
-   CPU Cores
-   Realtime CPU Usage
-   RAM Usage (Used / Total)
-   Disk Usage (Used / Total)
-   Local IP Address
-   Public IP Address
-   ANSI Color Output
-   Hansen Watermark

------------------------------------------------------------------------

🛠 Usage

Run directly from GitHub (no installation required)

    curl -sL https://raw.githubusercontent.com/USERNAME/REPO/main/sysinfo.sh | bash

or

    wget -qO- https://raw.githubusercontent.com/USERNAME/REPO/main/sysinfo.sh | bash

------------------------------------------------------------------------

Run locally

    chmod +x sysinfo.sh
    ./sysinfo.sh

------------------------------------------------------------------------

🎯 Purpose

This repository is designed for:

-   Quick server inspection
-   DevOps daily utilities
-   Lightweight monitoring helpers
-   Personal Linux tool collection

------------------------------------------------------------------------

🧠 Philosophy

Lightweight. Transparent. No unnecessary dependencies.

All tools in this repository:

-   Require no additional packages
-   Do not modify system configurations
-   Are read-only by design
-   Are safe for production environments

------------------------------------------------------------------------

📌 Roadmap

Planned future tools:

-   RAM and Disk usage progress bars
-   Cloud provider detection (AWS, GCP, DigitalOcean)
-   Quick log analyzer
-   Docker status helper
-   Kubernetes utility scripts

------------------------------------------------------------------------

🔐 Security Notice

Always review scripts before running remote code:

    curl -sL URL | less

Never blindly execute unknown scripts from the internet.

------------------------------------------------------------------------

📄 License

Free to use for personal and commercial purposes. Attribution is
appreciated but not required.