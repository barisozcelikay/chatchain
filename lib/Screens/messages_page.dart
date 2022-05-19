// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Widgets/chatBottom.dart';
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
      required this.usersurname})
      : super(key: key);
  static String id = "messages_page";
  final String name;
  final String surname;
  final String friend_uid;
  final String user_uid;
  final String username;
  final String usersurname;

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

  @override
  void initState() {
    name = widget.name;
    surname = widget.surname;
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
          image: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
        ),
      ),
    );

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
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: Hero(
                tag: "pp",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
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
                Text(
                  "Active 3m ago",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
        actions: [
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

          /*
          Visibility(
              visible: settings_pressed,
              child: Stack(
                children: [
                  Positioned(
                      right: 10,
                      child: Container(
                        height: 10,
                        width: 10,
                        child: Text("hello"),
                      ))
                ],
              )),
          Visibility(
            visible: !settings_pressed,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                setState(() {
                  settings_pressed = settings_pressed == true ? false : true;
                });
              },
            ),
          ),
          */
          //SizedBox(width: 20 / 2),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: MessagesPage.backgroundColor == Colors.white
                  ? MessagesPage.o
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MessagesStream(
                      friend_uid: widget.friend_uid,
                      user_uid: widget.user_uid,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: k_mainColor, width: 2.0),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: messageTextController,
                              onChanged: (value) {
                                //Do something with the user input.
                                setState(() {
                                  messageText = value;
                                });
                              },
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              messageTextController.clear();
                              //Implement send functionality.
                              _firestore
                                  .collection("Users")
                                  .doc(widget.user_uid)
                                  .collection("Friends")
                                  .doc(widget.friend_uid)
                                  .collection("Messages")
                                  .add({
                                'text': messageText,
                                'sender':
                                    widget.username + " " + widget.usersurname
                              });

                              _firestore
                                  .collection("Users")
                                  .doc(widget.friend_uid)
                                  .collection("Friends")
                                  .doc(widget.user_uid)
                                  .collection("Messages")
                                  .add({
                                'text': messageText,
                                'sender':
                                    widget.username + " " + widget.usersurname
                              });
                            },
                            child: Text(
                              'Send',
                              style: kSendButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //ChatBottom(),
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

          final currenUser = FirebaseAuthService().getUserData();
          if (currenUser == messageSender) {
            // This is ME
          }

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currenUser == messageSender,
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

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});

  final sender;
  final text;
  final isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 10.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white54,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
