#!/usr/bin/env bash
set -euo pipefail
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter is required. Install Flutter 3.x first.' >&2
  exit 1
fi
flutter create --platforms=android,ios .
flutter pub get
flutter analyze
