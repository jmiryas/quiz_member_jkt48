import 'package:flutter/material.dart';

class QuizQuestionWidget extends StatelessWidget {
  final double width;
  final double height;
  final String question;

  const QuizQuestionWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.75 * 0.32,
      color: Colors.amber,
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Center(
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
