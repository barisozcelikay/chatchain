// ignore_for_file: prefer_const_constructors

import 'package:chatchain/Screens/chat_home_page.dart';
import 'package:chatchain/Screens/settings_page.dart';
import 'package:chatchain/Widgets/customBottomNavBar.dart';
import 'package:chatchain/Screens/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> pages = [SettingsPage(), ChatHomePage(), ProfilePage()];
  List<Widget> appBarTexts = [
    Text("Settings"),
    Text("My Chats"),
    Text("Profile")
  ];
  static bool popUpSwitch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: appBarTexts[_currentIndex],
            ),
            body: pages[_currentIndex],
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onSelect: (int val) {
                setState(() {
                  _currentIndex = val;
                });
              },
            )));
  }
}
