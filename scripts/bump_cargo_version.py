#\!/usr/bin/env python3
import io, os, re, sys

if len(sys.argv) < 2:
    print("usage: bump_cargo_version.py <version>", file=sys.stderr)
    sys.exit(1)
ver = sys.argv[1].strip()
path = os.path.join(packages,rust,Cargo.toml)
try:
    text = io.open(path, r, encoding=utf-8).read()
except FileNotFoundError:
    # Nothing to bump; not an error in CI
    sys.exit(0)

lines = text.splitlines()
out = []
in_pkg = False
re_pkg_start = re.compile(r"^\s*\[package\]\s*$")
re_section = re.compile(r"^\s*\[.*\]\s*$")
re_version = re.compile(r"^\s*version\s*=\s*\".*\"\s*$")

for line in lines:
    if re_pkg_start.match(line):
        in_pkg = True
        out.append(line)
        continue
    if in_pkg and re_section.match(line):
        in_pkg = False
    if in_pkg and re_version.match(line):
        out.append(f"version = \"{ver}\"")
    else:
        out.append(line)

io.open(path, w, encoding=utf-8).write("\n".join(out) + "\n")
