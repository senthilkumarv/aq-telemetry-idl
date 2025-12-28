#\!/usr/bin/env bash
set -eo pipefail
brew update || true
brew install thrift || brew upgrade thrift || true
thrift -version
