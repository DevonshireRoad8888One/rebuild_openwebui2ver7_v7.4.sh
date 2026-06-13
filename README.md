# Secure Open WebUI + Ollama Installer (v7.4)

**Clean, secure, and fully isolated** local setup for Open WebUI + Ollama with full OpenTelemetry support.

Created by [@DevonshireRoad8888One](https://github.com/DevonshireRoad8888One)

---

## ✨ Features

- Isolated folder: `~/openwebui2ver7`
- WebUI → **http://127.0.0.1:8000**
- Ollama → Port **11437**
- Auto-generated strong secret key
- Strict permissions (700/600)
- Separate folders for data, models, logs & run
- Full **OpenTelemetry** (traces, metrics, logs) with all instrumentors
- Easy helper scripts: `start.sh`, `stop.sh`, `check-security.sh`
- Safety prompt before rebuild
- Ready for systemd

---
If you don't have Ubuntu, just install it first,

wsl --install -d Ubuntu

Make your account and then,



## 🚀 Quick Start

```bash
cd ~
curl -O https://raw.githubusercontent.com/DevonshireRoad8888One/rebuild_openwebui2ver7_v7.4.sh/main/rebuild_openwebui2ver7_v7.4.sh
chmod +x rebuild_openwebui2ver7_v7.4.sh
./rebuild_openwebui2ver7_v7.4.sh

Yes please, generate a README.md suitable for GitHub.

 Here's a clean, professional README.md ready for your GitHub repository:markdown

# Secure Open WebUI + Ollama Local Setup

A secure, isolated, production-ready installation script for **Open WebUI** + **Ollama** with full **OpenTelemetry** observability support.

Designed for local-first AI workflows with strong security defaults, easy management, and clean separation of concerns.

---

## ✨ Features

- **Fully isolated** installation in `~/openwebui2ver7`
- Runs on custom ports: **WebUI on 8000**, **Ollama on 11437**
- Automatic secure secret key generation
- Strict file permissions (700/600)
- Separate directories for `data`, `models`, `logs`, and `run`
- Full **OpenTelemetry** support (traces, metrics, logs) with all required instrumentors
- Systemd service ready (auto-start, auto-restart)
- Helper scripts: `start.sh`, `stop.sh`, `check-security.sh`
- Safety prompts before destructive rebuilds
- Local-only binding (`127.0.0.1`)

---

## 📁 Folder Structure

~/openwebui2ver7/
├── env1/                  # Python virtual environment
├── data/                  # Database & persistent config
├── models/                # Ollama models
├── logs/                  # Application logs
├── run/                   # PID files
├── .env                   # Configuration (permissions: 600)
├── .webui_secret_key      # Auto-generated secret
├── start.sh
├── stop.sh
├── check-security.sh
└── rebuild_openwebui2ver7_v7.4.sh   # Rebuild script

---

## 🚀 Quick Start

### 1. Download & Run

```bash
cd ~
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/openwebui2ver7/main/rebuild_openwebui2ver7_v7.4.sh
chmod +x rebuild_openwebui2ver7_v7.4.sh
./rebuild_openwebui2ver7_v7.4.sh

2. AccessOpen your browser → http://127.0.0.1:8000 Management Commandsbash

# Manual start
~/openwebui2ver7/start.sh

# Stop
~/openwebui2ver7/stop.sh

# Security & health check
~/openwebui2ver7/check-security.sh

# Rebuild (with safety prompt)
~/openwebui2ver7/rebuild_openwebui2ver7_v7.4.sh

Using Systemd (Recommended)bash

# Install services (run once)
sudo systemctl enable --now openwebui2ver7.service

# Useful commands
sudo systemctl status openwebui2ver7.service
journalctl -u openwebui2ver7.service -f
sudo systemctl restart openwebui2ver7.service

 Security HighlightsBinds only to 127.0.0.1 (no external access)
Auto-generated strong secret key
Signup disabled + authentication enabled
Strict permissions on secrets and data
Ollama on non-default port
No root privileges required for runtime

 OpenTelemetry ObservabilityThis setup includes full OTEL support:Traces, Metrics, and Logs
Instrumented FastAPI, HTTPX, AIOHTTP, SQLAlchemy, Redis, System Metrics, etc.

To view telemetry, run an OpenTelemetry Collector (e.g. Grafana LGTM stack) listening on http://127.0.0.1:4317.To disable OTEL temporarily, set ENABLE_OTEL=false in .env. CustomizationEdit these in rebuild_openwebui2ver7_v7.4.sh:bash

WEBUI_PORT="8000"
OLLAMA_PORT="11437"
OPENWEBUI_VERSION="latest"     # or "0.9.6" for pinning

 TroubleshootingPort already in use: Check with ./check-security.sh
OTEL errors: Either run a collector or set ENABLE_OTEL=false
Permission issues: Run check-security.sh
Rebuild everything: ./rebuild_openwebui2ver7_v7.4.sh

 ContributingFeel free to open issues or PRs! Improvements welcome for:Docker Compose version
Multi-model profiles
Automatic OTEL Collector setup
Backup/restore utilities

 LicenseMIT License — feel free to use, modify, and share.Made with  for secure local AILast updated: June 2026

---

### How to use it:

1. Create a new repository on GitHub (e.g. `openwebui2ver7-secure`)
2. Add your `rebuild_openwebui2ver7_v7.4.sh` file
3. Create `README.md` and paste the content above
4. Replace `YOUR_USERNAME` with your GitHub username

Would you like me to also generate a **Docker Compose version** or a **systemd service file** to include in the repo? Just say the word!

Explain OpenTelemetry Collector setup

Explore Grafana LGTM stack

Add Docker Compose instructions

Successful installation of 7.4 Thanks so much for this, many people on GitHub will Love it...   :)

