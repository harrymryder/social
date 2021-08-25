import 'package:flutter/material.dart';

import 'popular_item.dart';

class Popular extends StatelessWidget {
  final List<Map> _popularItems = [
    {
      'title': 'Tokyo Sukiyaki Tei',
      'imageUrl':
          'https://www.tokyosukiyakitei.com/wp-content/uploads/2014/06/our-story-page.jpg',
      'openingTimes': '08:00 - 18:00',
      'distance': '2.4 mi',
    },
    {
      'title': 'Island Poke - Victoria',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIoso2nVumbA9eTeX2LhEbDoEUGXakRwoqAg&usqp=CAU',
      'openingTimes': '08:00 - 17:00',
      'distance': '2.09 mi',
    },
    {
      'title': 'EL&N - Lowndes Street',
      'imageUrl':
          'https://i.shgcdn.com/d273804d-bf72-4a05-a994-0668a7d18675/-/format/auto/-/preview/3000x3000/-/quality/lighter/',
      'openingTimes': '09:00 - 18:00',
      'distance': '2.5 mi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular near you',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _popularItems
                  .map((item) => Stack(
                        children: [
                          Image.network(
                            item['imageUrl'],
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
