// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Widgets/chatCard.dart';
import 'package:chatchain/animation/fadeAnimation.dart';
import 'package:chatchain/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection("Friends")
          .orderBy("last_time", descending: true)
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (!snapshot.hasData) {
          print("No My Name is");
          return const SizedBox.shrink();
        }
        print(FirebaseAuth.instance.currentUser?.uid.toString());

        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final docData = snapshot.data!.docs[index];
              /*final dateTime =
                  (docData["timestamp"] as Timestamp).toDate(); */
              var name = docData["name"];
              var surname = docData["surname"];
              var last_message = docData["last_message"];
              Timestamp last_time = docData["last_time"];
              var uid = docData["uid"];

              var last_uid = docData["last_message_uid"];

              var readed = docData["readed"];

              var day = last_time.toDate().day.toString();
              day = day.length == 2 ? day : "0$day";

              var month = last_time.toDate().month.toString();
              month = month.length == 2 ? month : "0$month";

              var hour = last_time.toDate().hour.toString();
              hour = hour.length == 2 ? hour : "0$hour";

              var minute = last_time.toDate().minute.toString();
              minute = minute.length == 2 ? minute : "0$minute";

              String last_time_string =
                  hour + ":" + minute + "\n" + day + "/" + month;

              print(last_time);

              return FadeAnimation(
                0.5 * index,
                Expanded(
                  child: ChatCard(
                    name: name,
                    surname: surname,
                    last_message: last_message,
                    last_time: last_time_string,
                    last_uid: last_uid,
                    user_uid: FirebaseAuth.instance.currentUser!.uid,
                    readed: readed,
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagesPage(
                                name: name,
                                surname: surname,
                                friend_uid: uid,
                                user_uid:
                                    FirebaseAuth.instance.currentUser!.uid,
                                username: Userr.sname,
                                usersurname: Userr.ssurname))),
                  ),
                ),
              );
            });
      },
    );
  }
}
