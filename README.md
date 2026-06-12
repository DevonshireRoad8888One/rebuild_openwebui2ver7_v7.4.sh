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

## 🚀 Quick Start

```bash
cd ~
curl -O https://raw.githubusercontent.com/DevonshireRoad8888One/rebuild_openwebui2ver7_v7.4.sh/main/rebuild_openwebui2ver7_v7.4.sh
chmod +x rebuild_openwebui2ver7_v7.4.sh
./rebuild_openwebui2ver7_v7.4.sh
