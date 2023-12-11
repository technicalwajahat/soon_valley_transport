import 'package:flutter/material.dart';
import 'package:soon_valley_transport/User/user_explorer.dart';
import 'package:soon_valley_transport/User/user_view_location.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child: NavigationBar(
          height: 75,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.explore),
                icon: Icon(Icons.explore_outlined),
                label: "Explore"),
            // NavigationDestination(
            //     selectedIcon: Icon(Icons.directions_bus_filled_rounded),
            //     icon: Icon(Icons.directions_bus_filled_outlined),
            //     label: "Buses"),
            NavigationDestination(
                selectedIcon: Icon(Icons.location_on),
                icon: Icon(Icons.location_on_outlined),
                label: "Location"),
          ],
        ),
      ),
      body: <Widget>[
        const UserExplorer(),
        // const ViewBuses(),
        const ViewLocation(),
      ][currentPageIndex],
    );
  }
}
