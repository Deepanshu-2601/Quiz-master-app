import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Quiz Master';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Master quizzes across multiple categories';

  // Colors
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color secondaryColor = Color(0xFF424242);
  static const Color accentColor = Color(0xFFFFB74D);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);

  // Spacing
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;

  // Text Sizes
  static const double textSizeSmall = 12.0;
  static const double textSizeMedium = 14.0;
  static const double textSizeLarge = 16.0;
  static const double textSizeXLarge = 18.0;
  static const double textSizeTitle = 24.0;
  static const double textSizeHeading = 28.0;

  // Quiz Configuration
  static const int defaultTimePerQuestion = 30; // seconds
  static const int minQuestionsPerQuiz = 1;
  static const int maxQuestionsPerQuiz = 50;

  // Grading Thresholds
  static const double gradeAThreshold = 80.0;
  static const double gradeBThreshold = 70.0;
  static const double gradeCThreshold = 60.0;
  static const double gradeDThreshold = 50.0;

  // Animation Durations
  static const Duration quickAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // API/Storage Keys
  static const String quizResultsKey = 'quiz_results';
  static const String userPreferencesKey = 'user_preferences';
  static const String lastQuizIdKey = 'last_quiz_id';
  static const String userStatsKey = 'user_stats';

  // Regular Expressions
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Messages
  static const String noResultsMessage = 'No results found';
  static const String noQuizzesMessage = 'No quizzes available';
  static const String errorLoadingQuizzes = 'Error loading quizzes';
  static const String quizSubmittedSuccess = 'Quiz submitted successfully!';
  static const String quizSavedDraft = 'Quiz saved as draft';

  // Device Size Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;

  // URLs (Update as needed)
  static const String privacyPolicyUrl =
      'https://example.com/privacy-policy';
  static const String termsOfServiceUrl = 'https://example.com/terms';
  static const String contactUsUrl = 'https://example.com/contact';
}

class GradeConfig {
  static String getGrade(double percentage) {
    if (percentage >= AppConstants.gradeAThreshold) return 'A';
    if (percentage >= AppConstants.gradeBThreshold) return 'B';
    if (percentage >= AppConstants.gradeCThreshold) return 'C';
    if (percentage >= AppConstants.gradeDThreshold) return 'D';
    return 'F';
  }

  static Color getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return const Color(0xFF4CAF50); // Green
      case 'B':
        return const Color(0xFF2196F3); // Blue
      case 'C':
        return const Color(0xFFFFC107); // Amber
      case 'D':
        return const Color(0xFFFF9800); // Orange
      default:
        return const Color(0xFFF44336); // Red
    }
  }

  static String getGradeMessage(String grade) {
    switch (grade) {
      case 'A':
        return 'Excellent! Keep it up!';
      case 'B':
        return 'Great job! Very good!';
      case 'C':
        return 'Good effort! Practice more!';
      case 'D':
        return 'Needs improvement! Try again!';
      default:
        return 'Keep learning! You will improve!';
    }
  }
}
