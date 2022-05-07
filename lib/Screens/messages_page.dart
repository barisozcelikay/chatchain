// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Widgets/chatBottom.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static String id = "messages_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Text("Hello"),
              ),
            ),
          ),
          ChatBottom(),
        ],
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        BackButton(),
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg"),
        ),
        SizedBox(width: 20 * 0.75),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kristin Watson",
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
      IconButton(
        icon: Icon(Icons.local_phone),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.videocam),
        onPressed: () {},
      ),
      SizedBox(width: 20 / 2),
    ],
  );
}
