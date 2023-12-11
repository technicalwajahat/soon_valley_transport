import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Services/location_permission_service.dart';

class BusLiveLocation extends StatefulWidget {
  const BusLiveLocation({Key? key}) : super(key: key);

  @override
  _BusLiveLocationState createState() => _BusLiveLocationState();
}

class _BusLiveLocationState extends State<BusLiveLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {}; //markers for google map

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  addMarkers() async {
    markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(double.parse(Get.arguments['lat']),
          double.parse(Get.arguments['long'])),
    ));
  }

  static final CameraPosition _kMap = CameraPosition(
      target: LatLng(double.parse(Get.arguments['lat']),
          double.parse(Get.arguments['long'])),
      zoom: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Live Location",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigation_rounded),
            tooltip: 'Share Location',
            onPressed: () {
              HandleLocations().openMap(double.parse(Get.arguments['lat']),
                  double.parse(Get.arguments['long']), context);
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        markers: markers,
        initialCameraPosition: _kMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
