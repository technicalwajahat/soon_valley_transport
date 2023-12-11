import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? uid;
  String? name;
  String? contactNumber;
  String? fromTravel;
  String? toTravel;
  String? busName;
  String? bookingDate;
  String? bookingBusTime;
  String? farePrice;
  String? payment;

  Booking({
    this.uid,
    this.name,
    this.contactNumber,
    this.fromTravel,
    this.toTravel,
    this.busName,
    this.bookingDate,
    this.bookingBusTime,
    this.farePrice,
    this.payment,
  });

  factory Booking.fromMap(map) {
    return Booking(
      uid: map['uid'],
      name: map['name'],
      contactNumber: map['contactNumber'],
      fromTravel: map['fromTravel'],
      toTravel: map['toTravel'],
      busName: map['busName'],
      bookingDate: map['bookingDate'],
      bookingBusTime: map['bookingBusTime'],
      farePrice: map['farePrice'],
      payment: map['payment'],
    );
  }

  Booking.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    uid = snapshot.get('uid');
    name = snapshot.get('name');
    contactNumber = snapshot.get('contactNumber');
    fromTravel = snapshot.get('fromTravel');
    toTravel = snapshot.get('toTravel');
    busName = snapshot.get('busName');
    bookingDate = snapshot.get('bookingDate');
    bookingBusTime = snapshot.get('bookingBusTime');
    farePrice = snapshot.get('farePrice');
    payment = snapshot.get('payment');
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "contactNumber": contactNumber,
      "fromTravel": fromTravel,
      "toTravel": toTravel,
      "busName": busName,
      "bookingDate": bookingDate,
      "bookingBusTime": bookingBusTime,
      "farePrice": farePrice,
      "payment": payment,
    };
  }
}
