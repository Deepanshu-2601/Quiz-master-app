# Welcome to Quiz Master

Get your quiz application running in 3 simple steps!

---

## Let's Get Started

### Quick Start

```bash
flutter emulators --launch emulator_name
cd "c:\Quiz App"
flutter run
```

Or if you already have an emulator running:

```bash
cd "c:\Quiz App"
flutter run
```

Already have Flutter? Run these commands:

```bash
flutter pub get
flutter run
```

### Need Flutter First

1. Install Flutter: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
2. Come back and run the commands above
3. Enjoy your quiz app

---

## Step 1: Install Flutter

Visit: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

### After Installation

Verify everything is set up correctly:

```bash
flutter doctor
```

You should see checks pass for Flutter and Android SDK.

---

## Step 2: Get Dependencies

Navigate to your project folder and run:

```bash
cd "path\to\Quiz App"
flutter pub get
```

---

## Step 3: Explore

Launch the app on your device or emulator:

```bash
flutter run
```

When the app launches, try:

- Home Screen: See all quizzes
- Select a Quiz: Choose any category
- Take the Quiz: Answer all questions
- View Results: Check your score and grade

---

## Choose Your Path

### I am in a Hurry

Run this:

```bash
flutter pub get
flutter run
```

Then explore the app!

### I Want to Understand the Project

Read: [README.md](README.md) for complete details.

### I Want to Set Up Properly

Follow: [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)

### I Want to Develop and Extend

Start with: [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)

### I Want to Deploy to Stores

See: [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

### I Want Everything Explained

Read: [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

---

## Running on Different Devices

### Android Emulator

```bash
flutter run
```

### Physical Android Phone

Connect your phone via USB and run:

```bash
flutter run
```

### iOS Simulator

Only on macOS:

```bash
flutter run -d ios
```

### Physical iPhone

Only on macOS with provisioning profile:

```bash
flutter run -d ios
```

---

## Tips During Development

### Hot Reload (Fast)

```bash
flutter run
# Press 'r' in terminal
```

### Hot Restart (Full Rebuild)

```bash
# Press 'R' in terminal
```

### Verbose Output for Debugging

```bash
flutter run -v
```

### Build Smaller APK for Android

```bash
flutter build apk --split-per-abi
```

### Profile Your App

```bash
flutter run --profile
```

---

## Troubleshooting

### "flutter command not found"

First time installing? Add Flutter to your PATH:

- Windows: Follow Flutter installation guide
- macOS/Linux: Add to `~/.bash_profile` or `~/.zshrc`

### "No devices found"

Create an Android emulator:

```bash
flutter emulators
flutter emulators launch <emulator_name>
```

### "Build fails"

Try these steps:

```bash
flutter clean
flutter pub get
flutter run -v
```

### Still stuck

Check troubleshooting:

- [QUICK_START.md](QUICK_START.md)
- [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)
- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

---

## What's in the App

The app includes 3 sample quizzes:

1. **Flutter Basics** - 5 questions about Flutter
2. **General Knowledge** - 5 general knowledge questions
3. **Programming Fundamentals** - 5 programming questions

All with immediate feedback and scoring!

---

## Next Steps

1. Run `flutter run` to launch the app
2. Explore the sample quizzes
3. Read [README.md](README.md) for complete information
4. Customize with your own quiz questions
5. Deploy to Google Play Store

---

## Need More Help

Check these files:

- **Full Docs**: [README.md](README.md)
- **Setup Help**: [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)
- **Development**: [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)
- **Deployment**: [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)
- **Navigation**: [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

---

## External Resources

- **Flutter Docs**: [Official Flutter Documentation](https://flutter.dev/docs)
- **Dart Guide**: [Dart Language Guide](https://dart.dev/guides)
- **Material Design**: [Material Design Specification](https://material.io/design)

---

## You're Ready

You now have everything you need to:

✅ Run the app locally  
✅ Explore sample quizzes  
✅ Customize with your own content  
✅ Deploy to app stores  

**Go forth and quiz!** 🚀

---

**Ready to begin?**

```bash
flutter pub get
flutter run
```
