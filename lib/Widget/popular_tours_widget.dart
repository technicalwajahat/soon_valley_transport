import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soon_valley_transport/User/user_book_now.dart';

import '../color_schemes.g.dart';

class CountryListTile extends StatelessWidget {
  final String cityName;
  final String timeTaken;
  final String farePrice;
  final String totalKms;
  final String imageUrl;

  const CountryListTile(
      {Key? key,
      required this.cityName,
      required this.timeTaken,
      required this.imageUrl,
      required this.farePrice,
      required this.totalKms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 250,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.5),
            ),
            height: 250,
            width: 220,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    cityName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      const Icon(Icons.route_rounded, color: Colors.white),
                      SizedBox(width: Get.width * 0.03),
                      AutoSizeText(
                        totalKms,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    children: [
                      const Icon(Icons.price_change, color: Colors.white),
                      SizedBox(width: Get.width * 0.03),
                      AutoSizeText(
                        farePrice,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    children: [
                      const Icon(Icons.time_to_leave_rounded,
                          color: Colors.white),
                      SizedBox(width: Get.width * 0.03),
                      AutoSizeText(
                        timeTaken,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightColorScheme.onPrimary,
                      foregroundColor: lightColorScheme.primary,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.to(const UserBookNow());
                    },
                    child: const AutoSizeText(
                      "Reserve Seat",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
