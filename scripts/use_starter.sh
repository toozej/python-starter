#!/usr/bin/env bash
set -Eeuo pipefail

OLD_PROJECT_NAME="python-starter"
NEW_PROJECT_NAME="${1}"
GITHUB_USERNAME="${2:-toozej}"

if [[ -z "${NEW_PROJECT_NAME}" ]]; then
  echo "Usage: ./scripts/use_starter.sh <new-project-name> [github-username]" >&2
  exit 2
fi

GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${GIT_REPO_ROOT}"

# truncate existing CREDITS.md file and replace its contents with link to template repo's CREDITS.md file
echo -e "# Credits and Acknowledgements\n\n- https://raw.githubusercontent.com/toozej/python-starter/main/CREDITS.md" > CREDITS.md

# remove python-starter.pub key
rm -f ./python-starter.pub

# randomize scheduled CI minute to avoid everyone running at the same time
RAND_MIN=$((RANDOM % 60))
sed -i "" -E "s/cron: \"[0-9]+ 1 \* \* 1\"/cron: \"${RAND_MIN} 1 * * 1\"/g" \
  "${GIT_REPO_ROOT}/.github/workflows/ci.yaml" || true

# rename from $OLD_PROJECT_NAME to $NEW_PROJECT_NAME
grep -rl --exclude-dir=.git/ --exclude ./CREDITS.md "${OLD_PROJECT_NAME}" . | xargs sed -i "" -e "s/${OLD_PROJECT_NAME}/${NEW_PROJECT_NAME}/g"
grep -rl --exclude-dir=.git/ --exclude ./CREDITS.md "${OLD_PROJECT_NAME//-/_}" . | xargs sed -i "" -e "s/${OLD_PROJECT_NAME//-/_}/${NEW_PROJECT_NAME//-/_}/g"

# show diff output so user can verify their changes
git diff
