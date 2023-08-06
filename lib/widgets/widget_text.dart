import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}

class SecondText extends StatelessWidget {
  final String text;
  const SecondText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
