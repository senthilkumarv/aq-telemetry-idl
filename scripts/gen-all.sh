#\!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/gen-rust.sh"
"$SCRIPT_DIR/gen-swift.sh"
echo "Generated Rust crate under generated/rust and Swift package under generated/swift"
