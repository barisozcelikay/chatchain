// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use

import 'package:chatchain/Screens/aboutUs_page.dart';
import 'package:chatchain/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onPressed: () async {
              print("hello world");
              const url = 'https://blog.logrocket.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            title: "Need Help",
            icon: Icon(
              Icons.help_outline,
              size: 40,
            )),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "About Us",
          icon: Icon(
            Icons.info_outline,
            size: 40,
          ),
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Privacy Policy",
          icon: Icon(
            Icons.privacy_tip_outlined,
            size: 40,
          ),
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Log Out",
          icon: Icon(
            Icons.output,
            size: 40,
          ),
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Delete Account",
          icon: Icon(
            Icons.delete_outline,
            size: 40,
          ),
        ),

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
      ],
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String title;
  final Icon icon;
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
            icon,
            Text(
              title,
              style: TextStyle(fontSize: 25),
            )
          ])),
    ));
  }
}
