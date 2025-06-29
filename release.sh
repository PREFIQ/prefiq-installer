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
echo "🔧 Updating version to $NEW_VERSION..."

# Replace version
sed -i '' "s/__version__ = .*/__version__ = \"$NEW_VERSION\"/" "$VERSION_FILE" 2>/dev/null || \
sed -i "s/__version__ = .*/__version__ = \"$NEW_VERSION\"/" "$VERSION_FILE"

# Clean previous builds
echo "🧹 Cleaning old builds..."
rm -rf dist/ build/ *.egg-info

# Build
echo "🏗️  Building..."
python -m build

# Load .env
if [ -f ".env" ]; then
  export $(cat .env | xargs)
fi

# Upload
echo "🚀 Uploading to PyPI..."
twine upload -u "$PYPI_USERNAME" -p "$PYPI_PASSWORD" dist/*

echo "🎉 Release complete: v$NEW_VERSION"
