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

  static List<QuizModel> quizRepository = [
    QuizModel(
        question: "1 + 1 = ?",
        image: "images/gambar.jpg",
        choices: ["1", "2", "3", "4"],
        correctAnswer: "2"),
    QuizModel(
        question: "Mendoan berasal dari daerah?",
        image: "images/gambar.jpg",
        choices: ["Banyumas", "Ambarawa", "Jakarta", "Bali"],
        correctAnswer: "Banyumas"),
    QuizModel(
        question: "Berapa jumlah sila pada Pancasila?",
        image: "images/gambar.jpg",
        choices: ["3", "6", "8", "5"],
        correctAnswer: "5"),
  ];

  static QuizModel getCurrentQuizModel() {
    return quizRepository[currentIndex];
  }

  static void nextQuiz() {
    if (currentIndex < quizRepository.length) {
      currentIndex++;
    }
  }

  static int healths = 3;

  static int scores = 100;
}
