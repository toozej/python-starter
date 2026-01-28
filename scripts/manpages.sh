#!/usr/bin/env bash

set -euo pipefail

rm -rf manpages
mkdir manpages

click-man --target manpages/ cli
