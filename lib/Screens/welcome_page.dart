// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:chatchain/Screens/login_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/animation/fadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static String id = "welcome_page";
  WelcomePage(this.isLogedOut, this.isDeletedAccount);

  final bool isLogedOut;
  final bool isDeletedAccount;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLogedIn = false;

  bool isDeletedAccount = false;

  bool isLogedOut = false;

  @override
  void initState() {
    isLogedOut = widget.isLogedOut;
    isDeletedAccount = widget.isDeletedAccount;
    if (isLogedOut || isDeletedAccount) {
      Future.delayed(Duration.zero, () {
        this.showSnackBar(isLogedOut, isDeletedAccount);
      });
    }
  }

  void showSnackBar(bool isLogedOut, bool isDeletedAccount) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.fixed,
      content: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLogedOut == true
              ? ListTile(
                  leading: Text("Loged Out"), trailing: Icon(Icons.logout))
              : ListTile(
                  leading: Text("Your account is deleted"),
                  trailing: Icon(Icons.delete),
                )
        ],
      )),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser?.uid);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Welcome to Chat Chain",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.2,
                      Text(
                        "Automatic identity verification which enables you to verify your identity",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      )),
                ],
              ),
              FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/chatchainlogo.png'))),
                  )),
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.6,
                      Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpPage.id);
                          },
                          color: Colors.yellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
