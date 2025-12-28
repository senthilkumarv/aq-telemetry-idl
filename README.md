# Aquarium Telemetry IDL (Thrift)

Shared Thrift IDL and generated packages for Rust and Swift.

- idl/telemetry.thrift
- scripts/
- packages/ (tracked outputs)

Local codegen: run scripts/gen-all.sh

CI on main will auto-bump semver, commit packages/, and tag vX.Y.Z (override via RELEASE_BUMP).
