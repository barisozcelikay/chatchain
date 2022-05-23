// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:chatchain/constants.dart';
import 'package:flutter/material.dart';

import '../Widgets/aboutUsWidget.dart';

class AboutUsPage extends StatelessWidget {
  static String id = "aboutUs_page";
  var students = [
    {'name': "Barış Özçelikay", 'photo': 'assets/images/baris.jpg'},
    {'name': "Kaan Yazgan", 'photo': 'assets/images/kaan.png'},
    {'name': "Gökay Özsoy", 'photo': 'assets/images/gokay.jpeg'},
    {'name': "Onur Aladı", 'photo': 'assets/images/onur.jpg'}
  ];

  @override
  Widget build(BuildContext context) {
    print(students[1]['name'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: kappLightDarkenColor,
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  direction: Axis.horizontal,
                  children: [
                    for (var i = 0; i < 4; i++)
                      AboutUsWidget(
                          name: students[i]['name'].toString(),
                          photo: students[i]['photo'].toString()),
                  ]),
              Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "▷ We are studying computer engineering at TED University.\n\n▷ Chat Chain is our senior project.\n\n▷ We eager to learn and implement new technologies. Through this project, we aim to show users the possibilities of new technologies",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
