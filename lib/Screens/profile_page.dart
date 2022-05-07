// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:flutter/material.dart';

import 'addFriend_page.dart';

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100.0,
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, ProfileQrPage.id),
                            child: Container(
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(border: Border.all()),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Show Qr"),
                                    Icon(Icons.qr_code)
                                  ]),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text("User Informations"),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Barış")
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Surname : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Özçelikay")
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "E-mail : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("baris.ozcelikay@tedu.edu.tr")
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("+90 598 764 65 43")
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Birthday : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("28th September 1999")
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
