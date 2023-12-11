import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soon_valley_transport/Data/city_data.dart';
import 'package:soon_valley_transport/Model/city_model.dart';
import 'package:soon_valley_transport/Screens/settings_screen.dart';
import 'package:soon_valley_transport/Services/custom_icons_font.dart';
import 'package:soon_valley_transport/User/user_book_now.dart';
import 'package:soon_valley_transport/User/user_booking.dart';
import 'package:soon_valley_transport/User/user_dua.dart';
import 'package:soon_valley_transport/User/user_fare_screen.dart';
import 'package:soon_valley_transport/User/user_show_drivers.dart';
import 'package:soon_valley_transport/User/user_show_travel_agency.dart';
import 'package:soon_valley_transport/color_schemes.g.dart';

import '../Controllers/date_time_controller.dart';
import '../Controllers/search_city_controller.dart';
import '../Screens/about_screen.dart';
import '../Screens/profile_screen.dart';
import '../Widget/drawer_body_widget.dart';
import '../Widget/drawer_header_widget.dart';
import '../Widget/explore_cards_widget.dart';
import '../Widget/popular_tours_widget.dart';
import 'user_bus_tracker.dart';

class UserExplorer extends StatefulWidget {
  const UserExplorer({Key? key}) : super(key: key);

  @override
  State<UserExplorer> createState() => _UserExplorerState();
}

class _UserExplorerState extends State<UserExplorer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final CurrentCityController cityController = Get.put(CurrentCityController());

  List<CityModel> cities = [];

  @override
  void initState() {
    cities = getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu_open)),
        centerTitle: true,
        title: const AutoSizeText(
          "Soon Valley Transport",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/home_header.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Obx(() {
                      var day = DateFormat("EEEE")
                          .format(dateTimeController.now.value);
                      var time = DateFormat("hh:mm:ss")
                          .format(dateTimeController.now.value);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkColorScheme.onSurface,
                              fontSize: 26,
                            ),
                          ),
                          AutoSizeText(
                            time,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkColorScheme.onSurface,
                              fontSize: 26,
                            ),
                          ),
                        ],
                      );
                    }),
                    Obx(() {
                      var date = DateFormat("MMMM d, y")
                          .format(dateTimeController.now.value);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            date,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkColorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                          AutoSizeText(
                            cityController.city.isNotEmpty
                                ? cityController.city
                                : "Enable Location!",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkColorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            const AutoSizeText(
              "Explore Features",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Get.height * 0.02),
            GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                ExploreGrid(
                  title: "Bookings",
                  cardIcon: CustomIcons.bookings,
                  onTap: () {
                    Get.to(const UserBooking());
                  },
                ),
                ExploreGrid(
                  title: "Fare",
                  cardIcon: CustomIcons.farePrice,
                  onTap: () {
                    Get.to(const FareScreen());
                  },
                ),
                ExploreGrid(
                  title: "Drivers",
                  cardIcon: CustomIcons.driver,
                  onTap: () {
                    Get.to(const ShowDrivers());
                  },
                ),
                ExploreGrid(
                  title: "Travel Agencies",
                  cardIcon: Icons.directions_bus_filled_rounded,
                  onTap: () {
                    Get.to(const TravelAgency());
                  },
                ),
                ExploreGrid(
                  title: "Tracker",
                  cardIcon: CustomIcons.tracker,
                  onTap: () {
                    Get.to(const BusTracker());
                  },
                ),
                ExploreGrid(
                  title: "Dua",
                  cardIcon: CustomIcons.dua,
                  onTap: () {
                    Get.to(const DuaScreen());
                  },
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            const AutoSizeText(
              'Popular Tours',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Get.height * 0.02),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: cities.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CountryListTile(
                      cityName: cities[index].cityName!,
                      timeTaken: cities[index].timeTaken!,
                      imageUrl: cities[index].imgUrl!,
                      farePrice: cities[index].farePrice!,
                      totalKms: cities[index].totalKms!,
                    );
                  }),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DrawerHeaderWidget(),
                DrawerNavigationItem(
                  iconData: Icons.dashboard,
                  title: "Dashboard",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  selected: true,
                ),
                DrawerNavigationItem(
                  iconData: Icons.person,
                  title: "My Profile",
                  onTap: () {
                    Get.back();
                    Get.to(const Profile());
                  },
                  selected: false,
                ),
                DrawerNavigationItem(
                  iconData: Icons.settings,
                  title: "Settings",
                  onTap: () {
                    Get.back();
                    Get.to(const NewSetting());
                  },
                  selected: false,
                ),
                DrawerNavigationItem(
                  iconData: Icons.share,
                  title: "Share this App",
                  onTap: () async {
                    Navigator.pop(context);
                    const playStoreUrl =
                        "https://play.google.com/store/apps/details?id=com.google.android.googlequicksearchbox";
                    const appStoreUrl =
                        "https://apps.apple.com/us/app/google/id284815942";
                    await Share.share(
                        "Download Soon Valley Transport App\n\nAndroid:\n$playStoreUrl\n\niOS:\n$appStoreUrl");
                  },
                  selected: false,
                ),
                DrawerNavigationItem(
                  iconData: Icons.info,
                  title: "About",
                  onTap: () {
                    Get.back();
                    Get.to(const About());
                  },
                  selected: false,
                ),
                DrawerNavigationItem(
                  iconData: Icons.exit_to_app_rounded,
                  title: "Exit",
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  selected: false,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const UserBookNow());
        },
        child: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }
}
