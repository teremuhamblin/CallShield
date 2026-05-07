#!/bin/bash

VERSION_FILE="VERSION"

if [ ! -f "$VERSION_FILE" ]; then
  echo "0.1.0" > $VERSION_FILE
fi

VERSION=$(cat $VERSION_FILE)

IFS='.' read -r major minor patch <<< "$VERSION"

case "$1" in
  major)
    major=$((major+1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor+1))
    patch=0
    ;;
  patch)
    patch=$((patch+1))
    ;;
  *)
    echo "Usage: ./version.sh [major|minor|patch]"
    exit 1
    ;;
esac

NEW_VERSION="$major.$minor.$patch"
echo $NEW_VERSION > $VERSION_FILE

echo "New version: $NEW_VERSION"
