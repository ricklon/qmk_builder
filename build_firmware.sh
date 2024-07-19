#!/bin/bash

# Check if KEYBOARD and KEYMAP are passed as arguments
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <keyboard> <keymap>"
  exit 1
fi

# Set the environment variables
export KEYBOARD=$1
export KEYMAP=$2

# Run docker-compose
docker-compose up --build
