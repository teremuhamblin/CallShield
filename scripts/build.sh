#!/usr/bin/env bash
set -e

echo "🔧 Building CallShield..."

# Android
echo "📱 Building Android..."
cd android
./gradlew assembleRelease
cd ..

# iOS
echo "🍎 Building iOS..."
cd ios
xcodebuild -scheme CallShield -configuration Release -sdk iphoneos
cd ..

# Backend
echo "🖥️ Building backend..."
cd backend
npm install --silent
npm run build
cd ..

echo "✅ Build completed successfully."
