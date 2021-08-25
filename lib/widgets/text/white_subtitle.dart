import 'package:flutter/material.dart';

class WhiteSubtitle extends StatelessWidget {
  final String text;

  WhiteSubtitle({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
