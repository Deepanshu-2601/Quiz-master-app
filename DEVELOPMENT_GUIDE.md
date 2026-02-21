# Development Guide

This guide helps developers understand the architecture and extend the Quiz Master application.

## Architecture Overview

Quiz Master uses a layered architecture with clear separation of concerns:

```text
┌─────────────────────────────┐
│     User Interface (UI)      │
│   (Screens, Widgets)        │
└──────────────┬──────────────┘
               │
┌──────────────▼──────────────┐
│  State Management (Provider)│
│   (QuizProvider)            │
└──────────────┬──────────────┘
               │
┌──────────────▼──────────────┐
│    Models & Data Layer      │
│ (Quiz, Question, Results)   │
└──────────────┬──────────────┘
               │
┌──────────────▼──────────────┐
│   Services & Persistence    │
│ (QuizDataService, Prefs)    │
└─────────────────────────────┘
```

## Directory Structure & Files

### `/lib/main.dart`

- Application entry point
- Provider configuration
- Material app setup
- Theme configuration

### `/lib/models/quiz_models.dart`

- `Question`: Single quiz question with options
- `Quiz`: Collection of questions
- `QuizResult`: User's quiz completion result

### `/lib/providers/quiz_provider.dart`

- Manages quiz state globally
- Handles quiz flow (start, navigate, submit)
- Persists user results
- Calculates statistics

### `/lib/screens/`

- **home_screen.dart**: Main dashboard
- **quiz_screen.dart**: Quiz-taking interface
- **results_screen.dart**: Results display

### `/lib/services/quiz_data_service.dart`

- Quiz data management
- Database queries
- Category filtering

### `/lib/utils/constants.dart`

- App-wide constants
- Colors, spacing, text sizes
- Configuration parameters

## Key Classes & Their Responsibilities

### Question

```dart
class Question {
  final String id;              // Unique identifier
  final String text;            // Question text
  final List<String> options;   // Answer options
  final int correctAnswerIndex; // Index of correct answer
  final String? explanation;    // Why the answer is correct
}
```

### Quiz

```dart
class Quiz {
  final String id;                      // Unique identifier
  final String title;                   // Quiz title
  final String description;              // Quiz description
  final String category;                // Quiz category
  final List<Question> questions;       // Questions in quiz
  final int timePerQuestion;            // Time per question in seconds
}
```

### QuizResult

```dart
class QuizResult {
  final String quizId;              // Which quiz was taken
  final String quizTitle;           // Quiz title for display
  final int totalQuestions;         // Total Q's in quiz
  final int correctAnswers;         // Q's answered correctly
  final int wrongAnswers;           // Q's answered wrongly
  final DateTime completedAt;       // When quiz was completed
  final List<int> selectedAnswers;  // User's answer choices
  final int timeTaken;              // Total time in seconds
  
  // Helper properties
  double get percentage { /* score% */ }
  String get grade { /* A/B/C/D/F */ }
}
```

### QuizProvider

```dart
class QuizProvider extends ChangeNotifier {
  // State
  List<Quiz> _quizzes;            // All available quizzes
  Quiz? _currentQuiz;             // Currently active quiz
  int _currentQuestionIndex;      // Current question
  List<int> _selectedAnswers;     // User selections
  int _timeElapsed;               // Time spent
  List<QuizResult> _results;      // Quiz history
  bool _isQuizStarted;            // Quiz status
  
  // Methods
  startQuiz(String quizId)        // Begin a quiz
  selectAnswer(int index)         // Select an option
  nextQuestion()                  // Move to next
  previousQuestion()              // Move to previous
  submitQuiz()                    // Complete quiz
  resetQuiz()                     // Clear state
}
```

## Adding New Quiz Questions

### Option 1: Add to Static Data

Edit `lib/services/quiz_data_service.dart`:

```dart
Quiz(
  id: 'new_quiz_id',
  title: 'New Quiz Title',
  description: 'Quiz description',
  category: 'Technology',
  timePerQuestion: 30,
  questions: [
    Question(
      id: 'q1',
      text: 'What is the capital of France?',
      options: [
        'London',
        'Paris',
        'Berlin',
        'Madrid',
      ],
      correctAnswerIndex: 1,
      explanation: 'Paris is the capital of France.',
    ),
    // Add more questions...
  ],
),
```

### Option 2: Load from Remote API

Create `lib/services/api_service.dart`:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://your-api.com/api';
  
  static Future<List<Quiz>> fetchQuizzes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quizzes'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((q) => Quiz.fromJson(q)).toList();
      }
      throw Exception('Failed to load quizzes');
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
```

Update `QuizProvider`:

```dart
Future<void> fetchRemoteQuizzes() async {
  _quizzes = await ApiService.fetchQuizzes();
  notifyListeners();
}
```

## Extending Features

### Adding Premium Features

Create `lib/providers/premium_provider.dart`:

```dart
class PremiumProvider extends ChangeNotifier {
  bool _isPremium = false;
  
  bool get isPremium => _isPremium;
  
  Future<void> checkPremiumStatus() async {
    // Check via API or local storage
    notifyListeners();
  }
  
  Future<void> purchasePremium() async {
    // Handle in-app purchase
    notifyListeners();
  }
}
```

### Adding Analytics

Add `google_analytics_flutter` to pubspec.yaml:

```dart
import 'package:google_analytics_flutter/google_analytics_flutter.dart';

class AnalyticsService {
  static final analytics = GoogleAnalyticsFlutter();
  
  static void logQuizStarted(String quizId) {
    analytics.logEvent(
      name: 'quiz_started',
      parameters: {'quiz_id': quizId},
    );
  }
  
