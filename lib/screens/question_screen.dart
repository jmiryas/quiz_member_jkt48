import 'package:flutter/material.dart';
import 'package:quiz_member_jkt48/models/quiz_model.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Score: 0",
                      style: TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.75,
                color: Colors.green,
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
                        margin: const EdgeInsets.all(20.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image:
                              AssetImage(QuizModel.getCurrentQuizModel().image),
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.75 * 0.32,
                      color: Colors.teal,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Wrap(
                          children: [
                            SizedBox(
                              width: width / 2 - 20,
                              height: (height * 0.75 * 0.32) / 2 - 20,
                              child: Card(
                                child: Center(
                                  child: Text(QuizModel.getCurrentQuizModel()
                                      .choices[0]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 2 - 20,
                              height: (height * 0.75 * 0.32) / 2 - 20,
                              child: Card(
                                child: Center(
                                  child: Text(QuizModel.getCurrentQuizModel()
                                      .choices[0]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 2 - 20,
                              height: (height * 0.75 * 0.32) / 2 - 20,
                              child: Card(
                                child: Center(
                                  child: Text(QuizModel.getCurrentQuizModel()
                                      .choices[0]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width / 2 - 20,
                              height: (height * 0.75 * 0.32) / 2 - 20,
                              child: Card(
                                child: Center(
                                  child: Text(QuizModel.getCurrentQuizModel()
                                      .choices[0]),
                                ),
                              ),
                            ),
                          ],
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
          )),
    );
  }
}
