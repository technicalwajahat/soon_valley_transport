import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soon_valley_transport/Services/location_permission_service.dart';

import '../Services/notification_services.dart';
import 'driver_add_location.dart';

class ShareLocation extends StatefulWidget {
  final String? driverName;

  const ShareLocation(this.driverName, {Key? key}) : super(key: key);

  @override
  _ShareLocationState createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  User? userId = FirebaseAuth.instance.currentUser;
  late String docId;
  late String lat;
  late String long;
  late bool isButtonDisabled;
  NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Locations",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("location")
              .where("userID", isEqualTo: userId?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: AutoSizeText("Something Went Wrong!"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: AutoSizeText("No Data Found!"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var busName = snapshot.data!.docs[index]['busName'];
                  var busNumber = snapshot.data!.docs[index]['busNumber'];
                  var lat = snapshot.data!.docs[index]['latitude'];
                  var long = snapshot.data!.docs[index]['longitude'];
                  var from = snapshot.data!.docs[index]['fromCity'];
                  var to = snapshot.data!.docs[index]['toCity'];
                  var docId = snapshot.data!.docs[index].id;
                  return Card(
                    child: ListTile(
                      title: AutoSizeText(
                        busName + " (" + busNumber + ")",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: AutoSizeText(
                          "${"Lat: " + lat + "\t\t\t Long:" + long + "\nFrom: " + from}\t\tTo: " +
                              to),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HandleLocations()
                                  .getCurrentLocation(context)
                                  .then(
                                (location) async {
                                  lat = '${location.latitude}';
                                  long = '${location.longitude}';
                                  await FirebaseFirestore.instance
                                      .collection("location")
                                      .doc(docId)
                                      .update(
                                    {"latitude": lat, "longitude": long},
                                  ).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: AutoSizeText(
                                                "Location Updated!")));
                                    notificationServices
                                        .getDeviceToken()
                                        .then((value) async {
                                      var data = {
                                        'to': value.toString(),
                                        'notification': {
                                          'title': busName,
                                          'body':
                                              "${"Bus Number: " + busNumber + "\t From: " + from} \t To: " +
                                                  to,
                                        },
                                        'android': {
                                          'notification': {
                                            'notification_count': 23,
                                          },
                                        },
                                      };

                                      await http.post(
                                          Uri.parse(
                                              'https://fcm.googleapis.com/fcm/send'),
                                          body: jsonEncode(data),
                                          headers: {
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                            'Authorization':
                                                'key=AAAAZmiaRbU:APA91bFsBdsSKzS-W46bAosd7Ygxg7vw4cTpThGfqDtApdR7qTKybowuyWtUj6Slyahv22fPVy8ZQxtDLKOFOt8GudM07qsYsLe2-YhN1My5wfxpIt1xv_8sHjothtWoX1GzQns72SSE'
                                          }).then((value) {
                                        if (kDebugMode) {
                                          print(value.body.toString());
                                        }
                                      }).onError((error, stackTrace) {
                                        if (kDebugMode) {
                                          print(error);
                                        }
                                      });
                                    });
                                  });
                                },
                              );
                            },
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("location")
                                  .doc(docId)
                                  .delete();
                            },
                            child: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HandleLocations().getCurrentLocation(context).then(
            (value) {
              lat = '${value.latitude}';
              long = '${value.longitude}';
              Get.to(const AddLocation(), arguments: {
                "driverName": widget.driverName,
                "lat": lat,
                "long": long
              });
            },
          );
        },
        child: const Icon(Icons.add_location_alt_rounded),
      ),
    );
  }
}
