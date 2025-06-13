source_files() {
  local dirs=(
    "$HOME/.config/zsh/mapping/functions"
    "$HOME/.config/zsh/core"
    "$HOME/.config/zsh/custom"
    "$HOME/.config/zsh/mapping"
    "$HOME/.config/zsh"
  )

  for dir in $dirs; do
    for file in $dir/*.zsh; do
      if [[ -f $file ]]; then
        source $file
      fi
    done
  done
}

source_files
