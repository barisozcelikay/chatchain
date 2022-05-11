// ignore_for_file: prefer_const_constructors

import 'package:chatchain/Screens/addFriend_page.dart';
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
  int _currentIndex = 1;
  List<Widget> pages = [SettingsPage(), ChatHomePage(), ProfilePage()];
  List<Widget> appBarTexts = [
    Text("Settings"),
    Text("My Chats"),
    Text("Profile")
  ];
  static bool popUpSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: appBarTexts[_currentIndex],
          toolbarHeight: 100,
          actions: _currentIndex == 1
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AddFriendPage.id),
                        child: CircleAvatar(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person_add))),
                  )
                ]
              : null,
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onSelect: (int val) {
            setState(() {
              _currentIndex = val;
            });
          },
        ));
  }
}
