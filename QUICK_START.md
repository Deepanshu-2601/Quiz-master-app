# Quick Start Guide

Get Quiz Master up and running in 5 minutes!

## Prerequisites

- **Flutter SDK**: Download from [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart 3.0+**: Included with Flutter
- **Git**: For version control
- A device or emulator to run the app

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/quiz_app.git
cd quiz_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

Select your target device and run:

```bash
flutter run
```

## Running on Different Devices

### Android Emulator

```bash
# List available devices
flutter devices

# Run on Android emulator
flutter run -d <device_id>
```

### iOS Simulator

```bash
# List available devices
flutter devices

# Run on iOS simulator
flutter run -d <device_id>
```

### Windows

```bash
# Run on Windows
flutter run -d windows
```

### Physical Device

```bash
# For Android physical device
flutter run -d <device_id>

# For iOS physical device (requires provisioning profile)
flutter run -d <device_id>
```

## First Time Using Quiz Master

Welcome to Quiz Master! Here's what you can do:

1. **Home Screen** - Dashboard with quizzes

   - View all available quizzes
   - See your stats and history

2. **Quiz Screen** - Take a quiz

   - Select questions
   - Get immediate feedback

3. **Results Screen** - View results

   - See your score and grade
   - Review your answers

Example code:

```dart
// Start using Provider to manage quiz state
final provider = context.read<QuizProvider>();
provider.startQuiz('quiz_id');
```

## Common Issues & Solutions

### App won't run

```bash
flutter clean
flutter pub get
flutter run -v
```

### Emulator not starting

```bash
flutter emulators
flutter emulators launch <emulator_name>
```

### Dependencies issue

```bash
flutter pub cache repair
flutter pub get
```

### For more help

```bash
flutter doctor
flutter doctor -v
```

## Next Steps

1. Read [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) to understand the architecture
2. Check [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) for detailed setup
3. See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) to deploy to app stores

## Tips

- Use `flutter run -d <device>` to specify a device
- Press `r` for hot reload
- Press `R` for hot restart
- Press `q` to quit

---

**Enjoy building with Quiz Master!** 🚀
