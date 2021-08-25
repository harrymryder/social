import 'package:flutter/material.dart';

class Following extends StatelessWidget {
  final ScrollController scrollController;

  Following({@required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.8,
      color: Colors.grey[800],
      child: CustomScrollView(
        controller: scrollController,
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            primary: false,
            floating: true,
            pinned: true,
            elevation: 0,
            flexibleSpace: Container(
              color: Colors.grey[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Divider(
                    thickness: 2,
                    color: Colors.grey[700],
                    endIndent: width / 2.3,
                    indent: width / 2.3,
                    height: 0,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.grey[800],
                child: Column(
                  children: [
                    // KarmaRewards(),
                    // SuggestionsList(),
                    // Popular(),
                    // Popular(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
