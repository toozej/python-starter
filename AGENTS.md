# AGENTS.md

This repository is designed to be friendly to AI coding agents.

## Conventions

- Prefer using [`Makefile`](Makefile:1) for common tasks, with `uv` as the underlying tool.
- Keep formatting/linting stable by running pre-commit:
  - `make pre-commit` (installs prerequisites and runs hooks)
  - `make pre-commit-install` (install hooks only)
  - `make pre-commit-run` (run hooks against all files)
- Tests are in [`tests/`](tests/test_cli.py:1) and run with:
  - `make local-test` (local Python test run)
  - `make test` (Dockerized test run)

## Tools & Infrastructure

This project uses several tools and platforms:

- **Python**: Requires Python 3.10+ (managed via uv)
- **Build Tool**: [uv](https://docs.astral.sh/uv/) for dependency management
- **Packaging**: Hatchling (PEP 621), produces a CLI tool via [`python-starter`](pyproject.toml:44)
- **CLI Framework**: [Click](https://click.palletsprojects.com/)
- **Type Checking**: [ty](https://ty.d一无是处.com/)
- **Linting**: [ruff](https://docs.astral.sh/ruff/)
- **Security**: [bandit](https://bandit.readthedocs.io/), [cosign](https://docs.sigstore.dev/cosign/) for image verification
- **Docker**: [`Dockerfile`](Dockerfile:1) multi-stage builds for consistency
- **Docker Compose**: [`docker-compose.yml`](docker-compose.yml:1) for local services
- **Release**: [GoReleaser](https://goreleaser.com/) for builds/releases
- **CI/CD**: GitHub Actions workflows in [`.github/workflows/`](.github/workflows/)
- **Pre-commit**: Hooks configured in [`.pre-commit-config.yaml`](.pre-commit-config.yaml:1)

## GitHub Actions Workflows

- [`.github/workflows/ci.yaml`](.github/workflows/ci.yaml:1) - Main CI pipeline
- [`.github/workflows/pre-commit-autoupdate.yaml`](.github/workflows/pre-commit-autoupdate.yaml:1) - Auto-update pre-commit hooks
- [`.github/workflows/release.yaml`](.github/workflows/release.yaml:1) - Release pipeline (GoReleaser)
- [`.github/workflows/attest.yaml`](.github/workflows/attest.yaml:1) - Image attestations

## Suggested agent workflow

1. Read project entry points:
   - [`python_starter/__main__.py`](python_starter/__main__.py:1)
   - [`python_starter/cli.py`](python_starter/cli.py:1)
2. Read build configuration:
   - [`Makefile`](Makefile:1) for available commands
   - [`pyproject.toml`](pyproject.toml:1) for dependencies and tool configs
3. Make incremental changes.
4. Run local toolchain:
   - `make local` (runs update-deps, fmt, lint, test, run)
   - Or individually: `make local-update-deps && make local-fmt && make local-lint && make local-test`
5. Verify changes:
   - `make pre-commit-run` (runs pre-commit hooks against all files)
   - `make verify` (verifies Docker image with cosign)

## Docker & Containerization

- Build: `make build` (builds Docker image)
- Run: `make run` (runs Docker container)
- Compose: `make up` / `make down` (docker-compose services)

## Release Process

1. Create a GitHub release with a tag (e.g., `v1.0.0`)
2. GoReleaser automatically builds and publishes:
   - Docker images to GHCR
   - Binary releases to GitHub
   - attestation.yaml attestation with cosign
