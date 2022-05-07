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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), //or 15.0
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    color: Color(0xffFF0E58),
                    child: Icon(Icons.qr_code, color: Colors.white, size: 50.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Add with Qr"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), //or 15.0
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    color: Color(0xffFF0E58),
                    child: Icon(Icons.numbers_sharp,
                        color: Colors.white, size: 50.0),
                  ),
                ),
                SizedBox(
                  height: 10,
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
