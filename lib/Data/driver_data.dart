import '../Model/driver_model.dart';

List<DriverModel> getDrivers() {
  List<DriverModel> driverData = [];

  DriverModel driverModel = DriverModel();
  driverModel.driverName = "Aashiq Ali";
  driverModel.age = "34 Years";
  driverModel.address = "Dhaka (Soon Valley)";
  driverModel.mobileNo = "03177407933";
  driverModel.travelAgency = "Radhnal Express";
  driverModel.driverImage = "assets/drivers/driver.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Haji Mehboob";
  driverModel.age = "36 Years";
  driverModel.address = "Naushera (Soon Valley)";
  driverModel.mobileNo = "03177478922";
  driverModel.travelAgency = "Malik Travels";
  driverModel.driverImage = "assets/drivers/driver1.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Ejaz Haider";
  driverModel.age = "30 Years";
  driverModel.address = "Khabeki (Soon Valley)";
  driverModel.mobileNo = "03157403489";
  driverModel.travelAgency = "Fateh Khan Awan";
  driverModel.driverImage = "assets/drivers/driver2.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Main Muhammad";
  driverModel.age = "32 Years";
  driverModel.address = "Uchalla (Soon Valley)";
  driverModel.mobileNo = "03227457990";
  driverModel.travelAgency = "Awan Travels";
  driverModel.driverImage = "assets/drivers/driver3.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Muhammad Nawab";
  driverModel.age = "30 Years";
  driverModel.address = "Kamra (Soon Valley)";
  driverModel.mobileNo = "03125456783";
  driverModel.travelAgency = "New Awan Travels";
  driverModel.driverImage = "assets/drivers/driver4.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Khan Muhammad";
  driverModel.age = "28 Years";
  driverModel.address = "Dhaka (Soon Valley)";
  driverModel.mobileNo = "03177407933";
  driverModel.travelAgency = "Haji Mehboob Awan";
  driverModel.driverImage = "assets/drivers/driver1.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Muhamamd Kashif";
  driverModel.age = "27 Years";
  driverModel.address = "Uchalli (Soon Valley)";
  driverModel.mobileNo = "03177470137";
  driverModel.travelAgency = "Radhnal Express";
  driverModel.driverImage = "assets/drivers/driver4.jpg";
  driverData.add(driverModel);

  driverModel = DriverModel();
  driverModel.driverName = "Ejaz Haider";
  driverModel.age = "30 Years";
  driverModel.address = "Khabeki (Soon Valley)";
  driverModel.mobileNo = "03157403489";
  driverModel.travelAgency = "Fateh Khan Awan";
  driverModel.driverImage = "assets/drivers/driver3.jpg";
  driverData.add(driverModel);

  return driverData;
}
