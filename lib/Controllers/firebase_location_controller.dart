import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/Model/location_model.dart';

import 'chip_controller.dart';

class FireStoreController extends GetxController {
  final CollectionReference _locationRef =
      FirebaseFirestore.instance.collection('location');

  var locationList = <Location>[].obs;

  final ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    locationList.bindStream(
        getLocations(CitiesLocation.values[_chipController.selectedChip]));
    super.onInit();
  }

  Stream<List<Location>> getLocations(CitiesLocation city) {
    switch (city) {
      case CitiesLocation.ALL:
        Stream<QuerySnapshot> stream = _locationRef.snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.ISLAMABAD:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Islamabad').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.LAHORE:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Lahore').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.NAUSHERA:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Naushera').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.TALAGANG:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Talagang').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.SARGODHA:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Sargodha').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.KHUSHAB:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Khushab').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());

      case CitiesLocation.JAHURABAD:
        Stream<QuerySnapshot> stream =
            _locationRef.where('fromCity', isEqualTo: 'Jahurabad').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return Location.fromDocumentSnapshot(snap);
            }).toList());
    }
  }
}
