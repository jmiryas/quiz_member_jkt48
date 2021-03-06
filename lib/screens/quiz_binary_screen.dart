import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ads/ad_state.dart';
import '../screens/home_screen.dart';
import '../models/quiz_binary_model.dart';
import '../widgets/quiz_image_widget.dart';
import '../widgets/quiz_question_widget.dart';
import '../widgets/quiz_score_header_widget.dart';

class QuizBinaryScreen extends StatefulWidget {
  const QuizBinaryScreen({Key? key}) : super(key: key);

  @override
  State<QuizBinaryScreen> createState() => _QuizBinaryScreenState();
}

class _QuizBinaryScreenState extends State<QuizBinaryScreen> {
  int answerAttempt = 0;
  int selectedIndex = 0;
  bool isAnswered = false;
  bool selectedAnswer = false;
  bool isAnswerCorrect = false;

  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    QuizBinaryModel.quizRepository.shuffle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdUnitId,
          listener: adState.adListener,
          request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _displayAlert() {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Quiz telah selesai!",
        desc: "Skor: ${QuizBinaryModel.scores}",
        buttons: [
          DialogButton(
            child: const Text(
              "Home",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              QuizBinaryModel.resetQuizWithoutScore();

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
            color: Colors.green,
            child: const Text(
              "Main Lagi",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              QuizBinaryModel.resetQuiz();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuizBinaryScreen(),
                ),
              );
            },
            width: 120,
          )
        ],
      ).show();
    }

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
                QuizBinaryModel.resetQuizWithoutScore();

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
                scores: QuizBinaryModel.scores,
                healths: QuizBinaryModel.healths,
              ),
              SizedBox(
                width: width,
                height: height * 0.75,
                child: Column(
                  children: [
                    QuizQuestionWidget(
                      width: width,
                      height: height,
                      question: QuizBinaryModel.getCurrentQuizModel().question,
                    ),
                    QuizImageWidget(
                      width: width,
                      height: height,
                      image: QuizBinaryModel.getCurrentQuizModel().image,
                    ),
                    SizedBox(
                      width: width,
                      height: height * 0.75 * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Wrap(
                          children: QuizBinaryModel.getCurrentQuizModel()
                              .choices
                              .asMap()
                              .entries
                              .map((item) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAnswered = true;

                                  selectedIndex = item.key;
                                  selectedAnswer = item.value;

                                  isAnswerCorrect = selectedAnswer ==
                                      QuizBinaryModel.getCurrentQuizModel()
                                          .correctAnswer;

                                  if (isAnswerCorrect) {
                                    final player = AudioCache();
                                    player.play("correct.mp3");

                                    QuizBinaryModel.scores += 1;
                                  } else {
                                    final player = AudioCache();
                                    player.play("wrong.mp3");
                                  }

                                  if (!isAnswerCorrect) {
                                    QuizBinaryModel.healths -= 1;
                                  }

                                  if (isAnswered &&
                                      QuizBinaryModel.isQuizEnd()) {
                                    _displayAlert();
                                  }

                                  if (isAnswerCorrect &&
                                          QuizBinaryModel.isQuizEnd() ||
                                      QuizBinaryModel.isGameOver()) {
                                    _displayAlert();
                                  }

                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      isAnswered = false;

                                      QuizBinaryModel.nextQuiz();
                                    });
                                  });
                                });
                              },
                              child: SizedBox(
                                width: width / 2 - 20,
                                height: (height * 0.75 * 0.32) / 2 - 20,
                                child: isAnswered
                                    ? Card(
                                        child: Center(
                                          child: Text(
                                              item.value ? "Benar" : "Salah"),
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
                                          child: Text(
                                              item.value ? "Benar" : "Salah"),
                                        ),
                                      ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bannerAd == null
                  ? Container(
                      width: width,
                      height: height * 0.1,
                      color: Colors.grey.shade700,
                    )
                  : Container(
                      width: width,
                      height: height * 0.1,
                      color: Colors.transparent,
                      child: AdWidget(ad: bannerAd!),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
