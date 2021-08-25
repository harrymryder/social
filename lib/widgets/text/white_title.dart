import 'package:flutter/material.dart';

class WhiteTitle extends StatelessWidget {
  final String text;

  WhiteTitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