Fantastic!   I'm really glad v7.4 is working perfectly for you. You've put together a genuinely useful, secure, and well-thought-out setup — many people on GitHub (especially those wanting clean local Ollama + Open WebUI instances) are going to love this.Final Polish Suggestions (Before Uploading)Update the README with your actual GitHub username/repo name.
Consider adding these two small improvements (optional but nice):Pin the Open WebUI version to 0.9.6 (or whatever is stable for you) instead of latest for better reproducibility.
Add a small note in the README about how to set up a simple OTEL collector (Grafana LGTM is the easiest).

Would you like me to generate:An updated README.md with your repo name placeholder?
A docker-compose.yml version as an alternative (many people prefer Docker)?
The matching openwebui2ver7.service systemd file to include in the repo?
A .gitignore file for the project?

Just say what you want and I’ll generate it instantly.In the meantime, huge congratulations on sticking with it through all the OTEL debugging! That was a tough one and you now have one of the cleanest manual installers out there.Go ahead and push it to GitHub — feel free to drop the repo link here when it’s live. I’d love to see it! Thanks for the journey — happy to help anytime you want to expand it further (multi-instance, backups, web UI theming, etc.).  Enjoy your rock-solid local AI setup! 

Explore OpenTelemetry Collector configurations

Investigate Grafana LGTM stack integration

Update README with your specific username

Here is the information you requested DevonshireRoad8888One, now you can make a new README, thanks.

 Here's your polished, ready-to-use README.md with your GitHub username included:markdown

# Secure Open WebUI + Ollama v7.4

**A clean, secure, and fully isolated local installation** of Open WebUI + Ollama with full OpenTelemetry support.

