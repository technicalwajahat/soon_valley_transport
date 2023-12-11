import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Model/travel_agencies.dart';
import 'package:url_launcher/url_launcher.dart';

import '../color_schemes.g.dart';

class TravelAgency extends StatefulWidget {
  const TravelAgency({Key? key}) : super(key: key);

  @override
  _TravelAgencyState createState() => _TravelAgencyState();
}

class _TravelAgencyState extends State<TravelAgency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Travel Agencies",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          itemCount: busAgency.length,
          itemBuilder: (context, index) {
            BusAgency agency = busAgency[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.directions_bus_rounded),
                trailing: const Icon(Icons.arrow_right),
                title: AutoSizeText(agency.name),
                onTap: () {
                  _showBottomSheet(context, agency);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, BusAgency agency) {
    showModalBottomSheet(
      elevation: 5,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: const Divider(
                  indent: 120.0,
                  endIndent: 120.0,
                  thickness: 5,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              AutoSizeText(
                agency.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: agency.cities.length,
                  itemBuilder: (context, index) {
                    City city = agency.cities[index];
                    return Column(
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              city.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 10.0,
                          children: city.travelTimings.map((timing) {
                            return AutoSizeText(
                              timing,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightColorScheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  launchUrl(Uri(scheme: 'tel', path: agency.number));
                },
                child: const AutoSizeText(
                  "Call Now",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
