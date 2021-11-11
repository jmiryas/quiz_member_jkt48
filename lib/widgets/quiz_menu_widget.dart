import 'package:flutter/material.dart';

class QuizMenuWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String description;
  final String image;

  const QuizMenuWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Card(
          child: ListTile(
            leading: Image(
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
                image: AssetImage(image)),
            title: Text(title),
            subtitle: Text(description),
          ),
        ),
      ),
    );
  }
}
