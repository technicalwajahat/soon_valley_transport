import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  String? driverName;
  String? busName;
  String? busNumber;
  String? contactNumber;
  String? latitude;
  String? longitude;
  String? fromCity;
  String? toCity;

  Location(this.driverName, this.busName, this.busNumber, this.contactNumber,
      this.latitude, this.longitude, this.fromCity, this.toCity);

  Location.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    busName = snapshot.get('busName');
    busNumber = snapshot.get('busNumber');
    driverName = snapshot.get('driverName');
    contactNumber = snapshot.get('contactNumber');
    latitude = snapshot.get('latitude');
    longitude = snapshot.get('longitude');
    fromCity = snapshot.get('fromCity');
    toCity = snapshot.get('toCity');
  }
}

enum CitiesLocation {
  ALL,
  ISLAMABAD,
  NAUSHERA,
  SARGODHA,
  JAHURABAD,
  TALAGANG,
  KHUSHAB,
  LAHORE,
}
