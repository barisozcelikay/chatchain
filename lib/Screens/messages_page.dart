// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Widgets/chatBottom.dart';
import 'package:chatchain/Widgets/messageBubble.dart';
import 'package:chatchain/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
const k_mainColor = Color(0xFF0D47A1);

class MessagesPage extends StatefulWidget {
  const MessagesPage(
      {Key? key,
      required this.name,
      required this.surname,
      required this.friend_uid,
      required this.user_uid,
      required this.username,
      required this.usersurname,
      required this.network_image})
      : super(key: key);
  static String id = "messages_page";
  final String name;
  final String surname;
  final String friend_uid;
  final String user_uid;
  final String username;
  final String usersurname;
  final String network_image;

  static Color backgroundColor = Colors.white;
  static Decoration o = BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
      fit: BoxFit.cover,
    ),
  );

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool settings_pressed = false;

  late String name;
  late String surname;

  bool sendButton = false;

  void read() {
    _firestore
        .collection("Users")
        .doc(widget.user_uid)
        .collection("Friends")
        .doc(widget.friend_uid)
        .update({'readed': true});
  }

  @override
  void initState() {
    name = widget.name;
    surname = widget.surname;
    read();
  }

  showAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
          child: Image(
            fit: BoxFit.fitHeight,
            image: NetworkImage(widget.network_image),
          ),
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  late String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        automaticallyImplyLeading: true,
        backgroundColor: kappLightDarkenColor,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Hero(
                tag: "pp",
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.network_image),
                ),
              ),
            ),
            SizedBox(width: 20 * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name + " " + surname,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
        actions: [
          /*
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              icon: Icon(Icons.settings),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Change Background Color"),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: 15,
                        )
                      ],
                    ),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  print("My account menu is selected.");
                  MessagesPage.backgroundColor =
                      MessagesPage.backgroundColor == Colors.red
                          ? Colors.white
                          : Colors.red;
                  setState(() {});
                } else if (value == 1) {
                  print("Settings menu is selected.");
                } else if (value == 2) {
                  print("Logout menu is selected.");
                }
              }),
              */
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MessagesStream(
                      friend_uid: widget.friend_uid,
                      user_uid: widget.user_uid,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: kappLightDarkenColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0xFF087949).withOpacity(0.08),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  //Icon(Icons.mic, color: kPrimaryColor),
                  //SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: kappDarkenColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          /*Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.64),
                          ),
                          */
                          SizedBox(width: kDefaultPadding / 4),
                          Expanded(
                            child: TextField(
                              controller: messageTextController,
                              onChanged: (val) {
                                setState(() {
                                  messageText = val;
                                  if (messageText.length > 0) {
                                    sendButton = true;
                                  } else {
                                    sendButton = false;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          /*  if (sendButton != true)
                            Icon(
                              Icons.attach_file,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                          if (sendButton != true)
                            SizedBox(width: kDefaultPadding / 4),
                          if (sendButton != true)
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                            */

                          InkWell(
                            onTap: (sendButton == true)
                                ? () {
                                    final now = DateTime.now();
                                    var year = now.year;
                                    var month = now.month;
                                    var day = now.day;
                                    var hour = now.hour;
                                    var minute = now.minute;
                                    var second = now.second;

                                    //Implement send functionality.
                                    // UPDATE MESSAGES
                                    print(messageText);
                                    _firestore
                                        .collection("Users")
                                        .doc(widget.user_uid)
                                        .collection("Friends")
                                        .doc(widget.friend_uid)
                                        .collection("Messages")
                                        .add({
                                      'text': messageText,
                                      'sender': widget.username +
                                          " " +
                                          widget.usersurname,
                                      'sender_uid': widget.user_uid,
                                      'timestamp':
                                          Timestamp.fromDate(DateTime.now())
                                    });

                                    _firestore
                                        .collection("Users")
                                        .doc(widget.friend_uid)
                                        .collection("Friends")
                                        .doc(widget.user_uid)
                                        .collection("Messages")
                                        .add({
                                      'text': messageText,
                                      'sender': widget.username +
                                          " " +
                                          widget.usersurname,
                                      'sender_uid': widget.user_uid,
                                      'timestamp':
                                          Timestamp.fromDate(DateTime.now())
                                    });

                                    // UPDATE CHAT CARD

                                    _firestore
                                        .collection("Users")
                                        .doc(widget.user_uid)
                                        .collection("Friends")
                                        .doc(widget.friend_uid)
                                        .update({
                                      'last_message': messageText,
                                      'last_time':
                                          Timestamp.fromDate(DateTime.now()),
                                      'last_message_uid': widget.user_uid,
                                      'readed': true
                                    });

                                    _firestore
                                        .collection("Users")
                                        .doc(widget.friend_uid)
                                        .collection("Friends")
                                        .doc(widget.user_uid)
                                        .update({
                                      'last_message': messageText,
                                      'last_time':
                                          Timestamp.fromDate(DateTime.now()),
                                      'last_message_uid': widget.user_uid,
                                      'readed': false
                                    });

                                    messageTextController.clear();
                                    setState(() {
                                      messageText = "";
                                      sendButton = false;
                                    });
                                  }
                                : null,
                            child: Icon(
                              Icons.send,
                              color: sendButton == true
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream(
      {Key? key, required this.friend_uid, required this.user_uid})
      : super(key: key);

  final String friend_uid;
  final String user_uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("Users")
          .doc(user_uid)
          .collection("Friends")
          .doc(friend_uid)
          .collection("Messages")
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.get("text");
          final messageSender = message.get("sender");
          final senderUid = message.get("sender_uid");

          Timestamp last_time = message.get("timestamp");

          var day = last_time.toDate().day.toString();
          day = day.length == 2 ? day : "0$day";

          var month = last_time.toDate().month.toString();
          month = month.length == 2 ? month : "0$month";

          var hour = last_time.toDate().hour.toString();
          hour = hour.length == 2 ? hour : "0$hour";

          var minute = last_time.toDate().minute.toString();
          minute = minute.length == 2 ? minute : "0$minute";

          String last_time_string =
              hour + ":" + minute + "-" + day + "/" + month;

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: senderUid == user_uid,
            time: last_time_string,
          );
          if (messageBubble != "" && messageSender != "") {
            messageBubbles.add(messageBubble);
          }
        }

        return Expanded(
            child: ListView(reverse: true, children: messageBubbles));
      },
    );
  }
}
