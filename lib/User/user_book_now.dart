import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soon_valley_transport/Controllers/booking_controller.dart';
import 'package:soon_valley_transport/Model/booking_model.dart';
import 'package:soon_valley_transport/User/user_google_payment_screen.dart';

import '../Services/snackbar_message.dart';
import '../color_schemes.g.dart';

class UserBookNow extends StatefulWidget {
  const UserBookNow({Key? key}) : super(key: key);

  @override
  State<UserBookNow> createState() => _UserBookNowState();
}

enum PaymentOption { Cash, Online }

class _UserBookNowState extends State<UserBookNow> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? farePrice;

  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final contactNoController = TextEditingController();
  final dateInputController = TextEditingController();

  String fromDropdownValue = 'Naushera';
  String toDropdownValue = 'None';
  String busDropdownValue = 'None';
  String timeDropdownValue = 'None';
  bool isCash = true;
  PaymentOption? _payment = PaymentOption.Cash;
  String paymentOption = "Cash";

  @override
  void initState() {
    super.initState();
    farePrice = "0.00";
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    contactNoController.dispose();
    dateInputController.dispose();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Reserve Seat",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Name cannot be empty");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fullNameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_circle),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Full Name",
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                TextFormField(
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: contactNoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  onSaved: (value) {
                    contactNoController.text = value!;
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Contact Number",
                    labelText: "Contact Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
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
                SizedBox(height: Get.height * 0.02),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: toDropdownValue,
                  isExpanded: true,
                  validator: (value) {
                    if (value == "None") {
                      return ("Please Select City");
                    }
                    return null;
                  },
                  onChanged: (dropdownValue) {
                    setState(() {
                      toDropdownValue = dropdownValue!;
                      if (toDropdownValue == "Islamabad") {
                        farePrice = "950.00";
                      } else if (toDropdownValue == "Lahore") {
                        farePrice = "1300.00";
                      } else if (toDropdownValue == "Sargodha") {
                        farePrice = "600.00";
                      } else if (toDropdownValue == "Jahurabad") {
                        farePrice = "450.00";
                      } else if (toDropdownValue == "Talagang") {
                        farePrice = "400.00";
                      } else if (toDropdownValue == "Khushab") {
                        farePrice = "350.00";
                      } else {
                        farePrice = "0.00";
                      }
                    });
                  },
                  items: <String>[
                    'None',
                    'Islamabad',
                    'Lahore',
                    'Sargodha',
                    'Khushab',
                    'Jahurabad',
                    'Talagang'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "To",
                    prefixIcon: const Icon(Icons.location_city),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    hintText: "To",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: busDropdownValue,
                  isExpanded: true,
                  onChanged: (dropdownValue) {
                    setState(() {
                      busDropdownValue = dropdownValue!;
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
                    'New Awan Travels'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Travel Agency",
                    prefixIcon: const Icon(Icons.directions_bus),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                TextFormField(
                  controller: dateInputController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    prefixIcon: const Icon(Icons.calendar_month_rounded),
                    labelText: "Booking Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Select Booking Date");
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 7)),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('MM-dd-yyyy').format(pickedDate);
                      setState(() {
                        dateInputController.text = formattedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                DropdownButtonFormField<String>(
                  autofocus: false,
                  value: timeDropdownValue,
                  isExpanded: true,
                  validator: (value) {
                    if (value == "None") {
                      return ("Please Select Arrival Time");
                    }
                    return null;
                  },
                  onChanged: (dropdownValue) {
                    setState(() {
                      timeDropdownValue = dropdownValue!;
                    });
                  },
                  items: <String>[
                    'None',
                    '05:00',
                    '05:30',
                    '06:00',
                    '06:30',
                    '07:00',
                    '07:30',
                    '08:00',
                    '08:30',
                    '09:00',
                    '09:30',
                    '10:00',
                    '10:30',
                    '11:00',
                    '11:30',
                    '12:00',
                    '12:30',
                    '13:00',
                    '13:30',
                    '14:00',
                    '14:30',
                    '15:00',
                    '15:30',
                    '16:00',
                    '16:30',
                    '17:00',
                    '17:30',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Arrival Time",
                    prefixIcon: const Icon(Icons.location_city),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    hintText: "Select Time",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                TextFormField(
                  autofocus: false,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "$farePrice PKR",
                    prefixIcon: const Icon(Icons.price_change_rounded),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const AutoSizeText(
                          "Cash",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        leading: Radio<PaymentOption>(
                          value: PaymentOption.Cash,
                          groupValue: _payment,
                          onChanged: (PaymentOption? value) {
                            setState(() {
                              _payment = value;
                              paymentOption = "Cash";
                              isCash = true;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const AutoSizeText(
                          "Online",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        leading: Radio<PaymentOption>(
                          value: PaymentOption.Online,
                          groupValue: _payment,
                          onChanged: (PaymentOption? value) {
                            setState(() {
                              _payment = value;
                              paymentOption = "Online";
                              isCash = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                isCash
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightColorScheme.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          addBooking(
                            currentUser!.uid,
                            fullNameController.text.trim(),
                            contactNoController.text.trim(),
                            fromDropdownValue,
                            toDropdownValue,
                            busDropdownValue,
                            dateInputController.text.trim(),
                            timeDropdownValue,
                            farePrice!,
                            paymentOption,
                          );
                        },
                        child: const AutoSizeText(
                          "Book Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightColorScheme.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addBooking(
                              currentUser!.uid,
                              fullNameController.text.trim(),
                              contactNoController.text.trim(),
                              fromDropdownValue,
                              toDropdownValue,
                              busDropdownValue,
                              dateInputController.text.trim(),
                              timeDropdownValue,
                              farePrice!,
                              paymentOption,
                            );
                          }
                        },
                        child: const AutoSizeText(
                          "Pay Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addBooking(
    String uid,
    String name,
    String contact,
    String fromTravel,
    String toTravel,
    String busName,
    String bookingDate,
    String bookingBusTime,
    String farePrice,
    String paymentOption,
  ) {
    if (_formKey.currentState!.validate()) {
      try {
        Booking bookingModel = Booking(
          uid: uid,
          name: name,
          contactNumber: contact,
          fromTravel: fromTravel,
          toTravel: toTravel,
          busName: busName,
          bookingDate: bookingDate,
          bookingBusTime: bookingBusTime,
          farePrice: farePrice,
          payment: paymentOption,
        );
        if (paymentOption == "Cash") {
          BookingController()
              .createBooking(bookingModel, context)
              .then((value) {
            ShowMessage.showMessage("Booking Successfully!", context);
            Get.back();
          });
        } else {
          BookingController()
              .createBooking(bookingModel, context)
              .then((value) {
            Get.to(const UserGooglePaymentScreen());
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
