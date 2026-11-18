#!/usr/bin/env bash
# init-and-push.sh — initialize git, commit files, set remote, push to GitHub.
# Run this AFTER you've done the authoring work in a session-recording harness
# (so transcript bundling can find a real session). See SUBMISSION_GUIDE.md.
#
# Usage:
#   cd make-fun-tutorial
#   bash init-and-push.sh

set -euo pipefail

REPO_URL="https://github.com/jusspound-netizen/make-fun-tutorial.git"
COMMIT_MSG="Initial entry for bring-the-humans-02"

# Pre-flight: ensure README contains a make.fun referral link
if ! grep -Eq 'https://make\.fun/r/[A-Za-z0-9_-]+' README.md 2>/dev/null; then
  echo "ERROR: README.md does not contain a valid https://make.fun/r/<code> referral link."
  echo "Get your link from:  node cli/makefun.mjs referrals  (run inside the bounty kit)"
  echo "Then add/replace it in README.md and re-run this script."
  exit 1
fi

# Warn if the default entrant-specific repo URL/referral is still present
if grep -q 'https://github.com/jusspound-netizen/make-fun-tutorial' README.md SUBMISSION_GUIDE.md 2>/dev/null; then
  echo "NOTE: Default example repo URL (jusspound-netizen/make-fun-tutorial) is still present."
  echo "If this is your own entry, update repo URLs and referral links to your own before submitting."
  echo ""
fi

# Pre-flight: warn if no opencode session exists yet (transcript requirement)
if [ ! -d .opencode ] && [ ! -d .claude ] && [ ! -d .codex ]; then
  echo "WARNING: no opencode/Claude Code/Codex session directory found."
  echo "The bounty requires a real AI coding-agent transcript."
  echo "If you have not run opencode in this directory yet, the bundle step"
  echo "will fail later. See SUBMISSION_GUIDE.md step 3."
  echo ""
  echo "Continuing in 5 seconds... (Ctrl-C to abort)"
  sleep 5
fi

# Init, add, commit
if [ ! -d .git ]; then
  git init -b main
fi
git add README.md LICENSE TRANSCRIPT.md SUBMISSION_GUIDE.md screenshot.png 2>/dev/null || git add .
git commit -m "$COMMIT_MSG" --allow-empty || echo "(commit already exists, continuing)"

# Remote + push
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"
git branch -M main
echo ""
echo "Pushing to $REPO_URL ..."
echo "(you will be prompted for GitHub credentials if not cached)"
git push -u origin main

echo ""
echo "Done. Repo is live at https://github.com/jusspound-netizen/make-fun-tutorial"
echo ""
echo "Next steps (see SUBMISSION_GUIDE.md):"
echo "  1. Take screenshot.png of the GitHub repo page (README rendered)"
echo "  2. git add screenshot.png && git commit --amend --no-edit && git push --force-with-lease"
echo "  3. From inside bring-the-humans-02-kit/:"
echo "     node cli/makefun.mjs bundle"
echo "     node cli/makefun.mjs check  bring-the-humans-02 --repo $REPO_URL --transcript ./bundle.zip"
echo "     node cli/makefun.mjs submit bring-the-humans-02 --repo $REPO_URL --transcript ./bundle.zip"
