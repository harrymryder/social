import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DietarySwitch extends StatefulWidget {
  final Color color;
  final String letter;
  final String text;
  final Function onSwitched;

  DietarySwitch({
    @required this.color,
    @required this.letter,
    @required this.text,
    @required this.onSwitched,
  });

  @override
  _DietarySwitchState createState() => _DietarySwitchState();
}

class _DietarySwitchState extends State<DietarySwitch> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.letter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        CupertinoSwitch(
          value: _selected,
          onChanged: (value) {
            setState(() => _selected = !_selected);
          },
        ),
      ],
    );
  }
}
