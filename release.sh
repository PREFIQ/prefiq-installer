#!/bin/bash

set -e

# CONFIG
PACKAGE_NAME="prefiq_installer"
VERSION_FILE="./$PACKAGE_NAME/version.py"

# Validate file
if [[ ! -f "$VERSION_FILE" ]]; then
  echo "❌ $VERSION_FILE not found!"
  exit 1
fi

# Load current version
CURRENT_VERSION=$(grep '__version__' "$VERSION_FILE" | cut -d '"' -f2)
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

echo "📦 Current version: $CURRENT_VERSION"

# Get bump type
BUMP_TYPE=$1
if [[ "$BUMP_TYPE" == "--patch" ]]; then
  PATCH=$((PATCH + 1))
elif [[ "$BUMP_TYPE" == "--minor" ]]; then
  MINOR=$((MINOR + 1))
  PATCH=0
elif [[ "$BUMP_TYPE" == "--major" ]]; then
  MAJOR=$((MAJOR + 1))
  MINOR=0
  PATCH=0
else
  echo "⚠️  Usage: ./release.sh [--patch|--minor|--major]"
  exit 1
fi

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "🔧 Bumping version to $NEW_VERSION"

# Replace version
sed -i '' "s/__version__ = .*/__version__ = \"$NEW_VERSION\"/" "$VERSION_FILE" 2>/dev/null || \
sed -i "s/__version__ = .*/__version__ = \"$NEW_VERSION\"/" "$VERSION_FILE"

# Git commit, tag, and push
echo "📤 Committing and pushing release..."
git add "$VERSION_FILE"
git commit -m "🔖 Release v$NEW_VERSION"
git tag "v$NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

echo "✅ Version bumped to $NEW_VERSION and pushed to GitHub"
echo "🚀 GitHub Actions will now build and publish to PyPI automatically."
