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
      color: Colors.grey,
      width: double.infinity,
      padding: EdgeInsets.all(30),
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
                  child: Icon(Icons.settings),
                  onTap: () {
                    setState(() {});
                    showDialog(
                        context: context,
                        builder: (context) =>
                            StatefulBuilder(builder: (context, setState) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SwitchListTile(
                                        title: Text("Dark Mode"),
                                        value: popUpSwitch,
                                        onChanged: (val) {
                                          popUpSwitch = val;
                                          setState(() {});
                                        }),
                                    ListTile(
                                      leading: Text("Need Help"),
                                    ),
                                    ListTile(
                                      leading: Text("About Us"),
                                    ),
                                    ListTile(
                                      leading: Text("Privacy Policy"),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red)),
                                    child: Text(
                                      "Close",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }));
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          // SEARCH BAR
          Center(child: Text(popUpSwitch.toString())),
          SizedBox(
            height: 50,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(),
                            Text("Hash Value"),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
