#!/bin/bash

# Define the path for the config directory and files
CONFIG_DIR="/SPX/ASSETS/CONFIG"
DEFAULT_CONFIG_FILE="${CONFIG_DIR}/default-config.json"
TARGET_CONFIG_FILE="${CONFIG_DIR}/config.json"

# Ensure the CONFIG directory exists
mkdir -p "$CONFIG_DIR"

# Check if the target config file does not exist and copy the default config file if necessary
if [ ! -f "$TARGET_CONFIG_FILE" ]; then
  echo "No existing config.json found. Copying the default configuration..."
  cp "$DEFAULT_CONFIG_FILE" "$TARGET_CONFIG_FILE"
else
  echo "Existing config.json found. Using the existing configuration."
fi

# Start the main application
./SPX_linux64 "ASSETS/CONFIG/config.json"
