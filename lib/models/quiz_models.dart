class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String? explanation;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      text: json['text'] as String,
      options: List<String>.from(json['options'] as List),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final String category;
  final List<Question> questions;
  final int timePerQuestion; // in seconds

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.questions,
    required this.timePerQuestion,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList(),
      timePerQuestion: json['timePerQuestion'] as int? ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timePerQuestion': timePerQuestion,
    };
  }
}

class QuizResult {
  final String quizId;
  final String quizTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final DateTime completedAt;
  final List<int> selectedAnswers;
  final int timeTaken; // in seconds

  QuizResult({
    required this.quizId,
    required this.quizTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.completedAt,
    required this.selectedAnswers,
    required this.timeTaken,
  });

  double get percentage {
    return (correctAnswers / totalQuestions) * 100;
  }

  String get grade {
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      quizId: json['quizId'] as String,
      quizTitle: json['quizTitle'] as String,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
      selectedAnswers: List<int>.from(json['selectedAnswers'] as List),
      timeTaken: json['timeTaken'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'completedAt': completedAt.toIso8601String(),
      'selectedAnswers': selectedAnswers,
      'timeTaken': timeTaken,
    };
  }
}
