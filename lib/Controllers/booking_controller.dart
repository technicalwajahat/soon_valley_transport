import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Model/booking_model.dart';

class BookingController extends GetxController {
  final CollectionReference _bookingRef =
      FirebaseFirestore.instance.collection('booking');

  Future<void> createBooking(Booking bookingModel, BuildContext context) async {
    await _bookingRef.doc().set(bookingModel.toMap());
  }

  Stream<List<Booking>> readUserBooking(String? userId) {
    Stream<QuerySnapshot> stream =
        _bookingRef.where("uid", isEqualTo: userId).snapshots();
    return stream.map((snapshot) => snapshot.docs.map((snap) {
          return Booking.fromDocumentSnapshot(snap);
        }).toList());
  }
}
