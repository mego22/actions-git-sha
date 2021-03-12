#!/bin/sh

set -x


GIT_USERNAME="${INPUT_USERNAME}"
GIT_TOKEN="${INPUT_PASSWORD}"
GIT_REPO="${INPUT_REPO}"
GIT_BRANCH="${INPUT_BRANCH:-HEAD}"

# Setup to be able to pull roles with ansible-galaxy
echo "https://$GIT_USERNAME:$GIT_TOKEN@github.com" > "${HOME}/.git-credentials"
chmod 0600 "${HOME}/.git-credentials"
git config --global credential.helper store


SHA=$(git ls-remote "${GIT_REPO}" "${GIT_BRANCH}" | awk '{print $1}')

echo "::set-output name=sha::$SHA"
