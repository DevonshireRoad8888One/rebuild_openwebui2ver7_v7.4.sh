cat > "$HOME/rebuild_openwebui2ver7_v7.4.sh" <<'REBUILD74'
#!/usr/bin/env bash
set -euo pipefail

cd "$HOME"

BASE="$HOME/openwebui2ver7"
WEBUI_PORT="8000"
OLLAMA_PORT="11437"
OPENWEBUI_VERSION="latest"   # Change to e.g. "0.9.6" for stability

echo "=================================================="
echo " Secure Open WebUI + Ollama + Full OTEL v7.4"
echo " Folder:      $BASE"
echo " WebUI:       http://127.0.0.1:$WEBUI_PORT"
echo " Ollama:      http://127.0.0.1:$OLLAMA_PORT"
echo "=================================================="

# Safety prompt
read -rp "This will DELETE $BASE and rebuild. Continue? [y/N] " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

# Optional backup
if [ -d "$BASE" ]; then
  echo "Backing up old folder..."
  mv "$BASE" "$BASE.backup.$(date +%Y%m%d_%H%M%S)"
fi

# System deps (update only, no full upgrade)
sudo apt update -y
sudo apt install -y software-properties-common curl ca-certificates gnupg lsb-release \
  psmisc iproute2 zstd ffmpeg build-essential pkg-config

# Python 3.12
if ! command -v python3.12 >/dev/null 2>&1; then
  sudo add-apt-repository ppa:deadsnakes/ppa -y
  sudo apt update
fi
sudo apt install -y python3.12 python3.12-dev python3.12-venv python3-pip

# Ollama
if ! command -v ollama >/dev/null 2>&1; then
  curl -fsSL https://ollama.com/install.sh | sh
fi

# Fresh setup
rm -rf "$BASE"
mkdir -p "$BASE"/{data,models,logs,run}
chmod 700 "$BASE" "$BASE"/{data,models,logs,run}

# Virtualenv + packages
python3.12 -m venv "$BASE/env1"
cd "$BASE"
source "$BASE/env1/bin/activate"
python -m pip install --upgrade pip setuptools wheel

if [[ "$OPENWEBUI_VERSION" == "latest" ]]; then
  pip install open-webui
else
  pip install "open-webui==$OPENWEBUI_VERSION"
fi

# Full OTEL support
echo "📦 Installing complete OpenTelemetry packages..."
pip install \
  opentelemetry-api \
  opentelemetry-sdk \
  opentelemetry-exporter-otlp \
  opentelemetry-instrumentation \
  opentelemetry-instrumentation-fastapi \
  opentelemetry-instrumentation-httpx \
  opentelemetry-instrumentation-aiohttp-client \
  opentelemetry-instrumentation-logging \
  opentelemetry-instrumentation-requests \
  opentelemetry-instrumentation-redis \
  opentelemetry-instrumentation-sqlalchemy \
  opentelemetry-instrumentation-system-metrics

deactivate

# Secure secret
SECRET="$(python3.12 -c 'import secrets; print(secrets.token_urlsafe(48))')"
echo "$SECRET" > "$BASE/.webui_secret_key"
chmod 600 "$BASE/.webui_secret_key"

# .env
cat > "$BASE/.env" <<ENV
WEBUI_PORT=$WEBUI_PORT
OLLAMA_PORT=$OLLAMA_PORT
WEBUI_SECRET_KEY=$SECRET

WEBUI_AUTH=True
ENABLE_SIGNUP=False
WEBUI_DISABLE_SIGNUP=True
JWT_EXPIRES_IN=30d
ENABLE_PERSISTENT_CONFIG=True

CORS_ALLOW_ORIGIN="http://127.0.0.1:$WEBUI_PORT;http://localhost:$WEBUI_PORT"
OLLAMA_ORIGINS="http://127.0.0.1:$WEBUI_PORT,http://localhost:$WEBUI_PORT"

HOST=127.0.0.1
PORT=$WEBUI_PORT

# OpenTelemetry
ENABLE_OTEL=true
OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317
OTEL_EXPORTER_OTLP_INSECURE=true
OTEL_SERVICE_NAME=open-webui
OTEL_METRICS_EXPORT_INTERVAL_MILLIS=10000
ENV

chmod 600 "$BASE/.env"

# === start.sh ===
cat > "$BASE/start.sh" <<'START74'
#!/usr/bin/env bash
set -euo pipefail

BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$BASE/.env" ]; then
  set -a; . "$BASE/.env"; set +a
fi

WEBUI_PORT="${WEBUI_PORT:-8000}"
OLLAMA_PORT="${OLLAMA_PORT:-11437}"
WEBUI_URL="http://127.0.0.1:$WEBUI_PORT"

echo "=================================================="
echo "🔒 Starting Open WebUI + OTEL (v7.4)"
echo "=================================================="
echo "🌐 WebUI:   $WEBUI_URL"
echo "🧠 Ollama:  http://127.0.0.1:$OLLAMA_PORT"
echo "📊 OTEL:    ${OTEL_EXPORTER_OTLP_ENDPOINT:-disabled}"
echo ""

[ -f "$BASE/.webui_secret_key" ] && WEBUI_SECRET_KEY="$(cat "$BASE/.webui_secret_key")"

