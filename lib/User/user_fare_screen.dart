import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:soon_valley_transport/User/user_ac_buses.dart';
import 'package:soon_valley_transport/User/user_non_ac_buses.dart';

class FareScreen extends StatefulWidget {
  const FareScreen({Key? key}) : super(key: key);

  @override
  _FareScreenState createState() => _FareScreenState();
}

class _FareScreenState extends State<FareScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            "Fare",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "AC", icon: Icon(Icons.directions_bus_filled_sharp)),
              Tab(text: "Non-AC", icon: Icon(Icons.bus_alert_sharp)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserAcBuses(),
            UserNonAcBuses(),
          ],
        ),
      ),
    );
  }
}
