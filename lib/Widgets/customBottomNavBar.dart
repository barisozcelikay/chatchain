// ignore_for_file: prefer_const_constructors

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
            selectedIcon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg",
              ),
            ),
            label: "Profile", // TODO Profile iconda olur.
            icon: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
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
