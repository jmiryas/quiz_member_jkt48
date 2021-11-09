import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/quiz_model.dart';
import '../screens/home_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  _buildHealthWidget(int healts) {
    var results = [];

    for (int i = 0; i < healts; i++) {
      results.add(const Icon(
        Icons.favorite,
        color: Colors.red,
      ));
    }

    var allHealts = Row(
      children: [...results],
    );

    return allHealts;
  }

  bool isAnswerCorrect = false;
  int answerAttempt = 0;
  int selectedIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            width: width,
            height: height,
            // color: Colors.amber,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.15,
                  color: Colors.blue,
                  padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Score: ${QuizModel.scores}",
                        style: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                      _buildHealthWidget(QuizModel.healths)
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.75,
                  // color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.75 * 0.32,
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            QuizModel.getCurrentQuizModel().question,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height * 0.75 * 0.36,
                        color: Colors.blue,
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                QuizModel.getCurrentQuizModel().image),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height * 0.75 * 0.32,
                        // color: Colors.teal,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Wrap(
                            children: QuizModel.getCurrentQuizModel()
                                .choices
                                .asMap()
                                .entries
                                .map((item) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    answerAttempt += 1;
                                    selectedIndex = item.key;
                                    selectedAnswer = item.value;

                                    isAnswerCorrect = selectedAnswer ==
                                        QuizModel.getCurrentQuizModel()
                                            .correctAnswer;

                                    if (isAnswerCorrect) {
                                      QuizModel.scores += 1;
                                    }

                                    if (!isAnswerCorrect) {
                                      QuizModel.healths -= 1;
                                    }

                                    if (QuizModel.isPlayable() ||
                                        QuizModel.isGameOver()) {
                                      Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "Quiz telah selesai!",
                                        desc: "Skor: ${QuizModel.scores}",
                                        buttons: [
                                          DialogButton(
                                            child: const Text(
                                              "Home",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            onPressed: () {
                                              QuizModel.resetQuizWithoutScore();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const HomeScreen()));
                                            },
                                            width: 120,
                                          ),
                                          DialogButton(
                                            color: Colors.green,
                                            child: const Text(
                                              "Main Lagi",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            onPressed: () {
                                              QuizModel.resetQuiz();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const QuestionScreen()));
                                            },
                                            width: 120,
                                          )
                                        ],
                                      ).show();
                                    }

                                    if (isAnswerCorrect) {
                                      QuizModel.nextQuiz();
                                    }
                                  });
                                },
                                child: SizedBox(
                                  width: width / 2 - 20,
                                  height: (height * 0.75 * 0.32) / 2 - 20,
                                  child: answerAttempt > 0
                                      ? Card(
                                          child: Center(
                                            child: Text(item.value),
                                          ),
                                          shape: selectedIndex == item.key &&
                                                  selectedAnswer == item.value
                                              ? RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1.0,
                                                      color: isAnswerCorrect
                                                          ? Colors.green
                                                          : Colors.red))
                                              : const RoundedRectangleBorder())
                                      : Card(
                                          child: Center(
                                            child: Text(item.value),
                                          ),
                                          shape: const RoundedRectangleBorder(),
                                        ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.1,
                  color: Colors.red,
                ),
              ],
            )));
  }
}
