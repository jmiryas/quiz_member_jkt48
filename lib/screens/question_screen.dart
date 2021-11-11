import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/quiz_model.dart';
import '../screens/home_screen.dart';
import '../widgets/quiz_image_widget.dart';
import '../widgets/quiz_question_widget.dart';
import '../widgets/quiz_score_header_widget.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isAnswerCorrect = false;
  int answerAttempt = 0;
  int selectedIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Alert(
          context: context,
          title: "Konfirmasi",
          desc: "Keluar dari permainan?",
          buttons: [
            DialogButton(
              child: const Text(
                "Ya",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                QuizModel.resetQuizWithoutScore();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
              width: 120,
            ),
            DialogButton(
              child: const Text(
                "Enggak",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  QuizScoreHeaderWidget(
                    width: width,
                    height: height,
                    scores: QuizModel.scores,
                    healths: QuizModel.healths,
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.75,
                    child: Column(
                      children: [
                        QuizQuestionWidget(
                          width: width,
                          height: height,
                          question: QuizModel.getCurrentQuizModel().question,
                        ),
                        QuizImageWidget(
                          width: width,
                          height: height,
                          image: QuizModel.getCurrentQuizModel().image,
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.75 * 0.32,
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

                                      if (isAnswerCorrect &&
                                              QuizModel.isQuizEnd() ||
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
                                                QuizModel
                                                    .resetQuizWithoutScore();

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
                                        final player = AudioCache();
                                        player.play("correct.mp3");

                                        QuizModel.nextQuiz();
                                      } else {
                                        final player = AudioCache();
                                        player.play("wrong.mp3");
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
                                            shape:
                                                const RoundedRectangleBorder(),
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
              ))),
    );
  }
}
