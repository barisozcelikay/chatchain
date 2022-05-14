// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatchain/Screens/aboutUs_page.dart';
import 'package:chatchain/Screens/addFriend_page.dart';
import 'package:chatchain/Screens/login_page.dart';
import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:chatchain/Screens/qrCodeScanner_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/Screens/test_page.dart';
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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Chat Chain',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: WelcomePage(),
        routes: {
          WelcomePage.id: (context) => WelcomePage(),
          SignupPage.id: (context) => SignupPage(),
          LoginPage.id: (context) => LoginPage(),
          HomePage.id: (context) => HomePage(),
          MessagesPage.id: (context) => MessagesPage(),
          AddFriendPage.id: (context) => AddFriendPage(),
          ProfileQrPage.id: (context) => ProfileQrPage(),
          QrCodeScannerPage.id: (context) => QrCodeScannerPage(),
          AboutUsPage.id: (context) => AboutUsPage(),
        },
      ),
    );
  }
}
