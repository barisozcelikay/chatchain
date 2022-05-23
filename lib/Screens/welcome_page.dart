// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:chatchain/Screens/login_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/animation/fadeAnimation.dart';
import 'package:chatchain/constants.dart';
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

  bool changeLoginColor = false;

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
      backgroundColor: kappLightDarkenColor,
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
              Expanded(
                flex: 3,
                child: FadeAnimation(
                    2,
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/c.png'))),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    /* FadeAnimation(
                        2,
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
                        )), */
                    FadeAnimation(
                      3,
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 102, 102, 147)),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF1D1D35))),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      3.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account  ",
                            style: TextStyle(fontSize: 15),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.pushNamed(context, SignUpPage.id);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*RichText(
                      text: TextSpan(
                        text: 'Don\'t you have an account ',
                        style: TextStyle(fontSize: 15),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline)),
                        ],
                      ),
                    ),
*/
                    /*    FadeAnimation(
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
                        )) */
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
