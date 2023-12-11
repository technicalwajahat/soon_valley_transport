import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Data/user_preferences.dart';
import 'Screens/home_screen.dart';
import 'Screens/onboarding_screen.dart';
import 'Services/location_permission_service.dart';
import 'Theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  await Settings.init(cacheProvider: SharePreferenceCache());

  FlutterNativeSplash();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  final pre = await SharedPreferences.getInstance();
  final showHome = pre.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

// MyApp class
class MyApp extends StatefulWidget {
  final bool showHome;

  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    HandleLocations().getCurrentLocation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme ? dark : light,
            darkTheme: notifier.darkTheme ? dark : light,
            home: widget.showHome ? const Home() : const OnBoarding(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
