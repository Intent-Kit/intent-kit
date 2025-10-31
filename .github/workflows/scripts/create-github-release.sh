#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create a GitHub release with all template zip files
# Usage: create-github-release.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi

VERSION="$1"

# Remove 'v' prefix from version for release title
VERSION_NO_V=${VERSION#v}

gh release create "$VERSION" \
  .genreleases/intent-templates-copilot-sh-"$VERSION".zip \
  .genreleases/intent-templates-copilot-ps-"$VERSION".zip \
  .genreleases/intent-templates-claude-sh-"$VERSION".zip \
  .genreleases/intent-templates-claude-ps-"$VERSION".zip \
  .genreleases/intent-templates-gemini-sh-"$VERSION".zip \
  .genreleases/intent-templates-gemini-ps-"$VERSION".zip \
  .genreleases/intent-templates-cursor-agent-sh-"$VERSION".zip \
  .genreleases/intent-templates-cursor-agent-ps-"$VERSION".zip \
  .genreleases/intent-templates-opencode-sh-"$VERSION".zip \
  .genreleases/intent-templates-opencode-ps-"$VERSION".zip \
  .genreleases/intent-templates-qwen-sh-"$VERSION".zip \
  .genreleases/intent-templates-qwen-ps-"$VERSION".zip \
  .genreleases/intent-templates-windsurf-sh-"$VERSION".zip \
  .genreleases/intent-templates-windsurf-ps-"$VERSION".zip \
  .genreleases/intent-templates-codex-sh-"$VERSION".zip \
  .genreleases/intent-templates-codex-ps-"$VERSION".zip \
  .genreleases/intent-templates-kilocode-sh-"$VERSION".zip \
  .genreleases/intent-templates-kilocode-ps-"$VERSION".zip \
  .genreleases/intent-templates-auggie-sh-"$VERSION".zip \
  .genreleases/intent-templates-auggie-ps-"$VERSION".zip \
  .genreleases/intent-templates-roo-sh-"$VERSION".zip \
  .genreleases/intent-templates-roo-ps-"$VERSION".zip \
  .genreleases/intent-templates-codebuddy-sh-"$VERSION".zip \
  .genreleases/intent-templates-codebuddy-ps-"$VERSION".zip \
  .genreleases/intent-templates-amp-sh-"$VERSION".zip \
  .genreleases/intent-templates-amp-ps-"$VERSION".zip \
  .genreleases/intent-templates-q-sh-"$VERSION".zip \
  .genreleases/intent-templates-q-ps-"$VERSION".zip \
  --title "Intent Templates - $VERSION_NO_V" \
  --notes-file release_notes.md
