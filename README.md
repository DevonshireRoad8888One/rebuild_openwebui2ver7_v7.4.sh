# rebuild_openwebui2ver7_v7.4.sh
rebuild_openwebui2ver7_v7.4.sh -  Here's your polished, ready-to-use README.md with your GitHub username included:

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

