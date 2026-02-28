#!/usr/bin/env bash
# new-author.sh
# Creates a new author folder under authors/ with all study files pre-populated from templates.
#
# Usage:
#   ./new-author.sh "Author Name"
#
# Example:
#   ./new-author.sh "Robin Hobb"
#   → creates authors/robin_hobb/ with all 6 files stamped with "Robin Hobb"

set -euo pipefail

# ── Validation ────────────────────────────────────────────────────────────────

if [[ $# -lt 1 ]]; then
  echo "Usage: ./new-author.sh \"Author Name\""
  exit 1
fi

AUTHOR_DISPLAY="$1"
DATE="$(date +%Y-%m-%d)"

# Convert display name to lowercase snake_case for the folder
AUTHOR_SLUG="$(echo "$AUTHOR_DISPLAY" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -cd '[:alnum:]_')"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/_templates"
AUTHORS_DIR="$SCRIPT_DIR/authors"
TARGET_DIR="$AUTHORS_DIR/$AUTHOR_SLUG"

if [[ ! -d "$TEMPLATES_DIR" ]]; then
  echo "Error: _templates/ directory not found at $TEMPLATES_DIR"
  exit 1
fi

if [[ -d "$TARGET_DIR" ]]; then
  echo "Error: Author folder already exists at $TARGET_DIR"
  exit 1
fi

# ── Create folder and stamp templates ────────────────────────────────────────

mkdir -p "$TARGET_DIR"

for template in "$TEMPLATES_DIR"/*.md; do
  filename="$(basename "$template")"

  sed \
    -e "s/{{AUTHOR_DISPLAY}}/$AUTHOR_DISPLAY/g" \
    -e "s/{{AUTHOR_SLUG}}/$AUTHOR_SLUG/g" \
    -e "s/{{DATE}}/$DATE/g" \
    "$template" > "$TARGET_DIR/$filename"
done

echo "✓ Created: authors/$AUTHOR_SLUG/"
echo "  Files:"
for f in "$TARGET_DIR"/*.md; do
  echo "    - $(basename "$f")"
done
