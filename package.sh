#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
# ManageLM OpenAI GPT Plugin — Build & package script
#
# Creates a distributable tarball containing the OpenAPI spec,
# GPT instructions, icon, and documentation.
#
# Usage:  ./package.sh
# Output: managelm-openai-gpt-<version>.tar.gz
# ──────────────────────────────────────────────────────────────────
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"
git config --global --add safe.directory "$ROOT_DIR" 2>/dev/null || true

VERSION=$(node -p "require('./package.json').version")
OUTFILE="managelm-openai-gpt-${VERSION}.tar.gz"
STAGING_DIR=$(mktemp -d)

trap 'rm -rf "$STAGING_DIR"' EXIT

# ── Assemble staging directory ────────────────────────────────────
echo "▸ Assembling package..."

TARGET="$STAGING_DIR/managelm-openai-gpt"
mkdir -p "$TARGET"

# Plugin files
cp openapi.yaml "$TARGET/"
cp instructions.md "$TARGET/"
cp README.md "$TARGET/"
cp LICENSE "$TARGET/"
cp icon.png "$TARGET/" 2>/dev/null || true

# ── Create tarball ────────────────────────────────────────────────
echo "▸ Creating tarball..."
tar czf "$ROOT_DIR/$OUTFILE" -C "$STAGING_DIR" managelm-openai-gpt

SIZE=$(du -h "$ROOT_DIR/$OUTFILE" | cut -f1)

# Restore ownership (scripts may run as root)
[[ "$ROOT_DIR" == "/" ]] && { echo "FATAL: ROOT_DIR is /"; exit 1; }
chown -R claude:claude "$ROOT_DIR"

echo ""
echo "Done: $OUTFILE ($SIZE)"
