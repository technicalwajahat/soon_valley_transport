class DriverModel {
  String? driverName;
  String? age;
  String? mobileNo;
  String? address;
  String? travelAgency;
  String? driverImage;
  bool isExpanded;

  DriverModel(
      {this.driverName,
      this.age,
      this.mobileNo,
      this.address,
      this.travelAgency,
      this.driverImage,
      this.isExpanded = false});
}
