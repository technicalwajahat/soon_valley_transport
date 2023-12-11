import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HandleLocations {
  Future<void> openMap(
      double latitude, double longitude, BuildContext context) async {
    var googleUrl =
        Uri.parse("google.navigation:q=$latitude,$longitude&mode=d");
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AutoSizeText("Could not open the map!"),
        ),
      );
    }
  }

  Future<Position> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AutoSizeText("Location Service are Disabled!"),
        ),
      );
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AutoSizeText("Location Permission are Denied!"),
          ),
        );
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AutoSizeText("Location Permission are Permanently Denied!"),
        ),
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}
