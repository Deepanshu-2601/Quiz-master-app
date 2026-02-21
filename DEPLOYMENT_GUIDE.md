# Deployment Guide for Quiz Master

This guide provides step-by-step instructions for deploying Quiz Master to Android, iOS, and Windows Store.

## Table of Contents

1. [Android (Google Play Store)](#android-google-play-store)
2. [iOS (Apple App Store)](#ios-apple-app-store)
3. [Windows (Microsoft Store)](#windows-microsoft-store)
4. [Common Issues](#common-issues)

---

## Android (Google Play Store)

### Prerequisites

- Register a Google Play Developer account ($25 one-time fee)
- Generate signing key for app signing
- Create app listing in Google Play Console

### Step 1: Generate Signing Key

```bash
keytool -genkey -v -keystore ~/quiz_app_keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias quiz_app_key
```

**Note**: Save the password securely, you'll need it for future builds.

### Step 2: Configure Signing in Android

Edit or create `android/key.properties`:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=quiz_app_key
storeFile=quiz_app_keystore.jks
```

Edit `android/app/build.gradle`:

```gradle
android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### Step 3: Build App Bundle

```bash
flutter build appbundle --target-platform android-arm,android-arm64,android-x86,android-x86_64
```

**Output**: `build/app/outputs/bundle/release/app-release.aab`

### Step 4: Upload to Google Play Console

1. Go to [Google Play Console](https://play.google.com/console)
2. Select "All apps" → Create new app
3. Fill in app details:
   - App name: "Quiz Master"
   - Default language: English
   - App type: Applications
   - Category: Education
4. Accept declarations and submit
5. Go to "Release" → "Production"
6. Upload the `.aab` file
7. Fill in release notes and submit for review

### Upload APK (Alternative to AAB)

```bash
flutter build apk --release
```

**Output**: `build/app/outputs/flutter-apk/app-release.apk`

### App Store Listing Requirements

- **App Title**: Quiz Master (max 50 characters)
- **Short Description**: Master quizzes across categories (max 80 characters)
- **Full Description**: Provide detailed description with features
- **Screenshots**: 5-8 screenshots (1080x1920 px)
- **Feature Graphic**: 1024x500 px
- **Icon**: 512x512 px high-res icon
- **Category**: Education > Reference
- **Content Rating**: Complete questionnaire
- **Privacy Policy**: Link to your privacy policy

---

## iOS (Apple App Store)

### iOS Prerequisites

- Apple Developer Account ($99/year)
- Mac with Xcode installed
- Provisioning profiles and certificates

### Step 1: Prepare Your App in Xcode

```bash
cd ios
pod install
cd ..
```

Open Xcode project:

```bash
open ios/Runner.xcworkspace
```

### Step 2: Configure App Signing

In Xcode:

1. Select "Runner" project
2. Go to "Signing & Capabilities"
3. Select "Team" (your Apple Development Team)
4. Ensure bundle identifier is unique: `com.yourcompany.quizmaster`

### Step 3: Archive the App

```bash
flutter build ios --release
```

Or via Xcode:

1. Select "Generic iOS Device" in scheme dropdown
2. Product → Archive
3. Verify archive is created

### Step 4: Export for App Store

```bash
cd ios
xcodebuild -workspace Runner.xcworkspace \
  -scheme Runner \
  -configuration Release \
  -archivePath build/Runner.xcarchive \
  archive

xcodebuild -exportArchive \
  -archivePath build/Runner.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath build/ipa
cd ..
```

**ExportOptions.plist**:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>stripSwiftSymbols</key>
    <true/>
    <key>thinning</key>
    <string>&lt;none&gt;</string>
</dict>
</plist>
```

### Step 5: Upload to App Store Connect

#### Option A: Via Xcode

1. Window → Organizer
2. Select your archive
3. Distribute App → App Store Connect

#### Option B: Via Transporter App

1. Open Transporter app on Mac
2. Sign in with Apple ID
3. Drag and drop `.ipa` file
4. Upload

### Step 6: Submit for Review

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Go to "App Information"
4. Configure:
   - Primary Category: Education
   - Supported Devices: iPhone & iPad
   - App Privacy Policy URL
   - Support URL
5. Go to "Pricing and Availability"
6. Set price and availability
7. Submit for Review

### iOS App Store Listing Requirements

- **App Name**: Quiz Master (30 characters)
- **Subtitle**: Master Your Knowledge (30 characters)
- **Keyword**: quiz, learning, education (100 characters)
- **Description**: Detailed description (4000 characters)
- **Screenshots**: 6-8 per orientation (iPhone: 1125x2436 px)
- **App Preview Video**: Optional (30 sec max)
- **App Icon**: 1024x1024 px
- **Privacy Policy**: Required URL

---

## Windows (Microsoft Store)

### Windows Prerequisites

- Microsoft Partner Center account
- Windows 10/11 development environment
- Visual Studio 2019 or later

### Step 1: Update Windows Packaging

Ensure `windows/CMakeLists.txt` is properly configured.

### Step 2: Build Windows Release

```bash
flutter build windows --release
```

**Output**: `build/windows/runner/Release/`

### Step 3: Create MSIX Package

Install MSIX Packaging Tool:

```bash
ms-windows-store://pdp/?productid=9N5LW3JBSXKB
```

Or via Windows Package Manager:

```powershell
winget install Microsoft.MsixPackagingTool
```

### Step 4: Generate Certificate

For Microsoft Store submission, you need a certificate. Generate it:

```powershell
$cert = New-SelfSignedCertificate `
  -Type Custom `
  -Subject "CN=Quiz Master" `
  -KeyUsage DigitalSignature `
  -FriendlyName "Quiz Master Certificate" `
  -CertStoreLocation "cert:\CurrentUser\My" `
  -KeyExportPolicy Exportable

Export-PfxCertificate `
  -Cert $cert `
  -FilePath quiz_master.pfx `
  -Password (ConvertTo-SecureString -String "PASSWORD" -AsPlainText -Force)
```

### Step 5: Create MSIX Package via MakeAppX

```batch
cd build\windows\runner\Release
makeappx pack /d . /p Quiz.Master.msix
```

Or use MSIX Packaging Tool GUI:

1. Open MSIX Packaging Tool
2. Select "Application package"
3. Navigate to `build/windows/runner/Release/`
4. Configure app details
5. Generate MSIX package

### Step 6: Register Developer Certificate

```powershell
$pfxCertPath = "quiz_master.pfx"
$password = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force
Import-PfxCertificate -FilePath $pfxCertPath -CertStoreLocation Cert:\LocalMachine\Root -Password $password
```

### Step 7: Submit to Microsoft Store

1. Go to [Partner Center](https://partner.microsoft.com/dashboard)
2. Create new app submission
3. Configure app details:
   - **Name**: Quiz Master
   - **Category**: Education & Reference
   - **Subcategory**: Reference
   - **Description**: Detailed app description
   - **Screenshots**: 4-9 screenshots (1920x1080 px minimum)
   - **Icon**: 300x300 px (PNG format)
4. Upload MSIX package
5. Set pricing and availability
6. Submit for certification

### Microsoft Store Listing Requirements

- **App Name**: Quiz Master
- **Description**: 10-10,000 characters
- **Release Notes**: Version release information
- **Screenshots**: Windows 10 screenshots required
- **Publisher Name**: Your company name
- **Developer Name**: Your name/company
- **Developer Website**: Your website
- **Support Contact Info**: Valid email/phone
- **Privacy Policy URL**: Required

---

## Common Issues

### Android Issues

#### Issue: "Gradle build failed"

```bash
flutter clean
flutter pub get
flutter build apk --verbose
```

#### Issue: "Missing signing configuration"

- Ensure `key.properties` file exists in `android/`
- Verify keystore path is correct
- Check password is correct

#### Issue: "Certificate not trusted"

- Recreate keystore with correct parameters
- Ensure validity period is sufficient (10+ years)

### iOS Issues

#### Issue: "Pod install failed"

```bash
cd ios
rm -rf Pods Podfile.lock .symlinks
pod install
cd ..
flutter clean
flutter pub get
```

#### Issue: "Code signing failed"

- Verify Apple Developer account is active
- Check team ID is correct
- Ensure certificate is not expired
- Try: Run → Edit Scheme → Archive → Code Signing

#### Issue: "Build hangs at archiving"

- Increase Xcode memory: Xcode → Preferences → Locations
- Try building with: `flutter build ios --release --verbose`

### Windows Issues

#### Issue: "CMake configuration failed"

```bash
flutter clean
flutter pub get
flutter doctor
```

#### Issue: "Certificate validation failed"

- Ensure certificate is properly installed
- Check certificate expiration date
- Use proper Admin PowerShell for import

#### Issue: "MSIX package creation failed"

- Verify directory structure is correct
- Check file permissions
- Ensure Windows 10 version 1809 or later

## Version Updates

When updating version for new releases:

1. Update `pubspec.yaml`:

   ```yaml
   version: 1.0.1+2
   ```

2. Update Android in `android/app/build.gradle`: versionCode, versionName

3. Update iOS in `ios/Runner.xcodeproj`: CFBundleVersion, CFBundleShortVersionString

4. Update Windows in `windows/runner/main.cpp`: Version info

## Testing Before Deployment

```bash
flutter run -d <device_id> --release
flutter build apk --release
flutter build ios --release
flutter build windows --release
flutter build appbundle --release
```

## Support & Troubleshooting

For additional help:

- [Flutter Docs](https://flutter.dev/docs)
- [Google Play Console Help](https://support.google.com/googleplay)
- [App Store Connect Help](https://help.apple.com/app-store-connect)
- [Partner Center Help](https://docs.microsoft.com/windows/uwp)

---

**Last Updated**: February 2026
