#\!/usr/bin/env bash
set -eo pipefail
BUMP=${1:-auto}
git fetch --tags --quiet || true
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo v0.0.0)
BASE=${LATEST_TAG#v}
MAJOR=${BASE%%.*}
REST=${BASE#*.}
if [[ "$BASE" == "$MAJOR" ]]; then MINOR=0; PATCH=0; else MINOR=${REST%%.*}; PATCH=${REST#*.}; fi
inc_patch() { PATCH=$((PATCH+1)); }
inc_minor() { MINOR=$((MINOR+1)); PATCH=0; }
inc_major() { MAJOR=$((MAJOR+1)); MINOR=0; PATCH=0; }
if [[ $BUMP == auto ]]; then
  RANGE="$LATEST_TAG..HEAD"; [[ $LATEST_TAG == v0.0.0 ]] && RANGE=""
  LOG=$(git log --pretty=%B $RANGE || true)
  if echo "$LOG" | grep -Eiq "BREAKING CHANGE|\\bfeat\!\\b|\\bfix\!\\b"; then
    BUMP=major
  elif echo "$LOG" | grep -Eiq "^feat:|^feat\\b"; then
    BUMP=minor
  else
    BUMP=patch
  fi
fi
case "$BUMP" in
  major) inc_major;;
  minor) inc_minor;;
  patch) inc_patch;;
  *) echo "unknown bump: $BUMP" >&2; exit 2;;
esac
echo "$MAJOR.$MINOR.$PATCH"
