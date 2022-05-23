// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatchain/Screens/aboutUs_page.dart';
import 'package:chatchain/Screens/addFriend_page.dart';
import 'package:chatchain/Screens/login_page.dart';
import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:chatchain/Screens/qrCodeScanner_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/Screens/test.dart';
import 'package:chatchain/Screens/test_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/Screens/welcome_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatChain());
}

class ChatChain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Chain',
      debugShowCheckedModeBanner: false,
      theme: darkThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomePage(false, false),
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        LoginPage.id: (context) => LoginPage(),
        HomePage.id: (context) => HomePage(),
        AddFriendPage.id: (context) => AddFriendPage(),
        ProfileQrPage.id: (context) => ProfileQrPage(),
        QrCodeScannerPage.id: (context) => QrCodeScannerPage(),
        AboutUsPage.id: (context) => AboutUsPage(),
      },
    );
  }
}
