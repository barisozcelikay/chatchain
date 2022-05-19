// ignore_for_file: prefer_const_constructors

import 'package:chatchain/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendInfoPage extends StatelessWidget {
  FriendInfoPage(
      this.friend_name,
      this.friend_surname,
      this.last_message,
      this.last_time,
      this.friendUid,
      this.userUid,
      this.userName,
      this.userSurname);
  final String friend_name;
  final String friend_surname;
  final String last_message;
  final String last_time;
  final String friendUid;
  final String userUid;
  final String userName;
  final String userSurname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Informations",
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(""),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Name",
              style: TextStyle(fontSize: 25),
            ),
            Text(friend_name),
            SizedBox(
              height: 40,
            ),
            Text(
              "Surname",
              style: TextStyle(fontSize: 25),
            ),
            Text(friend_surname),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text("Add"),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userUid)
                      .collection("Friends")
                      .doc(friendUid)
                      .set({
                    'uid': friendUid,
                    'name': friend_name,
                    'surname': friend_surname,
                    'last_message': "",
                    'last_time': ""
                  });

                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(friendUid)
                      .collection("Friends")
                      .doc(userUid)
                      .set({
                    'uid': userUid,
                    'name': userName,
                    'surname': userSurname,
                    'last_message': "",
                    'last_time': ""
                  });

                  print("Arkadaş oldular");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
