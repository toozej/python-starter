#!/usr/bin/env bash

set -euo pipefail

rm -rf manpages
mkdir manpages

make local-install
uv run click-man --man-version 0.5.0 --target manpages/ python-starter
