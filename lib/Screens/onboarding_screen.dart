import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soon_valley_transport/Screens/registration_screen.dart';
import 'package:soon_valley_transport/color_schemes.g.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
            ),
            SizedBox(height: Get.height * 0.02),
            AutoSizeText(
              title,
              style: TextStyle(
                color: lightColorScheme.primary,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            AutoSizeText(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.white,
              urlImage: 'assets/ic_location.png',
              title: "Real-time Tracking",
              subtitle:
                  "Real-time tracking method that makes use of GPS to determine the current location of a person, or vehicle at any moment in time.",
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/ic_history.png',
              title: "Maintain Records",
              subtitle:
                  "Keeping track of the history of a person's or organization's activities, generally by creating and storing consistent, formal records.",
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/ic_payment.png',
              title: "Secure Payment",
              subtitle:
                  "Secure payment processing and information services provide users security online in their transactions.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  minimumSize: const Size.fromHeight(80),
                  foregroundColor: Colors.white,
                  backgroundColor: lightColorScheme.primary),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("showHome", true);
                Get.offAll(const Registration());
              },
              child: const AutoSizeText(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ),
            )
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(2),
                    child: const AutoSizeText(
                      'SKIP',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: 8.0,
                        dotWidth: 8.0,
                        spacing: 14,
                        dotColor: Colors.black26,
                        activeDotColor: lightColorScheme.surfaceTint,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    child: const AutoSizeText(
                      'NEXT',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
