import 'package:flutter/material.dart';

import '../screens/question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: width,
      height: height,
      color: Colors.amber,
      child: Column(
        children: [
          Container(
            width: width,
            height: height * 0.15,
            color: Colors.blue,
            padding: const EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  children: const [
                    Text(
                      "User-xxx",
                      style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Score: 0",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: width,
            height: height * 0.75,
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QuestionScreen()));
                          },
                          child: const ListTile(
                            leading: Image(
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.cover,
                                image: AssetImage("images/quiz.png")),
                            title: Text("Pengetahuan Umum"),
                            subtitle:
                                Text("Pengetahuan umum mengenai member JKT48."),
                          ),
                        ),
                      ],
                    ),
                  )
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
