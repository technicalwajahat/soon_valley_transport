import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DrawerNavigationItem extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool selected;
  final Function() onTap;

  const DrawerNavigationItem(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  State<DrawerNavigationItem> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerNavigationItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      leading: Icon(widget.iconData),
      title: AutoSizeText(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
      ),
      onTap: widget.onTap,
      selected: widget.selected,
    );
  }
}
