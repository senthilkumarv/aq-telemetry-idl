#\!/usr/bin/env python3
import sys, re
from pathlib import Path

def main():
    if len(sys.argv) < 2:
        print('usage: bump_cargo_version.py <version>', file=sys.stderr)
        sys.exit(1)
    ver = sys.argv[1].strip()

    # Repo root = scripts/.. ; target Cargo.toml is packages/rust/Cargo.toml
    root = Path(__file__).resolve().parents[1]
    cargo = root / 'packages' / 'rust' / 'Cargo.toml'

    if not cargo.exists():
        # Nothing to bump; not an error in CI
        return 0

    lines = cargo.read_text(encoding='utf-8').splitlines()

    out = []
    in_pkg = False
    changed = False
    re_pkg_start = re.compile(r'^\s*\[package\]\s*$')
    re_section = re.compile(r'^\s*\[.*\]\s*$')
    re_version = re.compile(r'^(\s*)version\s*=\s*".*"\s*$')

    for line in lines:
        if re_pkg_start.match(line):
            in_pkg = True
            out.append(line)
            continue
        if in_pkg and re_section.match(line):
            in_pkg = False
        if in_pkg:
            m = re_version.match(line)
            if m:
                indent = m.group(1)
                out.append(f'{indent}version = "{ver}"')
                changed = True
                continue
        out.append(line)

    if not changed:
        # If no version line was found in [package], try inserting after [package]
        out2 = []
        inserted = False
        for i, line in enumerate(out):
            out2.append(line)
            if not inserted and re_pkg_start.match(line):
                out2.append(f'version = "{ver}"')
                inserted = True
        out = out2

    cargo.write_text('\n'.join(out) + '\n', encoding='utf-8')
    return 0

if __name__ == '__main__':
    sys.exit(main())
