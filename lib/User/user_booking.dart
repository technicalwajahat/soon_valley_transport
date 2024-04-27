import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Controllers/booking_controller.dart';
import 'package:soon_valley_transport/Model/booking_model.dart';

class UserBooking extends StatefulWidget {
  const UserBooking({Key? key}) : super(key: key);

  @override
  State<UserBooking> createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  final BookingController bookingController = BookingController();
  User? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Your Bookings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: StreamBuilder<List<Booking>>(
          stream: bookingController.readUserBooking(userId!.uid),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "Source",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  AutoSizeText(
                                    snapshot.data![index].fromTravel.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Icon(Icons.swap_horiz_rounded, size: 28),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const AutoSizeText(
                                    "Destination",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  AutoSizeText(
                                    snapshot.data![index].toTravel.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.008),
                          Row(
                            children: [
                              const Icon(Icons.directions_bus),
                              SizedBox(width: Get.width * 0.01),
                              AutoSizeText(
                                "${snapshot.data![index].busName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Row(
                            children: [
                              const Icon(Icons.price_change_rounded),
                              SizedBox(width: Get.width * 0.01),
                              AutoSizeText(
                                "${snapshot.data![index].farePrice} PKR",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Row(
                            children: [
                              const Icon(Icons.date_range_rounded),
                              SizedBox(width: Get.width * 0.01),
                              AutoSizeText(
                                "${snapshot.data![index].bookingDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              SizedBox(width: Get.width * 0.03),
                              const Icon(Icons.timelapse_rounded),
                              SizedBox(width: Get.width * 0.01),
                              AutoSizeText(
                                "${snapshot.data![index].bookingBusTime}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Row(
                            children: [
                              const Icon(Icons.payment),
                              SizedBox(width: Get.width * 0.01),
                              AutoSizeText(
                                "${snapshot.data![index].payment} Pay",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
