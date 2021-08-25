import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';

import 'home.dart';
import 'food.dart';
import 'following.dart';
import '../../widgets/buttons/rounded_icon_button.dart';
import '../../widgets/restaurants/restaurant_sheet.dart';

class MapUI extends StatefulWidget {
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 1;
  String _mapStyle;
  BitmapDescriptor customIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  double _initialExtent = 0.14;
  double _minExtent = 0.14;
  double _dragExtent = 0.14;
  bool _isExpanded = true;
  double _widgetHeight = 0;
  double _fabPosition = 0;
  double _fabPositionPadding = 8;
  bool _showRestaurantSheet = false;

  final List<String> _titles = [
    'Food',
    'Home',
    'Following',
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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.5015489, -0.0932891),
    zoom: 14.4746,
  );

  void _setMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        // size: Size(1, 1),
        devicePixelRatio: 0.25,
      ),
      'assets/stjohnbakery.png',
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
        // render the floating button
        _fabPosition = _initialExtent * context.size.height;
        _dragExtent = _initialExtent;
      });
    });

    _setMarker();

    super.initState();
  }

  void _changeTab(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _currentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = Location();
    location.requestService();
    location.requestPermission();

    _serviceEnabled = await location.serviceEnabled();

    // print(location);
    final _currentPosition = await location.getLocation();
    // print('Current location...');
    print(_currentPosition.longitude);
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition. ));
  }

  void _toggleDraggableSheet() {
    _initialExtent = !_isExpanded ? _minExtent : _dragExtent;
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleRestaurantSheet() {
    setState(() {
      _showRestaurantSheet = !_showRestaurantSheet;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
        unselectedItemColor: Colors.grey[400],
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

              setState(() {
                _markers.add(
                  Marker(
                    markerId: MarkerId("marker_1"),
                    position: LatLng(51.5015489, -0.0932891),
                    icon: customIcon,
                    consumeTapEvents: true,
                    onTap: () {
                      _toggleRestaurantSheet();
                    },
                  ),
                );
              });
            },
            markers: _markers,
          ),
          if (_currentIndex == 1 && !_showRestaurantSheet)
            Positioned(
              bottom: _fabPosition + _fabPositionPadding,
              right: _fabPositionPadding,
              child: FloatingActionButton(
                onPressed: _currentLocation,
                backgroundColor: Theme.of(context).primaryColor,
                mini: true,
                child: Icon(
                  Feather.navigation,
                  size: 16,
                ),
              ),
            ),
          _showRestaurantSheet
              ? DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  maxChildSize: 0.85,
                  minChildSize: 0.14,
                  key: Key(_initialExtent.toString()),
                  builder: (context, scrollController) =>
                      RestaurantSheet(scrollController: scrollController),
                )
              : NotificationListener<DraggableScrollableNotification>(
                  onNotification:
                      (DraggableScrollableNotification notification) {
                    setState(() {
                      _widgetHeight = context.size.height;
                      _dragExtent = notification.extent;

                      // Calculate FAB position based on parent widget height and DraggableScrollable position
                      _fabPosition = _dragExtent * (_widgetHeight * 0.9);
                    });
                    return;
                  },
                  child: DraggableScrollableActuator(
                    child: DraggableScrollableSheet(
                      initialChildSize: _dragExtent,
                      maxChildSize: 0.85,
                      minChildSize: 0.14,
                      key: Key(_initialExtent.toString()),
                      builder: (context, scrollController) => ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: IndexedStack(
                          index: _currentIndex,
                          children: [
                            Food(
                                scrollController: scrollController,
                                callback: () {
                                  _toggleDraggableSheet();
                                }),
                            Home(scrollController: scrollController),
                            Following(scrollController: scrollController),
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
