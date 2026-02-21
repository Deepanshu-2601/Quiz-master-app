# Setup Instructions for Quiz Master

Complete setup guide for Flutter development environment and Quiz Master project.

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Flutter Installation](#flutter-installation)
3. [Setting Up Android](#setting-up-android)
4. [Setting Up iOS](#setting-up-ios)
5. [Setting Up Windows](#setting-up-windows)
6. [Project Setup](#project-setup)
7. [Verification](#verification)

---

## System Requirements

### All Platforms

- **Git**: Version control system
- **Text Editor/IDE**: VS Code, Android Studio, or Xcode

### Windows

- Windows 10 or later
- Administrator access for some tools

### macOS (for iOS/Mac builds)

- macOS 11.0 or later
- Apple Developer ID

### Android Development

- Android SDK 21 or higher (latest Android 14 recommended)
- Android Studio or command-line tools
- Java SDK 11 or later

### iOS Development

- Xcode 12.0 or later (macOS only)
- Cocoapods
- Apple Developer Account

---

## Flutter Installation

### Flutter on Windows

Download and install from [Flutter official guide](https://flutter.dev/docs/get-started/install/windows):

```bash
# Extract Flutter SDK to a location like C:\flutter
# Add to PATH

# Verify installation
flutter --version
flutter doctor
```

#### Windows Path Configuration

```powershell
# Set Flutter path
setx PATH "%PATH%;C:\flutter\bin"

# Close and reopen PowerShell, then verify
flutter doctor
```

### Flutter on macOS/Linux

```bash
# Download and extract
cd ~
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:~/flutter/bin"

# Add to ~/.bash_profile or ~/.zshrc permanently
echo 'export PATH="$PATH:~/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

#### macOS/Linux Path Configuration

```bash
# Already added above
flutter doctor
```

## Setting Up Android

### Android Installation Steps

- ✅ Flutter SDK
- ✅ Android SDK

Download from: [Android Studio](https://developer.android.com/studio)

1. Open Android Studio
1. **SDK Manager** → Install latest Android SDK
1. **Device Manager** → Create emulator (optional)

### Verify Android Setup

```bash
flutter doctor -v
```

Expected output:

- `✓` Android toolchain - develop for Android devices
- `✓` Android Studio
- `✓` Android SDK all components

### Launch Android Emulator

```bash
# List emulators
emulator -list-avds

# Launch emulator
emulator -avd <emulator_name>

# Or use Flutter
flutter emulators
flutter emulators launch <name>
```

## Setting Up iOS

### iOS Installation Steps

1. Install Xcode from App Store
1. Open Xcode and accept license:

   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

1. Install CocoaPods:

   ```bash
   sudo gem install cocoapods
   ```

### Verify iOS Setup

```bash
flutter doctor -v
```

Expected output:

- `✓` Xcode - develop for iOS and macOS
- `✓` CocoaPods
- `✓` iOS deployment target

### Launch iOS Simulator

```bash
# Launch simulator
open -a Simulator

# Or use Flutter
flutter emulators
flutter emulators launch iOS
```

## Setting Up Windows

### Windows Installation Steps

1. Download Visual Studio Build Tools or Community Edition
1. Install Windows SDK and MSVC
1. Enable Developer Mode in Windows Settings

### Verify Windows Setup

```bash
flutter doctor -v
```

Expected output:

- ✅ Visual Studio build tools
- ✅ Windows SDK
- ✅ C++ build tools

---

## Project Setup

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/quiz_app.git
cd quiz_app
```

### 2. Install Project Dependencies

```bash
flutter pub get
```

### 3. Verify Project

```bash
flutter analyze
```

Expected results:

- 0 errors
- 0 warnings (or manageable warnings)

### 4. Build & Run

```bash
# Run on default device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in release mode
flutter run --release
```

## Verification

### Flutter Doctor Checklist

After setup, run:

```bash
flutter doctor
```

You should see checkmarks (✓) for:

- ✅ Flutter SDK
- ✅ Android toolchain (for Android)
- ✅ Xcode / iOS tools (for iOS)
- ✅ VS Code / Android Studio
- ✅ Connected devices

Optional:

- ✅ Chrome (for web support)
- ✅ Android SDK version

### Project Build Verification

```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Build APK (Android)
flutter build apk

# Build AAB (Android)
flutter build appbundle

# Build iOS (macOS)
flutter build ios

# Build Windows
flutter build windows
```

## Hot Reload & Development

### During Development

```bash
# Run with hot reload
flutter run

# In terminal:
# Press 'r' to hot reload (fast, keeps state)
# Press 'R' to hot restart (slow, clears state)
# Press 'q' to quit
```

### Build Modes

#### Debug APK (for testing)

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

#### Release APK (for distribution)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## Troubleshooting

### "Flutter not found"

Ensure Flutter is in your PATH:

```bash
# Check if Flutter is in PATH
flutter --version

# If not found, add to PATH (Windows)
setx PATH "%PATH%;C:\flutter\bin"
```

### "Android SDK not found"

```bash
flutter config --android-sdk /path/to/android/sdk
```

### "No connected devices"

```bash
flutter devices
flutter emulators launch iOS
emulator -avd <device_name>
```

### Dependency Issues

```bash
flutter clean
flutter pub get
flutter pub cache repair
```

---

## Additional Resources

- [Flutter Official Documentation](https://flutter.dev/docs)
- [Android Developer Guide](https://developer.android.com/docs)
- [iOS Development Guide](https://developer.apple.com/documentation/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

## Next Steps

1. Read [QUICK_START.md](QUICK_START.md) for a quick 5-minute start
2. Review [README.md](README.md) for project overview
3. Check [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) for architecture details
4. See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) when ready to publish

---

**Setup Complete!** You're ready to start developing with Quiz Master. 🎉
