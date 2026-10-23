#!/usr/bin/env bash
#
# deploy-forum-style.sh -- server-side deploy of the FreeCAD forum styles.
#
# Fetches the pinned branch and hard-resets the checkout to it. The forum's
# phpBB root links into this checkout, so the reset is the deployment; the
# root-owned wrapper that runs this script purges phpBB's cache afterwards.
# Runs on the forum server as a dedicated unprivileged account.
#
# The deployed branch is hard-coded on purpose -- it is never taken from a
# caller argument. Never add "git clean": it would also remove ignored files.
#
# This process deliberately overwrites any local changes to these files:
# nothing in the Forum-Style repo should ever be directly modified on disk.
# Make changes via a PR to the repo, and deploy them by running the appropriate
# workflow (which calls this script via a restricted ssh login).

set -euo pipefail

REMOTE="origin"
BRANCH="main"
REMOTE_REF="${REMOTE}/${BRANCH}"

REPO_DIR="${DEPLOY_REPO_DIR:-/var/www/forum-style}"

log() {
    printf '%s deploy-forum-style: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*"
}

if [ "$(id -u)" -eq 0 ]; then
    log "refusing to run as root; use the dedicated deploy account"
    exit 1
fi

if [ ! -d "${REPO_DIR}/.git" ]; then
    log "no git repository at ${REPO_DIR}"
    exit 1
fi

# The lock lives inside the checkout, which only the deploy account can
# write, rather than in /tmp, which every local account can.
exec 9>"${REPO_DIR}/.git/deploy.lock"
if ! flock -n 9; then
    log "another deployment is already in progress; aborting"
    exit 1
fi

cd "$REPO_DIR"

PREVIOUS_COMMIT="$(git rev-parse HEAD)"

log "fetching ${REMOTE_REF}"
git fetch --prune "$REMOTE" "$BRANCH"
git reset --hard "$REMOTE_REF"

DEPLOYED_COMMIT="$(git rev-parse HEAD)"
if [ "$DEPLOYED_COMMIT" = "$PREVIOUS_COMMIT" ]; then
    log "already at ${BRANCH} ${DEPLOYED_COMMIT}; nothing changed"
else
    log "deployed ${BRANCH} at ${DEPLOYED_COMMIT} (was ${PREVIOUS_COMMIT})"
fi
logger -t forum-style-deploy "Deployed $(git rev-parse --short HEAD)"
