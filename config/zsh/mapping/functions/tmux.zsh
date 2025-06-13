# New Session
tx () {
  local name="${1:-default}"
  tmux new-session -A -s "$name"
}

# Attach Session
ta () {
  if [ -z "$1"  ]; then
    echo "Missing Tmux Session name"
    return
  fi

  tmux -t "$1"
}

# List Sessions
ts () {
  tmux ls
}

# Kill Session
tk () {
  if [ -z "$1"  ]; then
    echo "Missing Tmux Session name"
    return
  fi

  tmux kill-session -t "$1"
}
