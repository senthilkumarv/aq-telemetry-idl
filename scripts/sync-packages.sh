#\!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
VERSION=${1:?usage: $0 <version>}
RUST_SRC="$ROOT/generated/rust"; RUST_DST="$ROOT/packages/rust"
SWIFT_SRC="$ROOT/generated/swift"; SWIFT_DST="$ROOT/packages/swift"
rm -rf "$RUST_DST" "$SWIFT_DST"; mkdir -p "$RUST_DST" "$SWIFT_DST"
if [[ -d "$RUST_SRC" ]]; then
  cp -R "$RUST_SRC"/. "$RUST_DST"/
  echo "$VERSION" > "$RUST_DST/VERSION"
fi
if [[ -d "$SWIFT_SRC" ]]; then
  cp -R "$SWIFT_SRC"/. "$SWIFT_DST"/
  echo "$VERSION" > "$SWIFT_DST/VERSION"
fi
