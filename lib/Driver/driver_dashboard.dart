import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Driver/driver_share_location.dart';
import 'package:soon_valley_transport/Screens/about_screen.dart';
import 'package:soon_valley_transport/Screens/profile_screen.dart';
import 'package:soon_valley_transport/Screens/settings_screen.dart';

class DriverDashboard extends StatefulWidget {
  final String? driverName;

  const DriverDashboard(this.driverName, {Key? key}) : super(key: key);

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Soon Valley Transport",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                    "Welcome!",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                  AutoSizeText(
                    widget.driverName.toString(),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(3.0),
                children: <Widget>[
                  makeDashboardItem(
                    title: "Profile",
                    icon: Icons.account_circle,
                    onTap: () {
                      Get.to(const Profile());
                    },
                  ),
                  makeDashboardItem(
                    title: "Location",
                    icon: Icons.map_rounded,
                    onTap: () {
                      Get.to(ShareLocation(widget.driverName));
                    },
                  ),
                  makeDashboardItem(
                    title: "Settings",
                    icon: Icons.settings,
                    onTap: () {
                      Get.to(const NewSetting());
                    },
                  ),
                  makeDashboardItem(
                    title: "App Info",
                    icon: Icons.info,
                    onTap: () {
                      Get.to(const About());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Card makeDashboardItem({
  required String title,
  required IconData icon,
  required Function() onTap,
}) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(8),
    child: InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 48.0,
          ),
          SizedBox(height: Get.height * 0.02),
          AutoSizeText(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
