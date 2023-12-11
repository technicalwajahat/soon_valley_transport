import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:soon_valley_transport/Data/driver_data.dart';
import 'package:soon_valley_transport/Model/driver_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDrivers extends StatefulWidget {
  const ShowDrivers({Key? key}) : super(key: key);

  @override
  State<ShowDrivers> createState() => _ShowDriversState();
}

class _ShowDriversState extends State<ShowDrivers> {
  List<DriverModel> driverData = getDrivers();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Drivers",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12),
        physics: const ClampingScrollPhysics(),
        child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                driverData[index].isExpanded = !isExpanded;
              });
            },
            children: driverData.map<ExpansionPanel>((items) {
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: const Icon(Icons.account_circle_rounded),
                    title: AutoSizeText(
                      items.driverName!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                },
                body: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_sharp),
                      title: SelectableText(items.age!),
                    ),
                    ListTile(
                      onTap: () {
                        launchUrl(Uri(
                          scheme: 'tel',
                          path: items.mobileNo!,
                        ));
                      },
                      leading: const Icon(Icons.call),
                      title: SelectableText(items.mobileNo!),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: SelectableText(items.address!),
                    ),
                    ListTile(
                      leading: const Icon(Icons.directions_bus),
                      title: SelectableText(items.travelAgency!),
                    ),
                  ],
                ),
                isExpanded: items.isExpanded,
              );
            }).toList()),
      ),
    );
  }
}
