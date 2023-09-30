#!/usr/bin/env bash
set -Eeuo pipefail

OLD_PROJECT_NAME="python-starter"
NEW_PROJECT_NAME="${1}"
GITHUB_USERNAME="${2:-toozej}"

GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
cd "${GIT_REPO_ROOT}"

# truncate existing CREDITS.md file and replace its contents with link to template repo's CREDITS.md file
echo -e "# Credits and Acknowledgements\n\n- https://raw.githubusercontent.com/toozej/python-starter/main/CREDITS.md" > CREDITS.md

# remove python-starter.pub key
rm -f ./python-starter.pub

# move directories
mv "cmd/${OLD_PROJECT_NAME}" "cmd/${NEW_PROJECT_NAME}"

# rename from $OLD_PROJECT_NAME to $NEW_PROJECT_NAME
grep -rl --exclude-dir=.git/ ${OLD_PROJECT_NAME} . | xargs sed -i "" -e "s/${OLD_PROJECT_NAME}/${NEW_PROJECT_NAME}/g"
grep -rl --exclude-dir=.git/ ${OLD_PROJECT_NAME//-/_} . | xargs sed -i "" -e "s/${OLD_PROJECT_NAME//-/_}/${NEW_PROJECT_NAME//-/_}/g"

# show diff output so user can verify their changes
git diff
