import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class QuizBinaryModel {
  final String id = uuid.v1();
  late final String question;
  late final String image;
  late final List<bool> choices;
  late final bool correctAnswer;

  QuizBinaryModel({
    required this.question,
    required this.image,
    required this.choices,
    required this.correctAnswer,
  });

  static int currentIndex = 0;
  static int healths = 3;
  static int scores = 0;

  static List<QuizBinaryModel> quizRepository = [
    QuizBinaryModel(
        question:
            "Yupi adalah member generasi 2 yang berhasil memperoleh peringkat pertama di SSK JKT48.",
        image: "images/quiz_binary_1.jpg",
        choices: [true, false],
        correctAnswer: true),
    QuizBinaryModel(
        question: "Durasi Fiony selama masa Academy A adalah 6 bulan 2 hari.",
        image: "images/quiz_binary_2.jpg",
        choices: [true, false],
        correctAnswer: false),
    QuizBinaryModel(
        question: "Gaby adalah member JKT48 dengan durasi paling lama.",
        image: "images/quiz_binary_3.jpg",
        choices: [true, false],
        correctAnswer: true),
    QuizBinaryModel(
        question: "Fiony mengambil mainan bebek saat menginap di hotel.",
        image: "images/quiz_binary_4.jpg",
        choices: [true, false],
        correctAnswer: true),
    QuizBinaryModel(
        question: "Asha adalah nama panggilan Ashel yang resmi.",
        image: "images/quiz_binary_5.jpg",
        choices: [true, false],
        correctAnswer: false),
  ];

  static QuizBinaryModel getCurrentQuizModel() {
    return quizRepository[currentIndex];
  }

  static void nextQuiz() {
    if (currentIndex < quizRepository.length - 1) {
      currentIndex++;
    }
  }

  static void resetQuiz() {
    currentIndex = 0;
    healths = 3;
    scores = 0;
  }

  static void resetQuizWithoutScore() {
    currentIndex = 0;
    healths = 3;
  }

  static bool isQuizEnd() {
    return currentIndex == quizRepository.length - 1;
  }

  static bool isGameOver() {
    return !(healths > 0);
  }
}
