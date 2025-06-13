# Use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"

    if [ -f "$tmp" ]; then
      dir="$(cat "$tmp")"
      rm -f "$tmp"
      [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Tail number of lines from a log file
tll () {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    lines=${1}
    file=${2}
  else
    lines=500
    file=${1}
  fi

  sudo tail -"${lines}"f "${file}"
}

# fzf
fuzzy () {
  VAR=$(find $("pwd") | fzf)

  if [[ -d $VAR ]]; then
    cd "$VAR"
  elif [[ -f $VAR ]]; then
    (nvim "$VAR")
  fi
}

# Open NeoVim
nv () {
  if [ -n "$1" ]; then
    nvim "$1"
    return
  fi

  nvim
}

# Open NeoVim read mode
nvr () {
  if [ -n "$1" ]; then
    nvim -R "$1"
    return
  fi

  nvim -R
}

# Video record
rec () {
    echo "File name: "
    read choice
    wf-recorder -g "$(slurp)" -f ~/Pictures/"$choice".mp4
}

# Parse text to json
json() {
  local input="$1"
  local json="{"

  IFS=',' read -rA pairs <<< "$input"

  for pair in "${pairs[@]}"; do
    IFS=':' read -r key value <<< "$pair"

    if [[ "${value:0:1}" == "{" && "${value: -1}" == "}" ]]; then
        value=$(json "${value:1:-1}")
    else
        value="\"$value\""
    fi

    json+="\"$key\":$value,"
  done

  json="${json%,}}"
  echo "$json"
}
