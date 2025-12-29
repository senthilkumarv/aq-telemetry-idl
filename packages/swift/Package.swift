// swift-tools-version:5.7
import PackageDescription
let package = Package(
  name: "TelemetryThrift",
  platforms: [.iOS(.v15)],
  products: [ .library(name: "TelemetryThrift", targets: ["TelemetryThrift"]) ],
  dependencies: [ .package(url: "https://github.com/apache/thrift.git", from: "0.20.0") ],
  targets: [ .target(name: "TelemetryThrift", dependencies: [ .product(name: "Thrift", package: "thrift") ], path: "Sources/TelemetryThrift") ]
)
