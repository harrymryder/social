import 'package:flutter/material.dart';

class KarmaRewards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF3B8CE),
            Color(0xFFC0ECEF),
            Color(0xFFE3EFBC),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'With Karma Rewards, purchase = prices. So when you do your bit for the planet, you\'ll be rewarded',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
