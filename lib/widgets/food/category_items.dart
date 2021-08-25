import 'package:flutter/material.dart';

import './category_item.dart';

class CategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryItem(
          onTap: () {},
          text: 'Meals',
          dietary: false,
        ),
        CategoryItem(
          onTap: () {},
          text: 'Pastries',
          dietary: false,
        ),
        CategoryItem(
          onTap: () {},
          text: 'Snacks',
          dietary: false,
        ),
        CategoryItem(
          onTap: () {},
          text: 'Bread',
          dietary: false,
        ),
        CategoryItem(
          onTap: () {},
          text: 'Groceries',
          dietary: false,
        ),
        CategoryItem(
          onTap: () {},
          text: 'Drinks',
          dietary: false,
        ),
      ],
    );
  }
}
