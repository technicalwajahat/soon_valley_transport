import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../color_schemes.g.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  User? userId = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();

  String busNameDropdownValue = 'None';
  String fromDropdownValue = 'Naushera';
  String toDropdownValue = 'None';

  @override
  void dispose() {
    super.dispose();
    _busNumberController.dispose();
    _contactNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        bottomOpacity: 0,
        title: const AutoSizeText(
          "Add Location",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: Get.arguments['driverName'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: busNameDropdownValue,
                  isExpanded: true,
                  onChanged: (dropdownValue) {
                    setState(() {
                      busNameDropdownValue = dropdownValue!;
                    });
                  },
                  validator: (value) {
                    if (value == "None") {
                      return ("Please Select Travel Agency");
                    }
                    return null;
                  },
                  items: <String>[
                    'None',
                    'Fateh Khan Awan',
                    'Haji Mehboob Travel',
                    'Radhnal Express',
                    'Malik Travel',
                    'Awan Travels',
                    'New Awan Travels',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.directions_bus),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    labelText: "Travel Agency",
                    hintText: "Travel Agency",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  controller: _busNumberController,
                  autofocus: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z- ]")),
                  ],
                  onSaved: (value) {
                    _busNumberController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Bus Number cannot be empty");
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.confirmation_number),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Bus Number",
                    labelText: "Bus Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  controller: _contactNoController,
                  autofocus: false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  onSaved: (value) {
                    _contactNoController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please enter your mobile number");
                    }
                    if (value.length < 11) {
                      return ("Please enter valid mobile number");
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Conductor Number",
                    labelText: "Conductor Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: fromDropdownValue,
                  isExpanded: true,
                  onChanged: (dropdownValue) {
                    setState(() {
                      fromDropdownValue = dropdownValue!;
                    });
                  },
                  items: <String>["Naushera"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    hintText: "From",
                    labelText: "From",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: toDropdownValue,
                  isExpanded: true,
                  onChanged: (dropdownValue) {
                    setState(() {
                      toDropdownValue = dropdownValue!;
                    });
                  },
                  validator: (value) {
                    if (value == "None") {
                      return ("Please Select City");
                    }
                    return null;
                  },
                  items: <String>[
                    'None',
                    'Islamabad',
                    'Lahore',
                    'Sargodha',
                    'Khushab',
                    "Naushera",
                    'Jahurabad',
                    'Talagang'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_city),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    labelText: "To",
                    hintText: "To",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.directions),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: Get.arguments['lat'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.directions),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: Get.arguments['long'].toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    addLocation(
                        Get.arguments['driverName'].toString(),
                        busNameDropdownValue.trim(),
                        _busNumberController.text.trim(),
                        _contactNoController.text.trim(),
                        Get.arguments['lat'].toString(),
                        Get.arguments['long'].toString(),
                        fromDropdownValue.trim(),
                        toDropdownValue.trim());
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: lightColorScheme.primary,
                      minimumSize: const Size.fromHeight(50)),
                  child: const AutoSizeText(
                    'Add Location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addLocation(
      driverName,
      String busName,
      String busNumber,
      String contactNumber,
      String lat,
      String long,
      String fromCity,
      String toCity) {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseFirestore.instance.collection("location").doc().set({
          "userID": userId?.uid,
          "driverName": driverName,
          "busName": busName,
          "busNumber": busNumber,
          "contactNumber": contactNumber,
          "fromCity": fromCity,
          "toCity": toCity,
          "latitude": lat,
          "longitude": long,
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: AutoSizeText("Location Added Successfully!")));
          Get.back();
        }).whenComplete(() => null);
      } catch (e) {
        print("Location not added!");
      }
    }
  }
}
