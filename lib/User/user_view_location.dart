import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../Services/location_permission_service.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({Key? key}) : super(key: key);

  @override
  State<ViewLocation> createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;

  static const CameraPosition _kMap = CameraPosition(
      target: LatLng(32.568470218444176, 72.15302640757947), zoom: 14);

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.568470218444176, 72.15302640757947),
        infoWindow: InfoWindow(title: "Naushera, Soon Valley"))
  ];

  @override
  void initState() {
    HandleLocations().getCurrentLocation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                HandleLocations()
                    .openMap(32.568470218444176, 72.15302640757947, context),
            icon: const Icon(Icons.navigation_rounded)),
        centerTitle: true,
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Location",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share_location),
            tooltip: 'Share Location',
            onPressed: () {
              HandleLocations().getCurrentLocation(context).then((value) =>
                  Share.share(
                      'https://www.google.com/maps/search/?api=1&query=${_currentPosition
                          ?.latitude ?? ""},${_currentPosition?.longitude ??
                          ""}'));
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _kMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
