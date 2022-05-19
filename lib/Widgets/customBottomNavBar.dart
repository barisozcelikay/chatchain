// ignore_for_file: prefer_const_constructors

import 'package:chatchain/Classes/userr.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelect;

  CustomBottomNavBar({
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(indicatorColor: Colors.white),
      child: NavigationBar(
        backgroundColor: Colors.white,
        height: 70,
        animationDuration: Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentIndex,
        onDestinationSelected: onSelect,
        // ignore: prefer_const_literals_to_create_immutables
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
            icon: Icon(Icons.settings),
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat_bubble),
            label: "Chats",
            icon: Icon(Icons.chat_bubble_outline),
          ),
          NavigationDestination(
            selectedIcon: Userr.sphotoUrl != ""
                ? CircleAvatar(
                    radius: 15.0,
                    backgroundImage: NetworkImage(Userr.sphotoUrl),
                    /*: FileImage(ProfilePage._image!)
                                    as ImageProvider,*/
                  )
                : CircleAvatar(
                    radius: 15.0,
                    backgroundImage: AssetImage('assets/images/no-profile.png'),
                  ),
            label: "Profile", // TODO Profile iconda olur.
            icon: Userr.sphotoUrl != ""
                ? CircleAvatar(
                    radius: 15.0,
                    backgroundImage: NetworkImage(Userr.sphotoUrl),
                    /*: FileImage(ProfilePage._image!)
                                    as ImageProvider,*/
                    backgroundColor: Colors.transparent,
                  )
                : CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage('assets/images/no-profile.png'),
                  ),
          ),
        ],
      ),
    );
  }
}
/*
NavigationBarTheme myCustomBottomNavBar(int _currentIndex, Function onSelect) {
  return NavigationBarTheme(
    data: NavigationBarThemeData(indicatorColor: Colors.teal),
    child: NavigationBar(
      backgroundColor: Colors.white,
      height: 70,
      animationDuration: Duration(seconds: 1),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: _currentIndex,
      onDestinationSelected: onSelect(),
      // ignore: prefer_const_literals_to_create_immutables
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.chat_bubble),
          label: "Chats",
          icon: Icon(Icons.chat_bubble_outline),
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          label: "Profile",
          icon: Icon(Icons.person_outline),
        ),
      ],
    ),
  );
}
*/
