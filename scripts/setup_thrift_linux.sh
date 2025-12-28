#\!/usr/bin/env bash
set -euo pipefail

if command -v sudo >/dev/null 2>&1; then SUDO="sudo"; else SUDO=""; fi
if command -v apt-get >/dev/null 2>&1; then
  $SUDO apt-get update || true
  DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y thrift-compiler || true
fi

thrift -version
