// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Widgets/chatBottom.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static String id = "messages_page";
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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: MessagesPage.backgroundColor == Colors.white
                    ? MessagesPage.o
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Text("Hello"),
                  ),
                ),
              ),
            ),
            ChatBottom(),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(val) {
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
      Visibility(
        visible: val,
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            val = val == true ? false : true;
            print(val);
          },
        ),
      ),
      SizedBox(width: 20 / 2),
    ],
  );
}
