#!/usr/bin/env bash
set -e

echo "✨ Formatting codebase..."

# Android
echo "📱 Formatting Android..."
cd android
./gradlew ktlintFormat
cd ..

# iOS
echo "🍎 Formatting iOS..."
swiftformat ios

# Backend
echo "🖥️ Formatting backend..."
cd backend
npm run format
cd ..

# UI (React Native or Flutter)
if [ -d "ui" ]; then
  echo "🎨 Formatting UI..."
  cd ui
  if [ -f "package.json" ]; then
    npm run format
  elif [ -f "pubspec.yaml" ]; then
    dart format .
  fi
  cd ..
fi

echo "✅ Formatting completed."
