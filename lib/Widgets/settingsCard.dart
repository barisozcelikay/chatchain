import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              icon,
              size: 40,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            )
          ])),
    ));
  }
}
