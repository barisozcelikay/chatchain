// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/home_page.dart';
import 'package:chatchain/Screens/signup_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/animation/fadeAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<File> _fileFromImageUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(1.2, makeInput(label: "Email")),
                        FadeAnimation(1.3,
                            makeInput(label: "Password", obscureText: true)),
                      ],
                    ),
                  ),
                  /* FadeAnimation(
                      1.4,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
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
                            onPressed: () async {
                              print("Hello");
                              var a = await _auth.signInWithEmailAndPassword(
                                  email, password);

                              if (a != null) {
                                Userr? user =
                                    await FirebaseAuthService().getUserData();

                                Userr.sUid = user!.uid;
                                Userr.sdate_of_birth = user.date_of_birth;
                                Userr.semail = user.email;
                                Userr.sname = user.name;
                                Userr.sphotoUrl = user.photoUrl;
                                Userr.ssurname = user.surname;
                                var a = _fileFromImageUrl(user.photoUrl)
                                    as Future<File>;

                                Userr.static_image = a;
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomePage.id, (route) => false);
                              }
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                      */
                  FadeAnimation(
                    2,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(5),
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
                            onPressed: () async {
                              print("Hello");
                              var a = await _auth.signInWithEmailAndPassword(
                                  email, password);

                              if (a != null) {
                                Userr? user =
                                    await FirebaseAuthService().getUserData();

                                print("Baris");

                                Userr.sUid = user!.uid;
                                print(user.photoUrl);
                                Userr.sdate_of_birth = user.date_of_birth;
                                Userr.semail = user.email;
                                Userr.sname = user.name;
                                Userr.sphotoUrl = user.photoUrl;
                                Userr.ssurname = user.surname;

                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(user.uid)
                                    .update({'network_image': user.photoUrl});

                                var a = _fileFromImageUrl(user.photoUrl)
                                    as Future<File>;

                                Userr.static_image = a;
                                Navigator.pushNamedAndRemoveUntil(
                                    context, HomePage.id, (route) => false);
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2.2,
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
                            Navigator.pushReplacementNamed(
                                context, SignUpPage.id);
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
                  /*
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ))*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          onChanged: (val) {
            if (label == "Email") {
              setState(() {
                email = val;
              });
            } else {
              setState(() {
                password = val;
              });
            }
          },
          cursorColor: Colors.white,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            )),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Color.fromARGB(255, 102, 102, 147),
              width: 3,
            )),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
