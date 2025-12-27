#\!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
OUT=generated/swift
rm -rf "$OUT"
mkdir -p "$OUT/Sources/TelemetryThrift"
command -v thrift >/dev/null 2>&1 || { echo "error: thrift compiler not found" >&2; exit 127; }
thrift --gen swift -out "$OUT/Sources/TelemetryThrift" idl/telemetry.thrift
cat > "$OUT/Package.swift" << SWIFT
// swift-tools-version:5.7
import PackageDescription
let package = Package(
  name: "TelemetryThrift",
  platforms: [.iOS(.v15)],
  products: [ .library(name: "TelemetryThrift", targets: ["TelemetryThrift"]) ],
  dependencies: [ .package(url: "https://github.com/apache/thrift.git", from: "0.20.0") ],
  targets: [ .target(name: "TelemetryThrift", dependencies: [ .product(name: "Thrift", package: "thrift") ], path: "Sources/TelemetryThrift") ]
)
SWIFT
