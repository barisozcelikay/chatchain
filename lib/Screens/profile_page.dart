import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0, // I get rid of the shadow of the appbar
      ),
      extendBodyBehindAppBar: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
            )
          ],
        ),
      ),
    );
  }
}
