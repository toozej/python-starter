#!/usr/bin/env bash

 set -euo pipefail

rm -rf completions
mkdir completions

_PYTHON_STARTER_COMPLETE=bash_source uvx python-starter > completions/python-starter.bash
_PYTHON_STARTER_COMPLETE=zsh_source uvx python-starter > completions/python-starter.zsh
_PYTHON_STARTER_COMPLETE=fish_source uvx python-starter > completions/python-starter.fish
