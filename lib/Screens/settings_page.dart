// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use

import 'package:chatchain/Screens/aboutUs_page.dart';
import 'package:chatchain/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/settingsCard.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Uri _url = Uri.parse('google.com');

  Future _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Dark Mode")),
        SettingsCard(
          onPressed: () {},
          /*onPressed: () async {
              print("hello world");
              const url = 'https://blog.logrocket.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            */
          title: "Need Help",
          icon: Icons.help_outline,
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "About Us",
          icon: Icons.info_outline,
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Privacy Policy",
          icon: Icons.privacy_tip_outlined,
        ),
        SettingsCard(
            onPressed: () {
              Navigator.pushNamed(context, AboutUsPage.id);
            },
            title: "Log Out",
            icon: Icons.output),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Delete Account",
          icon: Icons.delete_outline,
        ),
      ],
    );
  }
}




/*  Expanded(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        size: 40,
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 25),
                      )
                    ]))),*/
