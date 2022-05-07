// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Screens/messages_page.dart';
import 'package:chatchain/constants.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  static bool popUpSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 30, right: 30, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "My Chats",
                  style: TextStyle(fontSize: 25),
                ),
                InkWell(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.person_add,
                        color: Colors.black,
                      )),
                  onTap: () {},
                )
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 50,
          ),
          // SEARCH BAR
          Center(child: Text(popUpSwitch.toString())),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MessagesPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
                                ),
                                Text("Hash Value"),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }
}
