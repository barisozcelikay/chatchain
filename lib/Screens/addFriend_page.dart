// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({Key? key}) : super(key: key);
  static String id = "addFriend_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.qr_code),
                ),
                Text("Add with Qr"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.numbers),
                ),
                Text("Add with Hash Value"),
              ],
            )
          ],
        ),
      )),
    );
  }
}
