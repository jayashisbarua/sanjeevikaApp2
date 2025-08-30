#!/bin/bash

# Sanjeevika Flutter App Build Script
# This script helps build the app for different platforms

echo "🚀 Sanjeevika App Build Script"
echo "================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Get Flutter version
echo "📱 Flutter Version: $(flutter --version | head -n 1)"

# Clean the project
echo "🧹 Cleaning project..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run code generation
echo "🔧 Running code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Build options
echo ""
echo "Select build option:"
echo "1. Debug APK"
echo "2. Release APK"
echo "3. App Bundle (AAB)"
echo "4. iOS (requires macOS)"
echo "5. Web"
echo "6. All platforms"

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        echo "🔨 Building Debug APK..."
        flutter build apk --debug
        echo "✅ Debug APK built successfully!"
        echo "📁 Location: build/app/outputs/flutter-apk/app-debug.apk"
        ;;
    2)
        echo "🔨 Building Release APK..."
        flutter build apk --release
        echo "✅ Release APK built successfully!"
        echo "📁 Location: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    3)
        echo "🔨 Building App Bundle..."
        flutter build appbundle --release
        echo "✅ App Bundle built successfully!"
        echo "📁 Location: build/app/outputs/bundle/release/app-release.aab"
        ;;
    4)
        echo "🔨 Building for iOS..."
        flutter build ios --release
        echo "✅ iOS build completed!"
        echo "📁 Check Xcode for the .ipa file"
        ;;
    5)
        echo "🔨 Building for Web..."
        flutter build web --release
        echo "✅ Web build completed!"
        echo "📁 Location: build/web/"
        ;;
    6)
        echo "🔨 Building for all platforms..."
        flutter build apk --release
        flutter build appbundle --release
        flutter build web --release
        echo "✅ All builds completed!"
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "🎉 Build process completed!"
echo "📱 You can now install the APK on your Android device or upload to app stores."
