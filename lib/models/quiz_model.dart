import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class QuizModel {
  final String id = uuid.v1();
  late final String question;
  late final String image;
  late final List<String> choices;
  late final String correctAnswer;

  QuizModel({
    required this.question,
    required this.image,
    required this.choices,
    required this.correctAnswer,
  });

  static int currentIndex = 0;
  static int healths = 3;
  static int scores = 0;

  static List<QuizModel> quizRepository = [
    QuizModel(
        question:
            "Siapakah member yang berpikir kalau JKT48 adalah pekerjaan sukarela?",
        image: "images/quiz_image_1.jpg",
        choices: ["Fiony", "Gracia", "Shani", "Celine"],
        correctAnswer: "Fiony"),
    QuizModel(
        question: "Berapakah draft Tiktok milik Gracia?",
        image: "images/quiz_image_2.jpg",
        choices: ["500++", "1000++", "2000++", "2500++"],
        correctAnswer: "2500++"),
    QuizModel(
        question: "Oniel merupakan member dari generasi ke-?",
        image: "images/quiz_image_3.jpg",
        choices: ["3", "6", "8", "5"],
        correctAnswer: "8"),
    QuizModel(
        question: "Pada bulan apa Fiony memesan paketnya?",
        image: "images/quiz_image_4.jpg",
        choices: ["Agustus", "November", "Januari", "Februari"],
        correctAnswer: "Januari"),
    QuizModel(
        question: "Siapakah kapten pertama Team K3?",
        image: "images/quiz_image_5.jpg",
        choices: ["Yona", "Vienny", "Sisca", "Naomi"],
        correctAnswer: "Naomi"),
  ];

  static QuizModel getCurrentQuizModel() {
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
