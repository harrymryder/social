import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:social/widgets/food/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:social/widgets/food/category_items.dart';
import 'package:social/widgets/food/dietary_switch.dart';
import 'package:social/widgets/text/white_subtitle.dart';
import 'package:social/widgets/text/white_title.dart';

class Food extends StatefulWidget {
  final ScrollController scrollController;
  final Function callback;

  Food({
    @required this.scrollController,
    @required this.callback,
  });

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  void _toggleDraggableSheet() {
    widget.callback.call();
  }

  void _showDietaryOptions() {
    /// Close draggable sheet, show modal bottom sheet
    _toggleDraggableSheet();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            WhiteTitle(text: 'Dietary'),
            const SizedBox(height: 16),
            WhiteSubtitle(text: 'Only show items that are'),
            const SizedBox(height: 16),
            DietarySwitch(
              color: Colors.green,
              letter: 'V',
              text: 'Vegetarian',
              onSwitched: () {},
            ),
            DietarySwitch(
              color: Colors.red,
              letter: 'V+',
              text: 'Vegan',
              onSwitched: () {},
            ),
            DietarySwitch(
              color: Colors.yellow,
              letter: 'G',
              text: 'Gluten free',
              onSwitched: () {},
            ),
            DietarySwitch(
              color: Colors.blue,
              letter: 'LF',
              text: 'Lactose free',
              onSwitched: () {},
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _toggleDraggableSheet();
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.8,
      color: Colors.grey[800],
      child: CustomScrollView(
        controller: widget.scrollController,
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 172,
            primary: false,
            floating: false,
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
                      'Food',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CupertinoSearchTextField(
                      backgroundColor: Colors.grey[900],
                      itemColor: Colors.grey[500],
                      suffixIcon: Icon(Ionicons.ios_search),
                      itemSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 24.0,
                      maxHeight: 36.0,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 16),
                        CategoryItem(
                          onTap: _showDietaryOptions,
                          text: 'Dietary',
                          dietary: true,
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 8),
                        CategoryItems(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey[600]),
                  // const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.grey[800],
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
