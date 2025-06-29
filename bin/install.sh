#!/bin/bash
echo "🧪 Checking Python..."
if ! command -v python3 &>/dev/null; then
  echo "❌ Python 3 is not installed."
  exit 1
fi

python3 -m prefiq_installer.installer
