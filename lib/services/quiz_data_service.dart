import '../models/quiz_models.dart';

class QuizDataService {
  static final List<Quiz> _quizzesDatabase = [
    Quiz(
      id: '1',
      title: 'Flutter Basics',
      description: 'Test your knowledge about Flutter framework',
      category: 'Technology',
      timePerQuestion: 30,
      questions: [
        Question(
          id: 'q1',
          text: 'What is Flutter?',
          options: [
            'A web framework',
            'A mobile framework by Google',
            'A database system',
            'A design tool',
          ],
          correctAnswerIndex: 1,
          explanation: 'Flutter is an open-source mobile application framework created by Google.',
        ),
        Question(
          id: 'q2',
          text: 'Which language does Flutter use?',
          options: [
            'Java',
            'Kotlin',
            'Dart',
            'Swift',
          ],
          correctAnswerIndex: 2,
          explanation: 'Flutter uses Dart as its primary programming language.',
        ),
        Question(
          id: 'q3',
          text: 'What is a Widget in Flutter?',
          options: [
            'A database table',
            'The basic building block of UI',
            'A state management tool',
            'A testing framework',
          ],
          correctAnswerIndex: 1,
          explanation: 'Widgets are the basic building blocks of Flutter UI. Everything in Flutter is a widget.',
        ),
        Question(
          id: 'q4',
          text: 'Which company created Dart?',
          options: [
            'Microsoft',
            'Apple',
            'Google',
            'Facebook',
          ],
          correctAnswerIndex: 2,
          explanation: 'Dart was created by Google in 2011.',
        ),
        Question(
          id: 'q5',
          text: 'What does "Hot Reload" do in Flutter?',
          options: [
            'Crashes the app',
            'Allows you to see code changes instantly',
            'Restarts the entire app',
            'Clears the database',
          ],
          correctAnswerIndex: 1,
          explanation: 'Hot Reload allows you to see the results of your code changes instantly during development.',
        ),
      ],
    ),
    Quiz(
      id: '2',
      title: 'General Knowledge',
      description: 'Test your general knowledge',
      category: 'Education',
      timePerQuestion: 30,
      questions: [
        Question(
          id: 'q1',
          text: 'What is the capital of France?',
          options: [
            'London',
            'Berlin',
            'Paris',
            'Madrid',
          ],
          correctAnswerIndex: 2,
          explanation: 'Paris is the capital and most populous city of France.',
        ),
        Question(
          id: 'q2',
          text: 'Which planet is known as the Red Planet?',
          options: [
            'Venus',
            'Mars',
            'Jupiter',
            'Saturn',
          ],
          correctAnswerIndex: 1,
          explanation: 'Mars is known as the Red Planet due to its reddish appearance.',
        ),
        Question(
          id: 'q3',
          text: 'Who painted the Mona Lisa?',
          options: [
            'Vincent van Gogh',
            'Pablo Picasso',
            'Leonardo da Vinci',
            'Michelangelo',
          ],
          correctAnswerIndex: 2,
          explanation: 'Leonardo da Vinci painted the Mona Lisa during the Renaissance.',
        ),
        Question(
          id: 'q4',
          text: 'How many continents are there?',
          options: [
            '5',
            '6',
            '7',
            '8',
          ],
          correctAnswerIndex: 2,
          explanation: 'There are 7 continents: Africa, Antarctica, Asia, Europe, North America, Oceania, and South America.',
        ),
        Question(
          id: 'q5',
          text: 'Which element has the chemical symbol "Au"?',
          options: [
            'Silver',
            'Gold',
            'Aluminum',
            'Argon',
          ],
          correctAnswerIndex: 1,
          explanation: 'Gold has the chemical symbol "Au" from its Latin name "aurum".',
        ),
      ],
    ),
    Quiz(
      id: '3',
      title: 'Programming Fundamentals',
      description: 'Test your programming knowledge',
      category: 'Technology',
      timePerQuestion: 30,
      questions: [
        Question(
          id: 'q1',
          text: 'What does OOP stand for?',
          options: [
            'Object-Oriented Programming',
            'Open Object Protocol',
            'Operational Output Processing',
            'Original Object Program',
          ],
          correctAnswerIndex: 0,
          explanation: 'OOP stands for Object-Oriented Programming.',
        ),
        Question(
          id: 'q2',
          text: 'Which of these is NOT a programming paradigm?',
          options: [
            'Functional',
            'Decorative',
            'Procedural',
            'Object-Oriented',
          ],
          correctAnswerIndex: 1,
          explanation: 'Decorative is not a programming paradigm. The main paradigms are Functional, Procedural, and Object-Oriented.',
        ),
        Question(
          id: 'q3',
          text: 'What is an API?',
          options: [
            'A type of programming language',
            'Application Programming Interface',
            'An advanced Python library',
            'A database system',
          ],
          correctAnswerIndex: 1,
          explanation: 'API stands for Application Programming Interface.',
        ),
        Question(
          id: 'q4',
          text: 'What does HTTP stand for?',
          options: [
            'Hypertext Transfer Protocol',
            'High Transfer Text Protocol',
            'Hypertext Transport Program',
            'High Technology Text Platform',
          ],
          correctAnswerIndex: 0,
          explanation: 'HTTP stands for Hypertext Transfer Protocol.',
        ),
        Question(
          id: 'q5',
          text: 'Which sorting algorithm has O(n log n) average time complexity?',
          options: [
            'Bubble Sort',
            'Insertion Sort',
            'Merge Sort',
            'Selection Sort',
          ],
          correctAnswerIndex: 2,
          explanation: 'Merge Sort has O(n log n) average time complexity.',
        ),
      ],
    ),
  ];

  static List<Quiz> getAllQuizzes() {
    return _quizzesDatabase;
  }

  static Quiz? getQuizById(String quizId) {
    try {
      return _quizzesDatabase.firstWhere((quiz) => quiz.id == quizId);
    } catch (e) {
      return null;
    }
  }

  static List<Quiz> getQuizzesByCategory(String category) {
    return _quizzesDatabase
        .where((quiz) => quiz.category == category)
        .toList();
  }

  static List<String> getAllCategories() {
    return _quizzesDatabase
        .map((quiz) => quiz.category)
        .toSet()
        .toList();
  }
}
