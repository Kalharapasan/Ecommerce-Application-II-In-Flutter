#!/bin/bash

echo "🔄 Installing dependencies..."
flutter pub get

echo "🔄 Generating files..."
flutter gen-l10n

echo "✅ Build complete!"