# python-starter

![Python](https://img.shields.io/badge/python-3.10%E2%80%933.14-blue)
![CI](https://img.shields.io/github/actions/workflow/status/toozej/python-starter/ci.yaml)
![Docker Pulls](https://img.shields.io/docker/pulls/toozej/python-starter)
![Downloads](https://img.shields.io/github/downloads/toozej/python-starter/total)

## ✨ What this starter gives you

- 🧰 Modern packaging via `pyproject.toml` + `uv`
- ✅ Pre-commit checks (Ruff, Vulture, Bandit, PyUpgrade, `ty`, actionlint, etc.)
- 🧪 Unit tests with pytest (and a Docker test target)
- 🐳 Dockerfile + docker-compose examples
- 🔁 CI matrix for Python 3.10–3.14
- 🔄 Dependabot updates for Python, Docker, devcontainers, and GitHub Actions

## 🚀 Quick start

```bash
make pre-reqs-install
uv sync --all-groups
uv run -m pytest
uv run pre-commit run --all-files
```

## 🧱 Using this repo as a template

Run:

```bash
./scripts/use_starter.sh <new-project-name> [github-username]
```

This renames the project identifiers and randomizes the scheduled CI minute.

## 🧪 Common Make targets

- `make test` (Docker test stage)
- `make local` (uv-based local workflow)
- `make pre-commit`
- `make local-install` (install CLI locally via uv)

## 🤖 AI agents

See [`AGENTS.md`](AGENTS.md:1).

## 💻 CLI Usage

This project includes a Click-based CLI. You can run it with:

```bash
# Using uv run (no install required)
uv run python -m python_starter --help
```

### Install CLI Locally

To install the CLI globally and run it as a standalone command:

```bash
make local-install
```

Once installed, you can run the CLI directly:

```bash
python_starter --help
```

### Available Global Options

| Option | Short | Description |
|--------|-------|-------------|
| `--dry-run` | `-d` | Run in dry-run mode (no changes will be made) |
| `--force` | `-f` | Force execution (skip confirmation prompts) |
| `--debug` | `-D` | Enable debug mode |
| `--verbose` | `-v` | Enable verbose output (use multiple times for more verbosity) |
| `--quiet` | `-q` | Suppress output (quiet mode) |

### Example Commands

```bash
# Run command with dry-run and verbose output
uv run python -m python_starter -d -v command example

# Force execution with debug mode
uv run python -m python_starter -f -D command example
```
