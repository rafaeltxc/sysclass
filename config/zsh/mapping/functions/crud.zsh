# Get with curl
get() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: get PORT URL"
    echo "Example: get 8080 api/resource"
    return
  fi

  if [ "$#" -ne 2 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Usage: get PORT URL"
    return 1
  fi

  curl "http://localhost:$1/$2"
}

# Post with curl
post() {
  if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "usage: post 'key:value,key:value' port url"
    echo "example: post 'key1:value1,key2:value2' 8080 api/resource"
    exit 0
  fi

  if [ "$#" -ne 3 ]; then
    echo "error: incorrect number of arguments."
    echo "usage: post 'key:value,key:value' port url"
    exit 1
  fi

  local json=$(json "$1")

  curl --header "content-type: application/json" \
      --request post \
      --data "'$json'" \
      http://localhost:$2/$3
}

# Update with curl
update() {
  if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: update 'key:value,key:value' PORT URL"
    echo "Example: update 'key1:value1,key2:value2' 8080 api/resource"
    return
  fi

  if [ "$#" -ne 3 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Usage: update 'key:value,key:value' PORT URL"
    return 1
  fi

  local json=$(json "$1")

  curl --header "Content-Type: application/json" \
      --request PUT \
      --data "'$json'" \
      "http://localhost:$2/$3"
}

# Delete with curl
delete() {
  if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: delete PORT URL"
    echo "Example: delete 8080 api/resource"
    return
  fi

  if [ "$#" -ne 2 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Usage: delete PORT URL"
    return 1
  fi

  curl --request DELETE \
      "http://localhost:$1/$2"
}
