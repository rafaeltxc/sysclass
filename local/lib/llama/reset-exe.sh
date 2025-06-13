#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as sudo"
  exit 1
fi

USR_BIN_PATH="/usr/local/bin"
LLAMA_LIB_PATH="/usr/local/lib/llama"

START_SCRIPT="start.sh"
START_LOG_SCRIPT="start-log.sh"

START_BIN="$USR_BIN_PATH/llama"
START_LOG_BIN="$USR_BIN_PATH/llama-log"

START_SCRIPT_EXE="$LLAMA_LIB_PATH/$START_SCRIPT"
START_LOG_SCRIPT_EXE="$LLAMA_LIB_PATH/$START_LOG_SCRIPT"

rm -f "$START_BIN" "$START_LOG_BIN"

ln -s "$START_SCRIPT_EXE" "$START_BIN"
ln -s "$START_LOG_SCRIPT_EXE" "$START_LOG_BIN"
