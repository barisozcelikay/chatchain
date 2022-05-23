import 'package:flutter/material.dart';

import '../constants.dart';

class AboutUsWidget extends StatefulWidget {
  AboutUsWidget({required this.name, required this.photo});

  final String name;
  final String photo;

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  bool a = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          a = !a;
        });
      },
      child: Container(
        width: (a == true) ? MediaQuery.of(context).size.width * 0.8 : 150,
        height: a == true ? MediaQuery.of(context).size.height * 0.8 : 200,
        decoration: BoxDecoration(
            color: kappLightDarkenColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 70, backgroundImage: AssetImage(widget.photo)),
              SizedBox(
                height: 10,
              ),
              Text(widget.name)
            ],
          ),
        ),
      ),
    );
  }
}
