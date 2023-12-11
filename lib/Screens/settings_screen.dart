import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soon_valley_transport/Screens/login_screen.dart';
import 'package:soon_valley_transport/color_schemes.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Theme/theme.dart';
import 'forget_password_screen.dart';

class NewSetting extends StatefulWidget {
  const NewSetting({Key? key}) : super(key: key);

  @override
  State<NewSetting> createState() => _SettingState();
}

class _SettingState extends State<NewSetting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(18.0),
          children: [
            SettingsGroup(title: "General", children: <Widget>[
              const SizedBox(height: 12.0),
              buildLocation(),
              const SizedBox(height: 4.0),
              buildLanguage(),
              const SizedBox(height: 4.0),
              buildDarkMode(),
            ]),
            const SizedBox(height: 12.0),
            SettingsGroup(title: "Account Management", children: <Widget>[
              const SizedBox(height: 12.0),
              buildPassword(),
              const SizedBox(height: 4.0),
              buildLogout(),
            ]),
            const SizedBox(height: 12.0),
            SettingsGroup(title: "Feedback", children: <Widget>[
              const SizedBox(height: 12.0),
              buildFeedback(context),
              const SizedBox(height: 4.0),
              buildReport(context),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildPassword() {
    return ListTile(
      title: const AutoSizeText("Change Password"),
      leading: const Icon(Icons.key),
      onTap: () {
        Get.to(const ForgetPassword());
      },
    );
  }

  Widget buildLogout() {
    return ListTile(
      title: const AutoSizeText("Logout"),
      leading: const Icon(Icons.logout),
      onTap: () {
        resetPreferences();
        _auth.signOut();
        Get.offAll(const Login());
        // Phoenix.rebirth(context);
      },
    );
  }

  Widget buildDarkMode() {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => SwitchListTile(
        title: const AutoSizeText("Dark Mode"),
        activeColor: lightColorScheme.onPrimary,
        secondary: const Icon(Icons.dark_mode),
        value: notifier.darkTheme,
        onChanged: (val) {
          setState(() {
            notifier.toggleTheme();
          });
        },
      ),
    );
  }

  Widget buildLocation() {
    return const ListTile(
      leading: Icon(Icons.location_pin),
      title: AutoSizeText("Location"),
      subtitle: AutoSizeText("Pakistan (Default)"),
    );
  }

  Widget buildLanguage() {
    return const ListTile(
      leading: Icon(Icons.language),
      title: AutoSizeText("App Language"),
      subtitle: AutoSizeText("English (Default)"),
    );
  }

  Widget buildFeedback(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.star_rate),
      title: const AutoSizeText("Rate this App"),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => _dialog,
        );
      },
    );
  }

  Widget buildReport(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bug_report),
      title: const AutoSizeText("Report a Bug"),
      onTap: () {
        launchUrl(Uri(
          scheme: 'mailto',
          path: 'wajahat.awan.924@gmail.com',
        ));
      },
    );
  }

  final _dialog = RatingDialog(
    starSize: 30.0,
    title: const Text(
      'Soon Valley Transport',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    message: const Text(
      'Tap a star to set your rating.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    ),
    // your app's logo?
    image: Image.asset(
      'assets/ic_rate.png',
      height: 100,
      width: 100,
    ),
    submitButtonText: 'Submit',
    onSubmitted: (dialog) {
      LaunchReview.launch(
          androidAppId: "com.google.android.googlequicksearchbox",
          iOSAppId: "284815942");
    },
  );

  void resetPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("theme");
    preferences.remove("user");
  }
}
