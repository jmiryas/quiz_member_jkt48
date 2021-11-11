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
        question: "1 + 1 = ?",
        image: "images/gambar.jpg",
        choices: [true, false],
        correctAnswer: true),
    QuizBinaryModel(
        question: "Mendoan berasal dari daerah Sumbawa.",
        image: "images/gambar2.jpg",
        choices: [true, false],
        correctAnswer: false),
    QuizBinaryModel(
        question: "Pancasila terdiri dari 5 sila.",
        image: "images/gambar3.jpg",
        choices: [true, false],
        correctAnswer: true),
  ];
}
