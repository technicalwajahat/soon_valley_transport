import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CurrentCityController extends GetxController {
  String city = '';

  @override
  void onInit() {
    super.onInit();
    _getCurrentCity();
  }

  Future<void> _getCurrentCity() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = placeMarks.first;
      city = placeMark.locality!;
      update();
    } catch (e) {
      print(e);
    }
  }
}
