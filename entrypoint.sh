#!/bin/sh


GIT_USERNAME="${INPUT_USERNAME}"
GIT_TOKEN="${INPUT_PASSWORD}"
GIT_REPO="${INPUT_REPOSITORY}"
GIT_BRANCH="${INPUT_REF:-HEAD}"

# Setup to be able to pull roles with ansible-galaxy
echo "https://$GIT_USERNAME:$GIT_TOKEN@github.com" > ~/.git-credentials
chmod 0600 ~/.git-credentials 
git config --global credential.helper store


SHA=$(git ls-remote "${GIT_REPO}" "${GIT_BRANCH}" | awk '{print $1}')

echo "::set-output name=sha::$SHA"
