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

List<FareACItem> myItemsNonAC = [
  FareACItem(
    farePrice: "950 PKR",
    from: "Islamabad",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "1,300 PKR",
    from: "Lahore",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "600 PKR",
    from: "Sargodha",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "400 PKR",
    from: "Talagang",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "350 PKR",
    from: "Khushab",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
  FareACItem(
    farePrice: "450 PKR",
    from: "Jahurabad",
    to: "Naushera",
    icon: Icons.swap_calls_outlined,
  ),
];
