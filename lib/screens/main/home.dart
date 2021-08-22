import 'package:flutter/material.dart';
import 'package:social/widgets/home/karma_rewards.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../widgets/home/suggestions_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          KarmaRewards(),
          SuggestionsList(),
        ],
      ),
    );
  }
}
