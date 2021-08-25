import 'package:flutter/material.dart';

class RestaurantSheet extends StatelessWidget {
  final ScrollController scrollController;

  RestaurantSheet({@required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: Container(
        height: height + 200,
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
              backgroundColor: Colors.transparent,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ],
              // flexibleSpace: Container(
              //   child: Text('hello'),
              // ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Colors.grey[800],
                  child: Column(
                    children: [
                      Container(height: 300, child: Text('Hello')),
                      Container(height: 300, child: Text('Hello')),
                      Container(height: 300, child: Text('Hello')),
                      Container(height: 300, child: Text('Hello')),
                      Container(height: 300, child: Text('Hello')),
                      Container(height: 300, child: Text('Hello')),
                      Text('Hello'),
                      Text('Hello'),
                      Text('Hello'),
                      Text('Hello'),
                    ],
                  ),
                ),
              ]),
            ),
          ],
          // child: Stack(
          //   children: [
          //     Container(
          //       color: Colors.grey[800],
          //       height: height * 0.85,
          //       child: Column(
          //         children: [
          // Text('Hello'),
          // Text('Hello'),
          // Text('Hello'),
          // Text('Hello'),
          // Text('Hello'),
          // Text('Hello'),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       color: Colors.transparent,
          //       height: 50,
          //       child: AppBar(
          //         title: Text("Sheet title"),
          //         automaticallyImplyLeading:
          //             false, //this prevents the appBar from having a close button (that button wouldn't work because of IgnorePointer)
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );

    //this section is your header
    // Container(
    //   color: Colors.transparent,
    //   height: 50,
    //   child: AppBar(
    //     title: Text("Sheet title"),
    //     automaticallyImplyLeading:
    //         false, //this prevents the appBar from having a close button (that button wouldn't work because of IgnorePointer)
    //   ),
    // ),);

    return SingleChildScrollView(
      controller: scrollController,
      physics: ClampingScrollPhysics(),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: Container(
          color: Colors.grey[800],
          height: height * 0.85,
          child: Column(
            children: [
              Text('Hello'),
              Text('Hello'),
              Text('Hello'),
              Text('Hello'),
              Text('Hello'),
              Text('Hello'),
            ],
          ),
        ),
      ),
    );
  }
}
