import 'package:flutter/material.dart';

import 'screens/main/map_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: pink,
        primaryColor: pink,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      home: MapUI(),
    );
  }
}

MaterialColor pink = MaterialColor(0xFFFE83A7, color);
// MaterialColor black = MaterialColor(0xFF1A1B25, color);
// MaterialColor green = MaterialColor(0xFF12BA55, color);
// MaterialColor red = MaterialColor(0xFFCC285A, color);

Map<int, Color> color = {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};
