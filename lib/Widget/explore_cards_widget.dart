import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreGrid extends StatelessWidget {
  final IconData cardIcon;
  final Function() onTap;
  final String title;

  const ExploreGrid({
    Key? key,
    required this.cardIcon,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cardIcon, size: 44),
            SizedBox(height: Get.height * 0.01),
            AutoSizeText(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
