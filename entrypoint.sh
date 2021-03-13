#!/usr/bin/env sh

set -o pipefail

GIT_REPO="${INPUT_REPO}"
GIT_BRANCH="${INPUT_BRANCH:-HEAD}"
GIT_USERNAME="${INPUT_USERNAME}"
GIT_TOKEN="${INPUT_PASSWORD}"

if [ ! -z "${GIT_USERNAME}" ] || [ ! -z "${GIT_TOKEN}" ]; then

  if [ -z "${GIT_USERNAME}" ]; then echo "::error::Username not set"; exit 1; fi
  if [ -z "${GIT_TOKEN}" ]; then echo "::error::Password/token not set";  exit 2; fi

  echo "https://$GIT_USERNAME:$GIT_TOKEN@github.com" > "${HOME}/.git-credentials"
  chmod 0600 "${HOME}/.git-credentials"

fi

git config --global credential.helper store

SHA=`git ls-remote "${GIT_REPO}" "${GIT_BRANCH}" | awk '{print $1}'`

echo "::set-output name=sha::$SHA"
