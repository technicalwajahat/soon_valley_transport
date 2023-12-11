import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Controllers/firebase_location_controller.dart';
import 'package:soon_valley_transport/Model/location_model.dart';
import 'package:soon_valley_transport/Services/location_permission_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controllers/chip_controller.dart';
import 'user_bus_live_location.dart';

class BusTracker extends StatefulWidget {
  const BusTracker({Key? key}) : super(key: key);

  @override
  _BusTrackerState createState() => _BusTrackerState();
}

class _BusTrackerState extends State<BusTracker> {
  final FireStoreController fireStoreController =
      Get.put(FireStoreController());

  final ChipController chipController = Get.put(ChipController());

  final List<String> _chipLabel = [
    'All',
    'Islamabad',
    'Naushera',
    'Sargodha',
    'Jahurabad',
    'Talagang',
    'Khushab',
    'Lahore',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Bus Tracker",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Wrap(
                spacing: 10,
                children: List<Widget>.generate(8, (int index) {
                  return ChoiceChip(
                    label: AutoSizeText(_chipLabel[index]),
                    selected: chipController.selectedChip == index,
                    onSelected: (bool selected) {
                      chipController.selectedChip = selected ? index : null;
                      fireStoreController.onInit();
                      fireStoreController.getLocations(
                          CitiesLocation.values[chipController.selectedChip]);
                    },
                  );
                }),
              ),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fireStoreController.locationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          title: AutoSizeText(
                            "${fireStoreController.locationList[index].driverName}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: AutoSizeText(
                            "${fireStoreController.locationList[index].busName} (${fireStoreController.locationList[index].busNumber})\nFrom: ${fireStoreController.locationList[index].fromCity}\t\tTo: ${fireStoreController.locationList[index].toCity}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launchUrl(Uri(
                                    scheme: 'tel',
                                    path:
                                        "${fireStoreController.locationList[index].contactNumber}",
                                  ));
                                },
                                child: const Icon(Icons.call),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  HandleLocations()
                                      .getCurrentLocation(context)
                                      .then(
                                        (value) => Get.to(
                                            const BusLiveLocation(),
                                            arguments: {
                                              "lat":
                                                  "${fireStoreController.locationList[index].latitude}",
                                              "long":
                                                  "${fireStoreController.locationList[index].longitude}"
                                            }),
                                      );
                                },
                                child: const Icon(Icons.directions),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