  static void logQuizCompleted(QuizResult result) {
    analytics.logEvent(
      name: 'quiz_completed',
      parameters: {
        'quiz_id': result.quizId,
        'score': result.percentage,
      },
    );
  }
}
```

### Adding User Authentication

Create `lib/providers/auth_provider.dart`:

```dart
class AuthProvider extends ChangeNotifier {
  User? _user;
  
  User? get user => _user;
  bool get isLoggedIn => _user != null;
  
  Future<void> login(String email, String password) async {
    // Firebase auth or custom API
    _user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }
  
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
```

### Adding Leaderboards

Create `lib/screens/leaderboard_screen.dart`:

```dart
class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboards')),
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          final sorted = provider.results
            ..sort((a, b) => b.percentage.compareTo(a.percentage));
          
          return ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final result = sorted[index];
              return ListTile(
                leading: Text('#${index + 1}'),
                title: Text(result.quizTitle),
                trailing: Text('${result.percentage.toStringAsFixed(1)}%'),
              );
            },
          );
        },
      ),
    );
  }
}
```

## State Management Deep Dive

### Provider Pattern

Quiz Master uses Provider for state management:

```dart
// Listen to changes
Consumer<QuizProvider>(
  builder: (context, provider, child) {
    return Text(provider.currentQuizTitle);
  },
)

// Access without listening
final provider = context.read<QuizProvider>();
provider.startQuiz('quiz_id');

// Selector for specific properties
Selector<QuizProvider, int>(
  selector: (context, provider) => provider.progress,
  builder: (context, progress, child) {
    return LinearProgressIndicator(value: progress / 100);
  },
)
```

### Provider vs setState

```dart
// BAD: Using setState
class BadWidget extends StatefulWidget {
  @override
  State<BadWidget> createState() => _BadWidgetState();
}

class _BadWidgetState extends State<BadWidget> {
  List<Quiz> quizzes = [];
  
  @override
  void initState() {
    _loadQuizzes(); // Can't access context
    super.initState();
  }
}

// GOOD: Using Provider
class GoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.quizzes.length,
          itemBuilder: (context, index) {
            return QuizCard(quiz: provider.quizzes[index]);
          },
        );
      },
    );
  }
}
```

## Testing

Create `test/quiz_provider_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/providers/quiz_provider.dart';

void main() {
  group('QuizProvider', () {
    late QuizProvider provider;
    
    setUp(() {
      provider = QuizProvider();
    });
    
    test('startQuiz initializes quiz correctly', () {
      provider.startQuiz('1');
      
      expect(provider.currentQuiz, isNotNull);
      expect(provider.currentQuestionIndex, 0);
      expect(provider.isQuizStarted, true);
    });
    
    test('selectAnswer saves selection', () {
      provider.startQuiz('1');
      provider.selectAnswer(2);
      
      expect(provider.selectedAnswers[0], 2);
    });
    
    test('submitQuiz calculates correct score', () {
      provider.startQuiz('1');
      // Select correct answers
      provider.selectAnswer(1); // q1 correct
      provider.nextQuestion();
      provider.selectAnswer(2); // q2 correct
      
      final result = provider.submitQuiz();
      
      expect(result.correctAnswers, greaterThan(0));
    });
  });
}
```

Run tests:

```bash
flutter test
```

## Performance Optimization

### 1. Lazy Loading

```dart
class QuizProvider extends ChangeNotifier {
  Map<String, Quiz> _quizCache = {};
  
  Quiz? getQuizById(String id) {
    if (_quizCache.containsKey(id)) {
      return _quizCache[id];
    }
    
    final quiz = QuizDataService.getQuizById(id);
    if (quiz != null) {
      _quizCache[id] = quiz;
    }
    return quiz;
  }
}
```

### 2. Selective Rebuilds

```dart
// Instead of:
Consumer<QuizProvider>(
  builder: (context, provider, _) {
    return Column(
      children: [
        Text(provider.currentQuiz!.title),     // Rebuilds
        LinearProgressIndicator(
          value: provider.progress / 100,       // Rebuilds
        ),
        QuestionWidget(
          question: provider.currentQuestion,  // Rebuilds
        ),
      ],
    );
  },
)

// Use Selector to listen to specific properties:
Column(
  children: [
    Selector<QuizProvider, String>(
      selector: (_, provider) => provider.currentQuiz!.title,
      builder: (_, title, __) => Text(title),
    ),
    Selector<QuizProvider, int>(
      selector: (_, provider) => provider.progress,
      builder: (_, progress, __) => LinearProgressIndicator(
        value: progress / 100,
      ),
    ),
  ],
)
```

### 3. Image Optimization

```dart
Image.asset(
  'assets/images/icon.png',
  cacheHeight: 200,
  cacheWidth: 200,
)
```

## Debugging

### Debug Logs

```dart
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Debug message');
  debugPrint('Long message');
}
```

### DevTools

```bash
flutter pub global activate devtools
devtools

# Then open: http://localhost:9100
```

### Hot Reload & Hot Restart

```bash
# Hot reload (fast)
r

# Hot restart (slower, full rebuild)
R

# Quit
q
```

## Common Patterns

### Handling Errors Gracefully

```dart
Future<void> submitQuizSafely() async {
  try {
    final result = context.read<QuizProvider>().submitQuiz();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz submitted successfully!')),
      );
      Navigator.pushNamed(context, '/results');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
```

### Safe Navigation

```dart
class SafeQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        if (provider.currentQuiz == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        final question = provider.currentQuestion;
        if (question == null) {
          return const SizedBox.shrink();
        }
        
        return // Quiz UI
      },
    );
  }
}
```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Dart Language Guide](https://dart.dev/guides)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Material Design](https://material.io/design)

---

**Happy Coding!** 🚀
