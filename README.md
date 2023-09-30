# python-starter

## features of this starter template
- follows common Python best practices in terms of repo/project layout, and includes explanations of what goes where in README files
- Makefile for easy building, deploying, testing, updating, etc. both Dockerized and using locally installed Python toolchain
- docker-compose project for easily hosting built Dockerized Python project, with optional support for Python web services
- scripts to make using the starter template easy, and to update the Python version when a new one comes out
- built-in security scans, vulnerability warnings and auto-updates via Dependabot and GitHub Actions
- pre-commit hooks for ensuring formatting, linting, security checks, etc.

## changes required to use this as a starter template
- generate a GitHub fine-grained access token (used in repo as "GITHUB_TOKEN" and in GitHub Actions Secrets as "GH_TOKEN") with the following read/write permissions
    - actions
    - code scanning alerts
    - commit statuses
    - contents
    - dependabot alerts
    - dependabot secrets
    - deployments
    - environments
    - issues
    - pages
    - pull requests
    - secret scanning alerts
    - secrets
    - webhooks
    - workflows
- generate cosign keypair
    - `cosign generate-key-pair`
    - `mv cosign.key $REPO_NAME.key`
    - `mv cosign.pub $REPO_NAME.pub`
- ensure new repo has the following GitHub Actions Secrets and local shell environment variables stored in `./.env`
    - (`cp .env.sample .env` is a good place to start for local shell environment variables)
    - GH_TOKEN
    - GH_GHCR_TOKEN
    - DOCKERHUB_USERNAME
    - DOCKERHUB_TOKEN
    - QUAY_USERNAME
    - QUAY_TOKEN
    - SNYK_TOKEN
    - COSIGN_PRIVATE_KEY
    - COSIGN_PASSWORD
- set up new repository in quay.io web console
    - (DockerHub and GitHub Container Registry do this automatically on first push/publish)
    - name must match Git repo name
    - grant robot user with username stored in QUAY_USERNAME "write" permissions (your quay.io account should already have admin permissions)
- find/replace python-starter to new repo name
    - run `./scripts/use_starter.sh $NEW_PROJECT_NAME_GOES_HERE`
    - to rename with a different GitHub username `./scripts/use_starter.sh $NEW_PROJECT_NAME_GOES_HERE $GITHUB_USERNAME_GOES_HERE`
- set built packages visibility in GitHub packages to public
    - navigate to https://github.com/users/$USERNAME/packages/container/$REPO/settings
    - scroll down to "Danger Zone"
    - change visibility to public

## changes required to update python version
- run `./scripts/update_python_version.sh $NEW_VERSION_GOES_HERE`
