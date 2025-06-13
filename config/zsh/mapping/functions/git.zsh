# Find and set branch name var if in git repository
function git_branch_name() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]]; then
      :
    else
      echo '- '$branch''
    fi
}

# Commit to github
commit() {
  if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: commit 'message' 'description'"
    return
  fi

  git add .;
  if [ -n "$1" ] && [ -n "$2" ]; then
    git commit -m "$1" -m "$2";
    git push;
  elif [ -n "$1" ]; then
    git commit -m "$1";
    git push;
  else
    git reset .;
    echo "Missing commit message.";
  fi
}
