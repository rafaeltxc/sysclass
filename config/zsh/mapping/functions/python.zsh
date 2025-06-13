# Activate Venv
venv () {
  source ./"$1"/bin/activate;
}

# Open IP connection to local network
open-conn() {
  local port="${1:-8080}"

  local ip
  ip=$(ip route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')

  if [ -z "$ip" ]; then
    ip="localhost"
    echo "[open-conn] Could not auto-detect LAN IP. Falling back to localhost."
  fi

  echo "[open-conn] Serving current directory on:"
  echo "  http://$ip:$port/"
  echo "[open-conn] Press Ctrl+C to stop the server."

  python3 -m http.server "$port"
}