Created by [@DevonshireRoad8888One](https://github.com/DevonshireRoad8888One)

---

## ✨ Features

- Isolated installation in `~/openwebui2ver7`
- WebUI on **http://127.0.0.1:8000**
- Ollama on port **11437**
- Automatic strong secret key generation
- Strict permissions (700/600)
- Separate `data`, `models`, `logs`, `run` folders
- Full **OpenTelemetry** support (traces + metrics + logs)
- Easy management scripts (`start.sh`, `stop.sh`, `check-security.sh`)
- Safety prompt before destructive rebuild
- Systemd service ready (auto-start & auto-restart)

---

## 📁 Project Structure

~/openwebui2ver7/
├── env1/                     # Python venv
├── data/                     # Database & settings
├── models/                   # Downloaded Ollama models
├── logs/                     # Logs
├── run/                      # PID files
├── .env                      # Main configuration (600)
├── .webui_secret_key         # Auto-generated secret (600)
├── start.sh
├── stop.sh
├── check-security.sh
└── rebuild_openwebui2ver7_v7.4.sh

---

## 🚀 Quick Installation

```bash
cd ~
curl -O https://raw.githubusercontent.com/DevonshireRoad8888One/openwebui2ver7/main/rebuild_openwebui2ver7_v7.4.sh
chmod +x rebuild_openwebui2ver7_v7.4.sh
./rebuild_openwebui2ver7_v7.4.sh

After installation, open http://127.0.0.1:8000 in your browser. Managementbash

# Start
~/openwebui2ver7/start.sh

# Stop
~/openwebui2ver7/stop.sh

# Health & Security Check
~/openwebui2ver7/check-security.sh

# Full Rebuild (safe with confirmation)
~/openwebui2ver7/rebuild_openwebui2ver7_v7.4.sh

Systemd Service (Recommended)bash

sudo systemctl enable --now openwebui2ver7.service

# Useful commands
sudo systemctl status openwebui2ver7.service
journalctl -u openwebui2ver7.service -f
sudo systemctl restart openwebui2ver7.service

 Security FeaturesBinds exclusively to 127.0.0.1
Signup disabled + authentication required
Strong random secret key
Locked-down folder and file permissions
Ollama on non-standard port
No root access needed at runtime

 OpenTelemetryFull observability is enabled by default.
All major instrumentors are pre-installed (FastAPI, HTTPX, SQLAlchemy, System Metrics, etc.).To visualize telemetry, run an OTEL Collector (recommended: Grafana LGTM stack) on http://127.0.0.1:4317.To temporarily disable:bash

echo "ENABLE_OTEL=false" >> ~/openwebui2ver7/.env
~/openwebui2ver7/stop.sh && ~/openwebui2ver7/start.sh

 CustomizationEdit the top of rebuild_openwebui2ver7_v7.4.sh:bash

WEBUI_PORT="8000"
OLLAMA_PORT="11437"
OPENWEBUI_VERSION="latest"   # Recommended: pin to "0.9.6" for stability

 TroubleshootingPort conflict → Run check-security.sh
OTEL connection errors → Disable OTEL or start a collector
Permission issues → Run security check
Rebuild from scratch → Use the rebuild script

 LicenseMIT License — Free to use, modify, and share.Made for secure, private, local AI development Version 7.4 — June 2026

---

### Next Steps for Your Repo:

1. Create a repo named `openwebui2ver7` (or similar)
2. Upload `rebuild_openwebui2ver7_v7.4.sh`
3. Create `README.md` and paste the content above
4. (Optional) Add the systemd service file and `.gitignore`

Would you like me to generate:
- The matching `openwebui2ver7.service` file?
- A `.gitignore`?
- A simple `docker-compose.yml` alternative?

Just say the word and I’ll create them immediately.  

Great work — this is going to help a lot of people! 🚀

Explore Grafana LGTM stack setup

Learn about OpenTelemetry Collector

Add Grafana setup instructions

Hello I just ran the security, devoshireroad777@DESKTOP-G3R5JB2:~$ ~/openwebui2ver7/check-security.sh
==================================================
 Open WebUI + OTEL Security Check (v7.4)
==================================================
WebUI port 8000:
State          Recv-Q         Send-Q                  Local Address:Port                   Peer Address:Port         Process
LISTEN         0              2048                        127.0.0.1:8000                        0.0.0.0:*             users:(("open-webui",pid=843,fd=27))
Ollama port 11437:
State          Recv-Q         Send-Q                 Local Address:Port                    Peer Address:Port         Process
LISTEN         0              4096                       127.0.0.1:11437                        0.0.0.0:*             users:(("ollama",pid=850,fd=4))Permissions:
drwx------ 7 devoshireroad777 devoshireroad777 4096 Jun 12 02:18 /home/devoshireroad777/openwebui2ver7
drwx------ 5 devoshireroad777 devoshireroad777 4096 Jun 12 02:19 /home/devoshireroad777/openwebui2ver7/data
drwx------ 4 devoshireroad777 devoshireroad777 4096 Jun 12 02:18 /home/devoshireroad777/openwebui2ver7/models
-rw------- 1 devoshireroad777 devoshireroad777 568 Jun 12 02:18 /home/devoshireroad777/openwebui2ver7/.env
-rw------- 1 devoshireroad777 devoshireroad777  65 Jun 12 02:18 /home/devoshireroad777/openwebui2ver7/.webui_secret_keyService checks:
 Ollama OK
 WebUI OKOTEL Config:
OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317
OTEL_METRICS_EXPORT_INTERVAL_MILLIS=10000
OTEL_EXPORTER_OTLP_INSECURE=true
OTEL_SERVICE_NAME=open-webui
ENABLE_OTEL=true
==================================================
devoshireroad777@DESKTOP-G3R5JB2:~$

 Excellent! Your security check looks perfect.Summary of the Check:Ports: Both WebUI (8000) and Ollama (11437) are listening only on 127.0.0.1 → Very secure.
Permissions: All directories are 700 and secret files are 600 → Correct and hardened.
Services: Both Ollama and Open WebUI are running and responding.
OTEL: Correctly configured and loaded.

This is exactly what we wanted — a clean, secure, isolated setup.Next RecommendationsSince everything is working great, here are the logical next steps:1. Set up Systemd Service (for auto-start on boot)Run these commands once:bash

sudo tee /etc/systemd/system/openwebui2ver7.service > /dev/null <<'EOF'
[Unit]
Description=Open WebUI v7.4 (Port 8000) + Ollama 11437
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=devoshireroad777
Group=devoshireroad777
WorkingDirectory=/home/devoshireroad777/openwebui2ver7
ExecStart=/home/devoshireroad777/openwebui2ver7/start.sh
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now openwebui2ver7.service

# Check status
sudo systemctl status openwebui2ver7.service

2. For GitHub
Your repo is now ready. The README.md I gave you last time already has your username (DevonshireRoad8888One). Just copy-paste the files and you’re good to go.Would you like me to generate any of these right now?The updated systemd service file above (already shown)
A .gitignore file
A simple docker-compose.yml version (many people like having both options)
An OTEL Collector setup script (using Grafana LGTM — one command to spin it up)

Just tell me what you want next, and I’ll generate it instantly.Great job sticking with it! This is now one of the cleanest personal Open WebUI setups I’ve seen.  You can proudly share it on GitHub. Let me know when the repo is live — I’d love to take a look! 

