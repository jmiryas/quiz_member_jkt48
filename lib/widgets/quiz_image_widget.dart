import 'package:flutter/material.dart';

class QuizImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;

  const QuizImageWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * 0.75 * 0.36,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
