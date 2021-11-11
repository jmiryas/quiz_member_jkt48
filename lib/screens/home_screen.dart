import 'package:flutter/material.dart';

import '../models/quiz_model.dart';
import '../screens/question_screen.dart';
import '../widgets/quiz_menu_widget.dart';
import '../widgets/quiz_home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          QuizHomeHeaderWidget(width: width, height: height),
          SizedBox(
            width: width,
            height: height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  QuizMenuWidget(
                      onTap: () {
                        QuizModel.resetQuiz();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionScreen()));
                      },
                      title: "Pengetahuan Umum",
                      description: "Pengetahuan umum mengenai member JKT48.",
                      image: "images/quiz.png"),
                  QuizMenuWidget(
                      onTap: () {
                        QuizModel.resetQuiz();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionScreen()));
                      },
                      title: "True atau False",
                      description:
                          "Menebak berbagai fakta mengenai member JKT48.",
                      image: "images/quiz2.png"),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.1,
            color: Colors.red,
          ),
        ],
      ),
    ));
  }
}
