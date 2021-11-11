import 'package:flutter/material.dart';

class QuizScoreHeaderWidget extends StatelessWidget {
  final double width;
  final double height;
  final int scores;
  final int healths;

  const QuizScoreHeaderWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.scores,
    required this.healths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildHealthWidget(int healts) {
      var results = [];

      for (int i = 0; i < healts; i++) {
        results.add(const Icon(
          Icons.favorite,
          color: Colors.white,
        ));
      }

      var allHealts = Row(
        children: [...results],
      );

      return allHealts;
    }

    return Container(
      width: width,
      height: height * 0.15,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Score: $scores",
            style: const TextStyle(
              fontSize: 16.0,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          _buildHealthWidget(healths)
        ],
      ),
    );
  }
}
