import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Dates {
  String getDate() {
    return DateFormat('yyyy').format(DateTime.now());
  }
}

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AutoSizeText(
              "Soon Valley Transport",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 12.0),
            AutoSizeText(
              "App Version: ${_packageInfo.version}",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 18.0),
            Image.asset(
              "assets/ic_rate.png",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 18.0),
            AutoSizeText(
              "\u00a9 ${Dates().getDate()} Technical Wajahat",
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
