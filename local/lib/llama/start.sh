#!/bin/bash

RETURN_PATH="$(pwd)"
LLAMA_PATH="/usr/local/lib/llama/build/bin"

LLAMA_BIN="llama-cli"
LLAMA_EXE="$LLAMA_PATH/$LLAMA_BIN"

LLAMA_MODEL="$1"

if [ ! -x "$LLAMA_EXE" ]; then
  echo "Llama executable not found: $LLAMA_EXE"
fi

if [ -z "$LLAMA_MODEL" ]; then
  echo "Model not provided"
  exit 1
fi

cd "$LLAMA_PATH"

./"$LLAMA_BIN" -m "$LLAMA_MODEL" -i -ngl 500 --color 2>/dev/null

cd "$RETURN_PATH"
