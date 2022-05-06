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
      data: NavigationBarThemeData(indicatorColor: Colors.teal),
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
