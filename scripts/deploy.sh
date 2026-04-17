#!/usr/bin/env bash
set -e

echo "🚀 Deploying CallShield..."

# Backend deploy
echo "🖥️ Deploying backend..."
cd backend
npm run deploy
cd ..

# Static docs deploy (GitHub Pages)
echo "📚 Deploying documentation..."
git subtree push --prefix docs origin gh-pages

echo "✅ Deployment completed."
