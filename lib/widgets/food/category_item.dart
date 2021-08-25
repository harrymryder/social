import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CategoryItem extends StatefulWidget {
  final Function onTap;
  final String text;
  final bool dietary;

  CategoryItem({
    @required this.onTap,
    @required this.text,
    @required this.dietary,
  });

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        if (!widget.dietary) setState(() => _selected = !_selected);
        // if (!_selected) setState(() => _selected = true);
        // if (_selected) setState(() => _selected = false);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.circular(50),
          border: _selected ? Border.all(color: Colors.white) : null,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            if (_selected)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
            if (widget.dietary)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
