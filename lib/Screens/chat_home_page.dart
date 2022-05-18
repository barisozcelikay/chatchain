// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Widgets/chatCard.dart';
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
              var last_time = docData["last_time"];

              return Expanded(
                child: ChatCard(
                  name: name,
                  surname: surname,
                  last_message: last_message,
                  last_time: last_time,
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagesPage(
                                name: name,
                                surname: surname,
                              ))),
                ),
              );
            });
      },
    );
  }
}
