import 'package:flutter/material.dart';

class FareACItem {
  final String farePrice;
  final String from;
  final String to;
  final IconData icon;

  FareACItem({
    required this.farePrice,
    required this.from,
    required this.to,
    required this.icon,
  });
}

List<FareACItem> myItemsAC = [
  FareACItem(
    farePrice: "1,000 PKR",
    from: "Islamabad",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "1,400 PKR",
    from: "Lahore",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "680 PKR",
    from: "Sargodha",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "450 PKR",
    from: "Talagang",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "400 PKR",
    from: "Khushab",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "500 PKR",
    from: "Jahurabad",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
];
