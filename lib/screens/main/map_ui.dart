import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:social/widgets/buttons/rounded_icon_button.dart';

import 'home.dart';
import 'food.dart';
import 'following.dart';

class MapUI extends StatefulWidget {
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 1;
  String _mapStyle;
  BitmapDescriptor customIcon;

  double _initialSheetChildSize = 0.12;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  double _fabPositionPadding = 8;

  List<Widget> _sheets = [
    Food(),
    Home(),
    Following(),
  ];

  final List<BottomNavigationBarItem> _tabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      // label: 'Food',
      title: Text('Food'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      // label: 'Home',
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Octicons.heart),
      // label: 'Following',
      title: Text('Following'),
    ),
  ];

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.48884955183822, -0.14361131274553324),
    zoom: 14.4746,
  );

  void setMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(2, 2),
        // devicePixelRatio: 2,
      ),
      'assets/pin.png',
    ).then((d) {
      customIcon = d;
    });
  }

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // render the floating button on widget
        _fabPosition = _initialSheetChildSize * context.size.height;
      });
    });

    setMarker();

    super.initState();
  }

  void _changeTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final Set<Marker> _markers = [
      Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(51.48884955183822, -0.14361131274553324),
        icon: customIcon,
      ),
    ].toSet();

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedIconButton(
                onTap: () {},
                icon: Feather.list,
              ),
              RoundedIconButton(
                onTap: () {},
                icon: Feather.shopping_cart,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs,
        backgroundColor: Colors.grey[800],
        currentIndex: _currentIndex,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[400],
        ),
        onTap: (index) {
          _changeTab(index);
        },
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
            },
            markers: _markers,
          ),
          if (_currentIndex == 1)
            Positioned(
              bottom: _fabPosition + _fabPositionPadding,
              right: _fabPositionPadding,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
                child: Icon(
                  Feather.navigation,
                  size: 16,
                ),
              ),
            ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              setState(() {
                _widgetHeight = context.size.height;
                _dragScrollSheetExtent = notification.extent;

                // Calculate FAB position based on parent widget height and DraggableScrollable position
                _fabPosition = _dragScrollSheetExtent * (_widgetHeight * 0.9);
              });
              return;
            },
            child: DraggableScrollableSheet(
              initialChildSize: _initialSheetChildSize,
              maxChildSize: 0.8,
              minChildSize: 0.12,
              builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                physics: ClampingScrollPhysics(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Column(
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
                      _sheets[_currentIndex],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
