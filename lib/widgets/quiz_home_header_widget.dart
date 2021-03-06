import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/quiz_model.dart';
import '../models/quiz_binary_model.dart';

class QuizHomeHeaderWidget extends StatelessWidget {
  const QuizHomeHeaderWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.15,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/question.png"),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User-${randomAlphaNumeric(5)}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.trophy,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "${QuizModel.scores + QuizBinaryModel.scores}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          IconButton(
              onPressed: () {
                Alert(
                    context: context,
                    title: "About",
                    desc:
                        "Quiz member JKT48. Dibuat oleh Rizky Ramadhan. @jmiryas (IG). @dendengcrap (Twitter).",
                    buttons: [
                      DialogButton(
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ]).show();
              },
              icon: const Icon(Icons.info, color: Colors.white))
        ],
      ),
    );
  }
}
