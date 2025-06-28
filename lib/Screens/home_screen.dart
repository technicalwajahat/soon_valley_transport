import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soon_valley_transport/Driver/driver_dashboard.dart';

import '../Model/user_model.dart';
import '../Services/notification_services.dart';
import '../User/user_dashboard.dart';
import 'login_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  String? userRole;
  String? userFullName;

  // getConnectivity() =>
  //     subscription = Connectivity().onConnectivityChanged.listen(
  //       (ConnectivityResult result) async {
  //         isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //         if (!isDeviceConnected && isAlertSet == false) {
  //           showDialogBox();
  //           setState(() => isAlertSet = true);
  //         }
  //       },
  //     );

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const AutoSizeText('No Connection'),
          content:
              const AutoSizeText('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                // if (!isDeviceConnected && isAlertSet == false) {
                //   showDialogBox();
                //   setState(() => isAlertSet = true);
                // }
              },
              child: const AutoSizeText('OK'),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(user?.uid)
                .get()
                .then((value) => userModel = UserModel.fromMap(value.data()))
                .whenComplete(() {
              setState(() {
                userRole = userModel.role.toString();
                userFullName = userModel.fullName.toString();
              });
            });
            if (userRole != null) {
              if (userRole == 'Driver') {
                return DriverDashboard(userFullName);
              } else {
                return const UserDashboard();
              }
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    AutoSizeText(
                      "Please wait...",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
