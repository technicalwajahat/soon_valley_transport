import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatefulWidget {
  const DrawerHeaderWidget({Key? key}) : super(key: key);

  @override
  State<DrawerHeaderWidget> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<DrawerHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 16, 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            backgroundImage: AssetImage("assets/ic_logo.png"),
          ),
          SizedBox(
            width: 16.0,
          ),
          AutoSizeText(
            "Soon Valley Transport",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
