// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/theme.dart';
import 'Screens/home_page.dart';
import 'Screens/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatChain());
}

class ChatChain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Chain',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        MessagesPage.id: (context) => MessagesPage()
      },
    );
  }
}
