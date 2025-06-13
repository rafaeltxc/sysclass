# Change java version
jv () {
  if [ $# -eq 0 ]; then
    echo "$(java -version)"
    return
  fi

  arg="$1"

  if [ "$arg" = "list" ]; then
    archlinux-java status
    return
  fi

  sudo archlinux-java set "java-$arg-openjdk"
}
