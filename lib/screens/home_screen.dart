import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ads/ad_state.dart';
import '../models/quiz_model.dart';
import '../screens/question_screen.dart';
import '../widgets/quiz_menu_widget.dart';
import '../models/quiz_binary_model.dart';
import '../screens/quiz_binary_screen.dart';
import '../widgets/quiz_home_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? bannerAd;

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

    return Scaffold(
        body: SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          QuizHomeHeaderWidget(width: width, height: height),
          Container(
            width: width,
            height: height * 0.75,
            color: Colors.grey.shade800,
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
                            builder: (context) => const QuestionScreen(),
                          ),
                        );
                      },
                      title: "Pengetahuan Umum",
                      description: "Pengetahuan umum mengenai member JKT48.",
                      image: "images/quiz.png"),
                  QuizMenuWidget(
                      onTap: () {
                        QuizBinaryModel.resetQuiz();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizBinaryScreen(),
                          ),
                        );
                      },
                      title: "True atau False",
                      description:
                          "Menebak berbagai fakta mengenai member JKT48.",
                      image: "images/quiz2.png"),
                ],
              ),
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
    ));
  }
}
