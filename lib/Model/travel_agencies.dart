class BusAgency {
  String name;
  List<City> cities;
  String number;

  BusAgency({required this.name, required this.cities, required this.number});
}

class City {
  String name;
  List<String> travelTimings;

  City({required this.name, required this.travelTimings});
}

final List<BusAgency> busAgency = [
  BusAgency(
    name: "Fateh Khan Awan",
    cities: [
      City(
        name: "Sargodha",
        travelTimings: [
          "9:00 AM - 12:00 PM",
          "01:30 PM - 04:30 PM",
          "03:00 PM - 06:00 PM",
          "05:00 PM - 8:00 PM",
        ],
      ),
      City(
        name: "Khushab",
        travelTimings: [
          "07:00 AM - 09:00 PM",
          "10:00 PM - 12:00 PM",
          "01:00 PM - 03:00 PM",
          "04:00 PM - 06:00 PM",
        ],
      ),
    ],
    number: '03177407933',
  ),
  BusAgency(
    name: "Haji Mehboob Travel",
    cities: [
      City(
        name: "Islamabad",
        travelTimings: [
          "9:00 AM - 2:00 PM",
          "12:00 PM - 5:00 PM",
          "3:00 PM - 8:00 PM"
        ],
      ),
      City(
        name: "Talagang",
        travelTimings: [
          "09:00 AM - 11:00 PM",
          "12:00 PM - 02:00 PM",
          "03:00 PM - 05:00 PM"
        ],
      ),
    ],
    number: '03354507733',
  ),
  BusAgency(
    name: "Radhnal Express",
    cities: [
      City(
        name: "Lahore",
        travelTimings: [
          "9:00 AM - 03:00 PM",
          "12:00 PM - 06:00 PM",
          "04:00 PM - 10:00 PM"
        ],
      ),
      City(
        name: "Islamabad",
        travelTimings: [
          "9:00 AM - 2:00 PM",
          "12:00 PM - 5:00 PM",
          "3:00 PM - 8:00 PM"
        ],
      ),
    ],
    number: '03177407933',
  ),
  BusAgency(
    name: "Malik Travels",
    cities: [
      City(
        name: "Islamabad",
        travelTimings: [
          "9:00 AM - 2:00 PM",
          "12:00 PM - 5:00 PM",
          "3:00 PM - 8:00 PM"
        ],
      ),
      City(
        name: "Sargodha",
        travelTimings: [
          "9:00 AM - 12:00 PM",
          "01:30 PM - 04:30 PM",
          "03:00 PM - 06:00 PM",
          "05:00 PM - 8:00 PM",
        ],
      ),
    ],
    number: '03354507733',
  ),
  BusAgency(
    name: "Awan Travels",
    cities: [
      City(
        name: "Jahurabad",
        travelTimings: [
          "07:00 AM - 09:00 PM",
          "10:00 PM - 12:00 PM",
          "01:00 PM - 03:00 PM",
          "02:00 PM - 04:00 PM",
        ],
      ),
      City(
        name: "Khushab",
        travelTimings: [
          "09:00 AM - 11:00 PM",
          "10:00 PM - 12:00 PM",
          "01:00 PM - 03:00 PM",
          "04:00 PM - 06:00 PM",
        ],
      ),
    ],
    number: '03336098534',
  ),
  BusAgency(
    name: "New Awan Travels",
    cities: [
      City(
        name: "Islamabad",
        travelTimings: [
          "9:00 AM - 2:00 PM",
          "12:00 PM - 5:00 PM",
          "3:00 PM - 8:00 PM"
        ],
      ),
      City(
        name: "Sargodha",
        travelTimings: [
          "9:00 AM - 12:00 PM",
          "01:30 PM - 04:30 PM",
          "03:00 PM - 06:00 PM",
          "05:00 PM - 8:00 PM",
        ],
      ),
    ],
    number: '03177407933',
  )
];
