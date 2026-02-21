# Deploy to Google Play Store & Web

Quiz Master is ready for deployment. Here's exactly how to launch it live.

---

## Quick Summary

Your app is complete. To deploy:

1. Build APK: `flutter build apk --release`
2. Create Play Store account ($25)
3. Upload to Google Play
4. Get approved (24-48 hours)
5. Go live 🚀

---

## Step 1: Testing Locally

### Test on Android Emulator

```bash
flutter emulators
flutter emulators launch emulator_name
cd "c:\Quiz App"
flutter run
```

### Test on Physical Phone

Connect via USB and run:

```bash
flutter run
```

---

## Step 2: Build for Release

### Build APK (Single File)

```bash
cd "c:\Quiz App"
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Build App Bundle (Recommended)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

---

## Step 3: Create Play Store Account

Go to [Google Play Console](https://play.google.com/console)

1. Sign in with Google account
2. Accept terms
3. Pay $25 fee
4. Complete setup

Time: 15-30 minutes

---

## Step 4: Create App Listing

In Google Play Console:

1. Click "Create app"
2. Enter "Quiz Master"
3. Select "Application"
4. For category select "Education"
5. Click Create

---

## Step 5: Add Store Assets

### Icon (512×512 PNG)

Create an icon for your app

### Screenshots (1080×1920 PNG, minimum 2)

Take 3-5 screenshots showing:

- Home screen with quiz list
- Quiz taking interface
- Results screen

### Descriptions

Short (80 chars):

```text
Master quizzes with instant feedback and scoring
```

Full (4000 chars):

```text
Quiz Master - Test Your Knowledge!

FEATURES:
- 15 Quiz Questions
- Multiple Categories
- Instant Scoring
- Beautiful Design
- Dark & Light Modes

CATEGORIES:
- Flutter Basics
- Dart Fundamentals
- App Development

Download now and start challenging yourself!
```

---

## Step 6: Upload App Bundle

In Play Console:

1. Go to Release > Production
2. Click "Create Release"
3. Upload your .aab file
4. Add release notes
5. Click "Save and review"
6. Click "Send for review"

Google reviews in 24-48 hours.

---

## Step 7: Web Distribution (Optional)

### Create Download Website

Create folder: `quiz-master-web`

Create `index.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Master - Download</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
        }
        .download-btn {
            background: #667eea;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <h1>Quiz Master</h1>
    <p>Test your knowledge with instant scoring!</p>
    <a href="app-release.apk" class="download-btn" download>
        Download APK
    </a>
</body>
</html>
```

### Host on Netlify (Free)

```bash
npm install -g netlify-cli
cd quiz-master-web
netlify deploy --prod
```

OR use GitHub Pages (free)

---

## What to Monitor

After launch, check Google Play Console for:

- Download count
- User ratings
- Reviews and feedback
- Crash reports
- Performance issues

---

## Update Your App

To release v1.0.1:

1. Update `pubspec.yaml`: `version: 1.0.1+2`
2. Build again: `flutter build appbundle --release`
3. Upload to Play Console
4. Create new release

---

## Success Checklist

- [ ] App tested on Android
- [ ] No crashes or errors
- [ ] Play Store account created
- [ ] App bundle built
- [ ] Store listing complete
- [ ] Screenshots uploaded
- [ ] Submitted for review
- [ ] Approved and live

---

## Useful Links

- [Google Play Console](https://play.google.com/console)
- [Netlify Hosting](https://netlify.com)
- [Firebase Hosting](https://firebase.google.com/products/hosting)

---

Your app is ready. Build it and get it live! 🚀