export WEBUI_SECRET_KEY
export OLLAMA_HOST="127.0.0.1:$OLLAMA_PORT"
export OLLAMA_MODELS="$BASE/models"
export OLLAMA_BASE_URL="http://127.0.0.1:$OLLAMA_PORT"
export DATA_DIR="$BASE/data"

mkdir -p "$BASE"/{data,models,logs,run}
chmod 700 "$BASE"/{data,models,logs,run} 2>/dev/null || true

# Start Ollama
if ! curl -fsS "http://127.0.0.1:$OLLAMA_PORT/api/version" >/dev/null 2>&1; then
  echo "🔄 Starting Ollama..."
  nohup ollama serve > "$BASE/logs/ollama.log" 2>&1 &
  echo $! > "$BASE/run/ollama.pid"
  sleep 6
fi

echo "🚀 Starting Open WebUI..."
source "$BASE/env1/bin/activate"
cd "$BASE"
exec "$BASE/env1/bin/open-webui" serve --host 127.0.0.1 --port "$WEBUI_PORT"
START74

# === stop.sh ===
cat > "$BASE/stop.sh" <<'STOP74'
#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$BASE/.env" ]; then
  set -a; . "$BASE/.env"; set +a
fi

WEBUI_PORT="${WEBUI_PORT:-8000}"
OLLAMA_PORT="${OLLAMA_PORT:-11437}"

pids_on_port() {
  ss -ltnp "sport = :$1" 2>/dev/null | grep -o 'pid=[0-9]\+' | cut -d= -f2 | sort -u || true
}

kill_pids() {
  NAME="$1"
  PIDS="$2"
  [ -z "$PIDS" ] && return
  echo "🛑 Stopping $NAME..."
  for PID in $PIDS; do
    kill "$PID" 2>/dev/null || true
    for i in {1..5}; do
      if ! kill -0 "$PID" 2>/dev/null; then
        continue 2
      fi
      sleep 1
    done
    kill -9 "$PID" 2>/dev/null || true
  done
}

echo "🛑 Stopping services..."
WEBUI_PIDS="$(pids_on_port "$WEBUI_PORT")"
kill_pids "Open WebUI" "$WEBUI_PIDS"

OLLAMA_PIDS="$(pids_on_port "$OLLAMA_PORT")"
[ -z "$OLLAMA_PIDS" ] && [ -f "$BASE/run/ollama.pid" ] && OLLAMA_PIDS="$(cat "$BASE/run/ollama.pid" 2>/dev/null || true)"
kill_pids "Ollama" "$OLLAMA_PIDS"

rm -f "$BASE/run/ollama.pid"
echo "✅ All services stopped."
STOP74

# === check-security.sh ===
cat > "$BASE/check-security.sh" <<'CHECK74'
#!/usr/bin/env bash
set -euo pipefail
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$BASE/.env" ]; then
  set -a; . "$BASE/.env"; set +a
fi

WEBUI_PORT="${WEBUI_PORT:-8000}"
OLLAMA_PORT="${OLLAMA_PORT:-11437}"

echo "=================================================="
echo " Open WebUI + OTEL Security Check (v7.4)"
echo "=================================================="

echo "WebUI port $WEBUI_PORT:"; ss -ltnp "sport = :$WEBUI_PORT" 2>/dev/null || true
echo "Ollama port $OLLAMA_PORT:"; ss -ltnp "sport = :$OLLAMA_PORT" 2>/dev/null || true

echo -e "\nPermissions:"
ls -ld "$BASE" "$BASE/data" "$BASE/models" 2>/dev/null || true
ls -l "$BASE/.env" "$BASE/.webui_secret_key" 2>/dev/null || true

echo -e "\nService checks:"
curl -fsS "http://127.0.0.1:$OLLAMA_PORT/api/version" >/dev/null 2>&1 && echo "✅ Ollama OK" || echo "⚠️ Ollama not responding"
curl -fsS "http://127.0.0.1:$WEBUI_PORT" >/dev/null 2>&1 && echo "✅ WebUI OK" || echo "⚠️ WebUI not responding"

echo -e "\nOTEL Config:"
env | grep -E 'OTEL|ENABLE_OTEL' || echo "OTEL not configured"
echo "=================================================="
CHECK74

chmod +x "$BASE"/{start.sh,stop.sh,check-security.sh}
chmod 600 "$BASE/.env" "$BASE/.webui_secret_key"
chmod 700 "$BASE" "$BASE"/{data,models,logs,run}

echo "=================================================="
echo "✅ v7.4 installed successfully!"
echo "Access → http://127.0.0.1:$WEBUI_PORT"
echo "Start:   $BASE/start.sh"
echo "Stop:    $BASE/stop.sh"
echo "Check:   $BASE/check-security.sh"
echo "=================================================="

cd "$BASE"
./start.sh
REBUILD74

chmod +x "$HOME/rebuild_openwebui2ver7_v7.4.sh"
echo "✅ v7.4 script ready!"
echo "Run: chmod +x ~/rebuild_openwebui2ver7_v7.4.sh && ~/rebuild_openwebui2ver7_v7.4.sh"
