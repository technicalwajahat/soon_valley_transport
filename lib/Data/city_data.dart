import 'package:soon_valley_transport/Model/city_model.dart';

List<CityModel> getCities() {
  List<CityModel> cities = [];

  CityModel cityModel = CityModel();
  cityModel.cityName = "Islamabad";
  cityModel.timeTaken = "5.5 Hrs";
  cityModel.farePrice = "950 PKR";
  cityModel.totalKms = "230 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1623261216813-fbbe4fb7df44?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80";
  cities.add(cityModel);

  cityModel = CityModel();
  cityModel.cityName = "Lahore";
  cityModel.timeTaken = "7 Hrs";
  cityModel.farePrice = "1300 PKR";
  cityModel.totalKms = "320 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1603491656337-3b491147917c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=876&q=80";
  cities.add(cityModel);

  cityModel = CityModel();
  cityModel.cityName = "Sargodha";
  cityModel.timeTaken = "4 Hrs";
  cityModel.farePrice = "600 PKR";
  cityModel.totalKms = "120 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1596410466756-2ef5ca9f6c81?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80";
  cities.add(cityModel);

  cityModel = CityModel();
  cityModel.cityName = "Jauharabad";
  cityModel.timeTaken = "2 Hrs";
  cityModel.farePrice = "450 PKR";
  cityModel.totalKms = "60 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1654416798857-820ee581cf5f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=498&q=80";
  cities.add(cityModel);

  cityModel = CityModel();
  cityModel.cityName = "Talagang";
  cityModel.timeTaken = "2 Hrs";
  cityModel.farePrice = "400 PKR";
  cityModel.totalKms = "65 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1647283816379-cf854ec9b8a9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80";
  cities.add(cityModel);

  cityModel = CityModel();
  cityModel.cityName = "Khushab";
  cityModel.timeTaken = "2 Hrs";
  cityModel.farePrice = "350 PKR";
  cityModel.totalKms = "60 KM";
  cityModel.imgUrl =
  "https://images.unsplash.com/photo-1559969641-4d0eb956fd3e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80";
  cities.add(cityModel);

  return cities;
}
